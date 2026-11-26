import 'dart:math' show max;

import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_adaptive.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../models/content_category_dto.dart';
import '../../../models/safety_policy_dto.dart';
import '../../children/presentation/child_age_presets.dart';

String _formatThousands(int number) {
  return number.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
}

class _ChildFeatureItem {
  const _ChildFeatureItem({
    required this.field,
    required this.label,
    required this.hint,
    this.warning,
  });

  final String field;
  final String label;
  final String hint;
  final String? warning;
}

const _kChildFeatures = <_ChildFeatureItem>[
  _ChildFeatureItem(
    field: 'quizEnabled',
    label: 'Câu đố sau truyện',
    hint: 'Bé trả lời vài câu hỏi ngắn sau khi đọc xong',
    warning:
        'Tắt câu đố thì EXP và tiến độ lộ trình từ câu đố không được tính.',
  ),
  _ChildFeatureItem(
    field: 'notebookEnabled',
    label: 'Sổ từ vựng',
    hint: 'Bé lưu từ mới vào sổ để xem lại',
  ),
  _ChildFeatureItem(
    field: 'libraryBrowseEnabled',
    label: 'Tìm truyện trong thư viện',
    hint: 'Tắt thì bé chỉ đọc truyện trong lộ trình và truyện gia đình',
  ),
  _ChildFeatureItem(
    field: 'reflectionEnabled',
    label: 'Cảm nhận sau truyện',
    hint: 'Bé chọn cảm xúc, cảnh thích nhất và ghi lại cảm nhận',
  ),
  _ChildFeatureItem(
    field: 'rewardsEnabled',
    label: 'Phần thưởng và cây kiến thức',
    hint: 'Bé xem huy hiệu và tưới cây kiến thức',
  ),
];

bool _getChildFeatureValue(SafetyPolicyDto policy, String field) {
  switch (field) {
    case 'quizEnabled':
      return policy.quizEnabled ?? true;
    case 'notebookEnabled':
      return policy.notebookEnabled ?? true;
    case 'libraryBrowseEnabled':
      return policy.libraryBrowseEnabled ?? true;
    case 'reflectionEnabled':
      return policy.reflectionEnabled ?? true;
    case 'rewardsEnabled':
      return policy.rewardsEnabled ?? true;
    default:
      return true;
  }
}

SafetyPolicyDto _updateChildFeature(
  SafetyPolicyDto policy,
  String field,
  bool value,
) {
  switch (field) {
    case 'quizEnabled':
      return policy.copyWith(quizEnabled: value);
    case 'notebookEnabled':
      return policy.copyWith(notebookEnabled: value);
    case 'libraryBrowseEnabled':
      return policy.copyWith(libraryBrowseEnabled: value);
    case 'reflectionEnabled':
      return policy.copyWith(reflectionEnabled: value);
    case 'rewardsEnabled':
      return policy.copyWith(rewardsEnabled: value);
    default:
      return policy;
  }
}

