import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../models/content_category_dto.dart';
import '../../../models/safety_policy_dto.dart';

class SafetyRulesForm extends StatelessWidget {
  const SafetyRulesForm({
    super.key,
    required this.policy,
    required this.categories,
    required this.onChanged,
    this.enabled = true,
    this.showReadingSettings = true,
  });

  /// SafetyPolicyDto hiện tại (đã lưu).
  final SafetyPolicyDto policy;

  /// Danh sách ContentCategoryDto, được lọc isActive trong widget.
  final List<ContentCategoryDto> categories;

  /// Callback trả về SafetyPolicyDto mới (copyWith), không tự gọi API.
  final ValueChanged<SafetyPolicyDto> onChanged;

  /// Khi false, mọi control bị khoá.
  final bool enabled;

  /// False: chỉ hiện nhóm "Chủ đề nội dung" (wizard tạo bé tự lo các công tắc).
  final bool showReadingSettings;

  Widget _switchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return SwitchListTile(
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: tt.text,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodySmall?.copyWith(color: tt.muted),
      ),
      value: value,
      onChanged: enabled ? onChanged : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      activeThumbColor: tt.primaryStrong,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final activeCategories = categories.where((c) => c.isActive).toList();

    return Column(
      // stretch: hai thẻ luôn rộng hết khung, không co theo nội dung.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Nhóm 1: Khi bé đọc
        if (showReadingSettings) ...[
          TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Khi bé đọc',
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: tt.text),
                  ),
                ),
                const SizedBox(height: 8),
                _switchTile(
                  context,
                  title: 'Hỏi mật khẩu khi thoát',
                  subtitle: 'Bé cần mật khẩu của bạn để thoát chế độ bé',
                  value: policy.parentalGateEnabled,
                  onChanged: (v) =>
                      onChanged(policy.copyWith(parentalGateEnabled: v)),
                ),
                _switchTile(
                  context,
                  title: 'Bé gửi điều ước',
                  subtitle: 'Bé chọn thẻ hình, bạn xem và quyết định',
                  value: policy.storyWishesEnabled ?? false,
                  onChanged: (v) =>
                      onChanged(policy.copyWith(storyWishesEnabled: v)),
                ),
                _switchTile(
                  context,
                  title: 'Tương tác khi nghe',
                  subtitle: 'Đoán tranh, điền chữ, sắp xếp sự kiện',
                  value: policy.allowInteractiveStories ?? false,
                  onChanged: (v) =>
                      onChanged(policy.copyWith(allowInteractiveStories: v)),
                ),
                _switchTile(
                  context,
                  title: 'Trả lời bằng giọng nói',
                  subtitle: 'Ghi âm kể lại truyện và luyện đọc to',
                  value: policy.voiceAnswersEnabled ?? false,
                  onChanged: (v) =>
                      onChanged(policy.copyWith(voiceAnswersEnabled: v)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        // Nhóm 2: Chủ đề nội dung
        TtCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Chủ đề nội dung',
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold, color: tt.text),
                ),
              ),
              const SizedBox(height: 12),
              if (activeCategories.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Text(
                    'Chưa có chủ đề nội dung nào.',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: tt.muted),
                  ),
                )
              else
                ...activeCategories.map((category) {
                  final matchingRule = policy.categories
                      .where((r) => r.contentCategoryId == category.id)
                      .firstOrNull
                      ?.rule;
                  final currentRule = (matchingRule == 'Blocked')
                      ? 'Blocked'
                      : 'Allowed';
                  final isBlockedSelected = currentRule == 'Blocked';

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    // Tên chủ đề và nút chọn cùng một hàng cho danh sách gọn.
                    child: Row(
                      // Đẩy nút chọn về mép phải ở màn rộng.
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            category.displayName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: tt.text),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Flexible: màn hẹp thì nút tự thu nhỏ, không tràn.
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: SegmentedButton<String>(
                              segments: const [
                                ButtonSegment<String>(
                                  value: 'Allowed',
                                  label: Text('Cho phép'),
                                ),
                                ButtonSegment<String>(
                                  value: 'Blocked',
                                  label: Text('Chặn'),
                                ),
                              ],
                              selected: {currentRule},
                              showSelectedIcon: false,
                              onSelectionChanged: enabled
                                  ? (newSelection) {
                                      final newRule = newSelection.first;
                                      final updatedCategories =
                                          policy.categories
                                              .where(
                                                (r) =>
                                                    r.contentCategoryId !=
                                                    category.id,
                                              )
                                              .toList()
                                            ..add(
                                              SafetyCategoryRuleDto(
                                                contentCategoryId: category.id,
                                                rule: newRule,
                                              ),
                                            );
                                      onChanged(
                                        policy.copyWith(
                                          categories: updatedCategories,
                                        ),
                                      );
                                    }
                                  : null,
                              style: ButtonStyle(
                                visualDensity: VisualDensity.compact,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor:
                                    WidgetStateProperty.resolveWith((states) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return isBlockedSelected
                                            ? tt.danger.withValues(alpha: 0.15)
                                            : tt.primaryStrong;
                                      }
                                      return null;
                                    }),
                                foregroundColor:
                                    WidgetStateProperty.resolveWith((states) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return isBlockedSelected
                                            ? tt.danger
                                            : Colors.white;
                                      }
                                      return tt.text;
                                    }),
                                side: WidgetStateProperty.resolveWith((states) {
                                  return BorderSide(color: tt.line2);
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
