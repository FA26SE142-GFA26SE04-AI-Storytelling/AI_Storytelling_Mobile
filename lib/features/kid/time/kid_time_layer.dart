import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/kid_panel.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../models/reading_time_dto.dart';
import 'reading_time_logic.dart';

/// Chuyển đổi chuỗi mood của RestCopy sang [TtFrogMood].
TtFrogMood _toFrogMood(String mood) {
  switch (mood) {
    case 'happy':
      return TtFrogMood.happy;
    case 'think':
      return TtFrogMood.think;
    case 'idle':
    default:
      return TtFrogMood.idle;
  }
}

/// Màn nghỉ / màn chặn phủ lên giao diện của bé khi không được đọc.
/// Hiển thị linh vật ếch, tiêu đề, câu gợi ý, đồng hồ đếm ngược và nút thoát về bố mẹ.
class KidRestOverlay extends StatefulWidget {
  const KidRestOverlay({
    super.key,
    required this.status,
    required this.onDone,
    this.onExit,
  });

  final ReadingTimeStatusDto status;
  final VoidCallback onDone;

  /// null: không hiện nút "Về với bố mẹ" (màn nghỉ trong truyện).
  final VoidCallback? onExit;

  @override
  State<KidRestOverlay> createState() => _KidRestOverlayState();
}

class _KidRestOverlayState extends State<KidRestOverlay> {
  Timer? _timer;
  bool _doneCalled = false;

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
    _checkFinished();
  }

  @override
  void didUpdateWidget(KidRestOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      final oldCopy = restCopy(oldWidget.status);
      final newCopy = restCopy(widget.status);
      if (oldCopy.until != newCopy.until) {
        _doneCalled = false;
        _timer?.cancel();
        _startTimerIfNeeded();
      }
      _checkFinished();
    }
  }

  void _startTimerIfNeeded() {
    final copy = restCopy(widget.status);
    if (copy.until != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() {});
        _checkFinished();
      });
    }
  }

  void _checkFinished() {
    final copy = restCopy(widget.status);
    if (copy.until != null) {
      final left = secondsUntil(copy.until!, DateTime.now());
      if (left == 0) {
        _timer?.cancel();
        if (!_doneCalled) {
          _doneCalled = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onDone();
            }
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final copy = restCopy(widget.status);
    final until = copy.until;
    final left = until != null ? secondsUntil(until, DateTime.now()) : null;

    return PopScope(
      canPop: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lớp phủ chặn hoàn toàn bấm xuyên xuống dưới và làm tối nền mờ
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.65),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: KidPanel(
                  borderColor: tt.goldDeep,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TtFrog(
                        mood: _toFrogMood(copy.mood),
                        size: 130,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        copy.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: tt.text,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        copy.hint,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: tt.muted,
                            ),
                      ),
                      if (until != null && left != null) ...[
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time, size: 20, color: tt.text),
                            const SizedBox(width: 8),
                            Text(
                              copy.label,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: tt.text,
                                  ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              formatCountdown(left),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: tt.text,
                                  ),
                            ),
                          ],
                        ),
                      ],
                      if (widget.onExit != null) ...[
                        const SizedBox(height: 24),
                        KidBtn3D(
                          label: 'Về với bố mẹ',
                          icon: Icons.home_rounded,
                          color: tt.gold,
                          foregroundColor: tt.text,
                          expand: true,
                          onPressed: widget.onExit,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dải cảnh báo mỏng khi sắp hết giờ (EndingSoon) hoặc đang cho đọc nốt (Grace).
/// Tự động cập nhật mỗi giây, ẩn khi ngoài 2 trạng thái này.
class KidTimeBanner extends StatefulWidget {
  const KidTimeBanner({
    super.key,
    required this.status,
  });

  final ReadingTimeStatusDto? status;

  @override
  State<KidTimeBanner> createState() => _KidTimeBannerState();
}

class _KidTimeBannerState extends State<KidTimeBanner> {
  Timer? _timer;

  bool get _isWarning =>
      widget.status?.state == 'EndingSoon' || widget.status?.state == 'Grace';

  @override
  void initState() {
    super.initState();
    _syncTimer();
  }

  @override
  void didUpdateWidget(KidTimeBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _syncTimer();
    }
  }

  void _syncTimer() {
    _timer?.cancel();
    if (_isWarning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isWarning) {
      return const SizedBox.shrink();
    }

    final line = warnLine(widget.status, DateTime.now());
    if (line == null) {
      return const SizedBox.shrink();
    }

    final tt = context.tt;
    final isGrace = widget.status?.state == 'Grace';
    final borderColor = isGrace ? tt.danger : tt.goldDeep;
    final bgColor = isGrace
        ? Color.alphaBlend(tt.danger.withValues(alpha: 0.14), tt.panel)
        : Color.alphaBlend(tt.gold.withValues(alpha: 0.28), tt.panel);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 20, color: tt.text),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              line,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: tt.text,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget bọc `child` kiểm tra thời gian đọc của bé.
/// Nếu trạng thái là chặn (`isBlocking`), phủ `KidRestOverlay` lên child.
class KidTimeGate extends StatelessWidget {
  const KidTimeGate({
    super.key,
    required this.status,
    required this.child,
    required this.onDone,
    this.onExit,
  });

  final ReadingTimeStatusDto? status;
  final Widget child;
  final VoidCallback onDone;
  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    if (!isBlocking(status)) {
      return child;
    }

    return Stack(
      children: [
        child,
        KidRestOverlay(
          status: status!,
          onDone: onDone,
          onExit: onExit,
        ),
      ],
    );
  }
}
