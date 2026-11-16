import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';

/// Thanh điều khiển đáy của màn đọc truyện cho bé.
class KidReaderBottomBar extends StatelessWidget {
  const KidReaderBottomBar({
    super.key,
    required this.canGoPrev,
    required this.canGoNext,
    required this.isAudioPlaying,
    required this.isAudioAvailable,
    required this.onPrev,
    required this.onNext,
    required this.onToggleAudio,
    required this.onMicTap,
    this.isRecording = false,
    this.isSending = false,
  });

  /// Cho phép lùi về trang trước (false thì nút mờ và không bấm).
  final bool canGoPrev;

  /// Cho phép tiến sang trang sau (false thì nút mờ và không bấm).
  final bool canGoNext;

  /// Trạng thái đang phát âm thanh đọc truyện.
  final bool isAudioPlaying;

  /// Có âm thanh khả dụng hay không (false thì nút mờ và không bấm).
  final bool isAudioAvailable;

  /// Callback chuyển về trang trước.
  final VoidCallback onPrev;

  /// Callback chuyển tiếp sang trang sau.
  final VoidCallback onNext;

  /// Callback bật / tạm dừng phát âm thanh.
  final VoidCallback onToggleAudio;

  /// Chạm để bắt đầu/dừng đọc to đoạn đang hiện.
  final VoidCallback onMicTap;

  /// Trạng thái đang ghi âm đọc to.
  final bool isRecording;

  /// Trạng thái đang gửi giọng đọc để chấm điểm.
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Container(
      decoration: BoxDecoration(
        color: tt.panel,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(TtRadius.xl),
        ),
        border: Border(
          top: BorderSide(color: tt.line, width: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: tt.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // 1. Nút quay lại trang trước
              Expanded(
                child: Center(
                  child: _ReaderCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    tooltip: 'Trang trước',
                    isEnabled: canGoPrev,
                    onTap: canGoPrev ? onPrev : null,
                    opacity: canGoPrev ? 1.0 : 0.35,
                  ),
                ),
              ),
              // 2. Nút đọc to / tạm dừng âm thanh
              Expanded(
                child: Center(
                  child: _ReaderCircleButton(
                    icon: isAudioPlaying
                        ? Icons.stop_rounded
                        : Icons.volume_up_rounded,
                    tooltip: isAudioPlaying ? 'Dừng đọc' : 'Đọc to',
                    isEnabled: isAudioAvailable,
                    onTap: isAudioAvailable ? onToggleAudio : null,
                    opacity: isAudioAvailable ? 1.0 : 0.35,
                    backgroundColor: isAudioPlaying
                        ? tt.gold.withValues(alpha: 0.25)
                        : tt.surface,
                    borderColor: isAudioPlaying
                        ? tt.goldDeep.withValues(alpha: 0.6)
                        : tt.line,
                    iconColor: isAudioPlaying ? tt.goldDeep : tt.text,
                  ),
                ),
              ),
              // 3. Nút micro
              Expanded(
                child: Center(
                  child: isSending
                      ? _ReaderCircleButton(
                          tooltip: 'Đang chấm...',
                          isEnabled: false,
                          onTap: null,
                          opacity: 1.0,
                          child: SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: tt.goldDeep,
                            ),
                          ),
                        )
                      : isRecording
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _ReaderCircleButton(
                                  icon: Icons.stop_rounded,
                                  tooltip: 'Dừng đọc',
                                  isEnabled: true,
                                  onTap: onMicTap,
                                  opacity: 1.0,
                                  backgroundColor: tt.danger,
                                  borderColor: tt.danger,
                                  iconColor: Colors.white,
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: tt.danger,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _ReaderCircleButton(
                              icon: Icons.mic_rounded,
                              tooltip: 'Đọc to cho truyện nghe',
                              isEnabled: true,
                              onTap: onMicTap,
                              opacity: 1.0,
                            ),
                ),
              ),
              // 4. Nút sang trang sau
              Expanded(
                child: Center(
                  child: _ReaderCircleButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    tooltip: 'Trang sau',
                    isEnabled: canGoNext,
                    onTap: canGoNext ? onNext : null,
                    opacity: canGoNext ? 1.0 : 0.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReaderCircleButton extends StatelessWidget {
  const _ReaderCircleButton({
    this.icon = Icons.circle,
    required this.tooltip,
    required this.isEnabled,
    required this.onTap,
    required this.opacity,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.child,
  });

  final IconData icon;
  final String tooltip;
  final bool isEnabled;
  final VoidCallback? onTap;
  final double opacity;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Widget? child;

  static const double _buttonSize = 64.0;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final effectiveBg = backgroundColor ?? tt.surface;
    final effectiveBorder = borderColor ?? tt.line;
    final effectiveIconColor = iconColor ?? tt.text;
    final isClickable = isEnabled && onTap != null;

    return Semantics(
      label: tooltip,
      button: true,
      enabled: isClickable,
      child: Tooltip(
        message: tooltip,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: opacity,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: isClickable ? onTap : null,
              customBorder: const CircleBorder(),
              splashColor: tt.primary.withValues(alpha: 0.15),
              highlightColor: tt.primary.withValues(alpha: 0.08),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: _buttonSize,
                height: _buttonSize,
                decoration: BoxDecoration(
                  color: effectiveBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: effectiveBorder, width: 1.5),
                ),
                alignment: Alignment.center,
                child: child ??
                    Icon(
                      icon,
                      size: 28,
                      color: effectiveIconColor,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