class SafetyRulesForm extends StatefulWidget {
  const SafetyRulesForm({
    super.key,
    required this.policy,
    required this.categories,
    required this.onChanged,
    this.enabled = true,
    this.showReadingSettings = true,
    this.readingLevel,
    this.ageBand,
    this.trailingLeft = const [],
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

  /// Chỉ dùng khi showReadingSettings true.
  final int? readingLevel;

  /// Chỉ dùng khi showReadingSettings true.
  final String? ageBand;

  /// Thẻ thêm vào cuối cột trái (vd. Điều khoản do màn cha truyền vào).
  final List<Widget> trailingLeft;

  @override
  State<SafetyRulesForm> createState() => _SafetyRulesFormState();
}

class _SafetyRulesFormState extends State<SafetyRulesForm> {
  double? _dragSafety;
  double? _dragReadability;
  double? _dragLen;
  double? _dragComp;

  SafetyPolicyDto get policy => widget.policy;
  ValueChanged<SafetyPolicyDto> get onChanged => widget.onChanged;
  bool get enabled => widget.enabled;
  bool get showReadingSettings => widget.showReadingSettings;
  List<ContentCategoryDto> get categories => widget.categories;

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
    final textTheme = Theme.of(context).textTheme;
    final activeCategories = categories.where((c) => c.isActive).toList();
    final level = widget.readingLevel ?? 1;
    final band = widget.ageBand ?? 'Age_6_8';
    final effective = effectiveStoryLength(
      band,
      level,
      policy.storyLengthTarget,
      policy.maxStoryLength,
    );
    final displayedLength = _dragLen?.round() ?? effective.value;
    final lengthBounds = storyLengthBounds(displayedLength);
    final advice = effective.custom
        ? storyLengthAdvice(band, level, displayedLength)
        : null;

    return TtAdaptiveColumns(
      left: [
        if (showReadingSettings) ...[
          // Nhóm: Chế độ duyệt
          TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Chế độ duyệt',
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: tt.text),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: enabled
                      ? () => onChanged(
                            policy.copyWith(
                              requiredApprovalMode: 'AlwaysManual',
                            ),
                          )
                      : null,
                  borderRadius: BorderRadius.circular(TtRadius.md),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (policy.requiredApprovalMode ?? 'AlwaysManual') ==
                              'AlwaysManual'
                          ? tt.gold.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(TtRadius.md),
                      border: Border.all(
                        color: (policy.requiredApprovalMode ?? 'AlwaysManual') ==
                                'AlwaysManual'
                            ? tt.primaryStrong
                            : tt.line2,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Luôn cần duyệt',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: tt.text,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mọi truyện AI tạo đều vào hàng chờ. Khuyên dùng cho trẻ nhỏ.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: tt.muted),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: enabled
                      ? () => onChanged(
                            policy.copyWith(
                              requiredApprovalMode: 'AutoPublishOnThreshold',
                            ),
                          )
                      : null,
                  borderRadius: BorderRadius.circular(TtRadius.md),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (policy.requiredApprovalMode ?? 'AlwaysManual') ==
                              'AutoPublishOnThreshold'
                          ? tt.gold.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(TtRadius.md),
                      border: Border.all(
                        color: (policy.requiredApprovalMode ?? 'AlwaysManual') ==
                                'AutoPublishOnThreshold'
                            ? tt.primaryStrong
                            : tt.line2,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Tự duyệt khi đạt ngưỡng an toàn',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: tt.text,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Truyện đạt điểm an toàn và độ khó theo chính sách được giao ngay, truyện còn lại vào hàng chờ.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: tt.muted),
                        ),
                      ],
                    ),
                  ),
                ),
                if ((policy.requiredApprovalMode ?? 'AlwaysManual') ==
                    'AutoPublishOnThreshold') ...[
                  if (policy.parentalGateEnabled) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: tt.gold.withValues(alpha: 0.15),
                        border: Border.all(color: tt.goldDeep, width: 1.5),
                        borderRadius: BorderRadius.circular(TtRadius.md),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 20,
                            color: tt.goldDeep,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Đang bật “Hỏi mật khẩu khi bé thoát” nên truyện vẫn cần bạn duyệt tay. Muốn tự duyệt, hãy tắt mục đó ở phần Giới hạn và quyền.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: tt.text),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _LabeledSlider(
                    title: 'Điểm an toàn tối thiểu',
                    valueText: (_dragSafety != null)
                        ? _dragSafety!.round().toString()
                        : (policy.safetyScoreThreshold == null
                            ? 'Mặc định'
                            : policy.safetyScoreThreshold!.round().toString()),
                    value: (_dragSafety ?? policy.safetyScoreThreshold ?? 80.0)
                        .toDouble(),
                    min: 0,
                    max: 100,
                    step: 5,
                    enabled: enabled,
                    onChanged: (v) => setState(() => _dragSafety = v),
                    onChangeEnd: (v) {
                      onChanged(policy.copyWith(safetyScoreThreshold: v));
                      setState(() => _dragSafety = null);
                    },
                    onReset: policy.safetyScoreThreshold != null
                        ? () {
                            setState(() => _dragSafety = null);
                            onChanged(
                              policy.copyWith(safetyScoreThreshold: null),
                            );
                          }
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _LabeledSlider(
                    title: 'Độ dễ đọc tối thiểu',
                    valueText: (_dragReadability != null)
                        ? _dragReadability!.round().toString()
                        : (policy.readabilityScoreThreshold == null
                            ? 'Mặc định'
                            : policy.readabilityScoreThreshold!
                                .round()
                                .toString()),
                    value: (_dragReadability ??
                            policy.readabilityScoreThreshold ??
                            60.0)
                        .toDouble(),
                    min: 0,
                    max: 100,
                    step: 5,
                    enabled: enabled,
                    onChanged: (v) => setState(() => _dragReadability = v),
                    onChangeEnd: (v) {
                      onChanged(policy.copyWith(readabilityScoreThreshold: v));
                      setState(() => _dragReadability = null);
                    },
                    onReset: policy.readabilityScoreThreshold != null
                        ? () {
                            setState(() => _dragReadability = null);
                            onChanged(
                              policy.copyWith(readabilityScoreThreshold: null),
                            );
                          }
                        : null,
                  ),
                ],
              ],
            ),
          ),
          // Nhóm: Giới hạn và quyền
          TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Giới hạn và quyền',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: tt.text,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Độ dài truyện',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: tt.text,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: tt.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(TtRadius.full),
                        ),
                        child: Text(
                          'khoảng ${_formatThousands(displayedLength)} từ',
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: tt.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment<bool>(
                            value: false,
                            label: Text('Theo mức đọc'),
                          ),
                          ButtonSegment<bool>(
                            value: true,
                            label: Text('Tự chỉnh'),
                          ),
                        ],
                        selected: {effective.custom},
                        showSelectedIcon: false,
                        onSelectionChanged: enabled
                            ? (newSelection) {
                                final isCustom = newSelection.first;
                                if (!isCustom) {
                                  onChanged(
                                    policy.copyWith(
                                      storyLengthTarget: null,
                                      maxStoryLength: max(
                                        policy.maxStoryLength ?? 0,
                                        kLevelModeStoryCap,
                                      ),
                                    ),
                                  );
                                } else {
                                  final v = effective.value;
                                  onChanged(
                                    policy.copyWith(
                                      storyLengthTarget: v,
                                      maxStoryLength: max(
                                        policy.maxStoryLength ?? 0,
                                        storyLengthUpperBound(v),
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: (_dragLen ?? displayedLength.toDouble()).clamp(
                    kMaxStoryLengthRange.min.toDouble(),
                    kMaxStoryLengthRange.max.toDouble(),
                  ),
                  min: kMaxStoryLengthRange.min.toDouble(),
                  max: kMaxStoryLengthRange.max.toDouble(),
                  divisions: ((kMaxStoryLengthRange.max -
                              kMaxStoryLengthRange.min) /
                          kMaxStoryLengthRange.step)
                      .round(),
                  onChanged: (enabled && effective.custom)
                      ? (v) => setState(() => _dragLen = v)
                      : null,
                  onChangeEnd: (enabled && effective.custom)
                      ? (v) {
                          final val = v.round();
                          onChanged(
                            policy.copyWith(
                              storyLengthTarget: val,
                              maxStoryLength: max(
                                policy.maxStoryLength ?? 0,
                                storyLengthUpperBound(val),
                              ),
                            ),
                          );
                          setState(() => _dragLen = null);
                        }
                      : null,
                  activeColor: tt.primaryStrong,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '200 từ',
                        style: textTheme.bodySmall?.copyWith(color: tt.muted),
                      ),
                      Text(
                        '5.000 từ',
                        style: textTheme.bodySmall?.copyWith(color: tt.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    effective.custom
                        ? 'Bạn đang tự chỉnh: AI viết khoảng ${_formatThousands(lengthBounds.min)}–${_formatThousands(lengthBounds.max)} từ.'
                        : 'Theo mức đọc $level, tự đổi khi bạn đổi mức đọc ở tab Học tập. AI viết khoảng ${_formatThousands(lengthBounds.min)}–${_formatThousands(lengthBounds.max)} từ.',
                    style: textTheme.bodySmall?.copyWith(color: tt.muted),
                  ),
                ),
                if (advice != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: tt.gold.withValues(alpha: 0.15),
                      border: Border.all(color: tt.goldDeep, width: 1.5),
                      borderRadius: BorderRadius.circular(TtRadius.md),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 20,
                          color: tt.goldDeep,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            advice.text,
                            style:
                                textTheme.bodyMedium?.copyWith(color: tt.text),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                _switchTile(
                  context,
                  title: 'Hỏi mật khẩu khi thoát',
                  subtitle:
                      'Cổng xác nhận người lớn: bé muốn thoát ra phải nhập mật khẩu của bạn',
                  value: policy.parentalGateEnabled,
                  onChanged: (v) =>
                      onChanged(policy.copyWith(parentalGateEnabled: v)),
                ),
              ],
            ),
          ),
          // Nhóm: Mức đọc hiểu mục tiêu
          TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Mức đọc hiểu mục tiêu',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: tt.text,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'AI dựa vào mức này để chọn độ khó cho câu hỏi đọc hiểu sau mỗi truyện.',
                    style: textTheme.bodySmall?.copyWith(color: tt.muted),
                  ),
                ),
                const SizedBox(height: 16),
                _LabeledSlider(
                  title: 'Tỉ lệ bé cần hiểu đúng',
                  valueText:
                      '${(_dragComp ?? policy.comprehensionThresholdPercent ?? 70).round()}%',
                  value: (_dragComp ??
                          policy.comprehensionThresholdPercent ??
                          70)
                      .toDouble(),
                  min: 50,
                  max: 90,
                  step: 5,
                  enabled: enabled,
                  onChanged: (v) => setState(() => _dragComp = v),
                  onChangeEnd: (v) {
                    onChanged(
                      policy.copyWith(
                        comprehensionThresholdPercent: v.round(),
                      ),
                    );
                    setState(() => _dragComp = null);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '50%',
                        style: textTheme.bodySmall?.copyWith(color: tt.muted),
                      ),
                      Text(
                        '90%',
                        style: textTheme.bodySmall?.copyWith(color: tt.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        ...widget.trailingLeft,
      ],
      right: [
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
        if (showReadingSettings)
          // Nhóm: Tính năng cho bé
          TtCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Tính năng cho bé',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: tt.text,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
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
                ..._kChildFeatures.map((item) {
                  final isEnabled = _getChildFeatureValue(policy, item.field);
                  final subtitle = (!isEnabled && item.warning != null)
                      ? item.warning!
                      : item.hint;
                  return _switchTile(
                    context,
                    title: item.label,
                    subtitle: subtitle,
                    value: isEnabled,
                    onChanged: (v) =>
                        onChanged(_updateChildFeature(policy, item.field, v)),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.title,
    required this.valueText,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.enabled,
    required this.onChanged,
    required this.onChangeEnd,
    this.onReset,
  });

  final String title;
  final String valueText;
  final double value;
  final double min;
  final double max;
  final double step;
  final bool enabled;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: tt.text,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Wrap(
                spacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (onReset != null && enabled)
                    InkWell(
                      onTap: onReset,
                      borderRadius: BorderRadius.circular(TtRadius.sm),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Text(
                          'Về mặc định',
                          style: textTheme.bodySmall?.copyWith(
                            color: tt.link,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tt.gold.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(TtRadius.full),
                    ),
                    child: Text(
                      valueText,
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tt.text,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Slider(
          value: value.clamp(min, max),
          min: min,
          max: max,
          divisions: ((max - min) / step).round(),
          onChanged: enabled ? onChanged : null,
          onChangeEnd: enabled ? onChangeEnd : null,
          activeColor: tt.primaryStrong,
        ),
      ],
    );
  }
}
