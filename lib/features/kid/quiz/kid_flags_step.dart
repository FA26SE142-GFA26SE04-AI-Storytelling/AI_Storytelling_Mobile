import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';

/// Bước chọn các cảnh còn thắc mắc để gửi cho phụ huynh.
class KidFlagsStep extends ConsumerStatefulWidget {
  const KidFlagsStep({
    super.key,
    required this.sessionId,
    required this.scenes,
    required this.onNext,
    this.isLast = false,
  });

  final int sessionId;
  final List<ReadingScene> scenes;
  final VoidCallback onNext;
  final bool isLast;

  @override
  ConsumerState<KidFlagsStep> createState() => _KidFlagsStepState();
}

class _KidFlagsStepState extends ConsumerState<KidFlagsStep> {
  final Set<int> _selectedSceneIds = <int>{};
  bool _sending = false;
  bool _isSent = false;
  String? _sentMessage;

  void _toggleScene(int sceneId) {
    if (_isSent || _sending) return;

    if (_selectedSceneIds.contains(sceneId)) {
      setState(() {
        _selectedSceneIds.remove(sceneId);
      });
    } else {
      if (_selectedSceneIds.length >= kSummaryMaxFlags) {
        showTtToast(
          context,
          'Em chọn tối đa $kSummaryMaxFlags cảnh thôi nhé.',
          type: TtToastType.info,
        );
        return;
      }
      setState(() {
        _selectedSceneIds.add(sceneId);
      });
    }
  }

  Future<void> _sendFlags() async {
    if (_sending || _isSent || _selectedSceneIds.isEmpty) return;

    setState(() {
      _sending = true;
    });

    try {
      final repo = ref.read(kidReadingRepositoryProvider);
      final result = await repo.summaryFlags(
        widget.sessionId.toString(),
        sceneIds: _selectedSceneIds.toList(),
      );

      if (!mounted) return;

      setState(() {
        _sending = false;
        _isSent = true;
        _sentMessage = result.message;
      });

      showTtToast(context, result.message, type: TtToastType.success);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _sending = false;
      });

      final message = e is ApiException
          ? e.message
          : 'Có lỗi xảy ra, em thử lại nhé.';
      showTtToast(context, message, type: TtToastType.error);
    }
  }

  Widget _buildSceneChip(ReadingScene scene, TtColors tt) {
    final isSelected = _selectedSceneIds.contains(scene.sceneId);
    final sceneNumber = scene.sceneIndex + 1;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (_sending || _isSent) ? null : () => _toggleScene(scene.sceneId),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minHeight: 64, minWidth: 120),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? tt.gold.withValues(alpha: 0.25) : tt.panel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? tt.goldDeep : tt.line2,
              width: isSelected ? 2.5 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: tt.goldDeep.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) ...[
                Icon(Icons.check_rounded, color: tt.goldDeep, size: 24),
                const SizedBox(width: 8),
              ],
              Text(
                'Cảnh $sceneNumber',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? tt.warnInk : tt.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final hasScenes = widget.scenes.isNotEmpty;

    return Column(
      children: [
        // Phần thân có thể cuộn
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Linh vật ếch nhún một lần khi phản ứng gửi thành công
                TtFrog(
                      mood: _isSent ? TtFrogMood.happy : TtFrogMood.think,
                      size: 96,
                    )
                    .animate(target: _isSent ? 1 : 0)
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.15, 1.15),
                      duration: 250.ms,
                      curve: Curves.easeOutBack,
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.15, 1.15),
                      end: const Offset(1, 1),
                      duration: 250.ms,
                      curve: Curves.easeIn,
                    ),
                const SizedBox(height: 16),

                // Tiêu đề
                Text(
                  'Chỗ nào em còn thắc mắc?',
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Phụ đề
                Text(
                  'Chọn tối đa $kSummaryMaxFlags cảnh để bố mẹ cùng xem nhé',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: tt.muted,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Danh sách chip các cảnh hoặc thông báo rỗng
                if (hasScenes) ...[
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: widget.scenes
                        .map((scene) => _buildSceneChip(scene, tt))
                        .toList(),
                  ),
                  const SizedBox(height: 28),

                  // Nút gửi hoặc dòng xác nhận đã gửi thành công
                  if (_isSent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: tt.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: tt.primary.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: tt.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              _sentMessage ?? 'Đã gửi cho bố mẹ thành công!',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: tt.text,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms)
                  else
                    SizedBox(
                      height: 64,
                      width: double.infinity,
                      child: TtButton(
                        label: 'Gửi bố mẹ',
                        icon: Icons.send_rounded,
                        isLoading: _sending,
                        onPressed: (!_sending && _selectedSceneIds.isNotEmpty)
                            ? _sendFlags
                            : null,
                      ),
                    ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'Truyện này chưa có cảnh để chọn.',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: tt.muted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Footer cố định dưới đáy
        Padding(
          padding: const EdgeInsets.all(24),
          child: hasScenes
              ? Row(
                  children: [
                    // Nút Bỏ qua
                    Expanded(
                      child: SizedBox(
                        height: 64,
                        child: TtButton(
                          variant: TtButtonVariant.secondary,
                          label: 'Bỏ qua',
                          onPressed: _sending ? null : widget.onNext,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Nút Tiếp / Về trang chính
                    Expanded(
                      child: SizedBox(
                        height: 64,
                        child: TtButton(
                          variant: TtButtonVariant.primary,
                          label: widget.isLast ? 'Về trang chính' : 'Tiếp',
                          icon: widget.isLast ? Icons.home_rounded : null,
                          onPressed: _sending ? null : widget.onNext,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  height: 64,
                  width: double.infinity,
                  child: TtButton(
                    variant: TtButtonVariant.primary,
                    label: widget.isLast ? 'Về trang chính' : 'Tiếp',
                    icon: widget.isLast ? Icons.home_rounded : null,
                    onPressed: _sending ? null : widget.onNext,
                  ),
                ),
        ),
      ],
    );
  }
}
