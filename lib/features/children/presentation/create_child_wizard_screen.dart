import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_adaptive.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/content_category_dto.dart';
import '../../../models/learning_profile_dto.dart';
import '../../../models/safety_policy_dto.dart';
import '../../safety/presentation/safety_rules_form.dart';
import '../data/child_profile_repository.dart';
import 'child_age_presets.dart';
import 'children_providers.dart';
import 'learning_form.dart';

const _stepLabels = ['Bé', 'Học tập', 'An toàn', 'Xong'];
const _stepTitles = [
  'Thông tin bé',
  'Hồ sơ học tập',
  'An toàn',
  'Xác nhận',
];

/// Wizard toàn màn hình tạo hồ sơ bé: Bé → Học tập → An toàn → Xong (theo web CreateChildWizard).
class CreateChildWizardScreen extends ConsumerStatefulWidget {
  const CreateChildWizardScreen({super.key});

  @override
  ConsumerState<CreateChildWizardScreen> createState() =>
      _CreateChildWizardScreenState();
}

class _CreateChildWizardScreenState
    extends ConsumerState<CreateChildWizardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameCtrl = TextEditingController();

  int _step = 0;
  String _ageBand = kAgeBands.first.id;
  late LearningFormValue _learning = _learningDefaults(_ageBand);
  List<ContentCategoryDto> _categories = const [];
  bool _categoriesLoaded = false;
  bool _rulesSeeded = false;
  // Chỉ dùng phần `categories` cho SafetyRulesForm; các trường khác gửi theo web khi lưu.
  SafetyPolicyDto _policy = const SafetyPolicyDto(childProfileId: 0);
  bool _gate = true;
  bool _busy = false;
  // Giữ id hồ sơ đã tạo để bấm lại không tạo trùng khi một bước sau bị lỗi.
  int? _createdId;

  static LearningFormValue _learningDefaults(String ageBand) =>
      LearningFormValue(
        readingLevel: defaultReadingLevel(ageBand),
        readingMode: defaultReadingMode(ageBand),
      );

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nicknameCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final cats = await ref
          .read(childProfileRepositoryProvider)
          .fetchContentCategories();
      if (!mounted) return;
      setState(() {
        _categories = cats.where((c) => c.isActive).toList();
        _categoriesLoaded = true;
        if (_step >= 2) _seedRules();
      });
    } catch (_) {
      if (!mounted) return;
      showTtToast(
        context,
        'Chưa tải được danh sách chủ đề. Bạn có thể chỉnh chủ đề sau trong Cài đặt an toàn.',
        type: TtToastType.error,
      );
    }
  }

  /// Điền sẵn danh sách chặn theo nhóm tuổi khi lần đầu vào bước An toàn.
  void _seedRules() {
    if (_rulesSeeded || !_categoriesLoaded) return;
    _rulesSeeded = true;
    _policy = _policy.copyWith(
      categories: presetBlocked(_categories, _ageBand),
    );
  }

  String get _nickname => _nicknameCtrl.text.trim();

  String get _ageLabel => kAgeBands.firstWhere((a) => a.id == _ageBand).label;

  int get _blockedCount =>
      _policy.categories.where((r) => r.rule == 'Blocked').length;

  void _pickAge(String id) {
    if (id == _ageBand) return;
    setState(() {
      _ageBand = id;
      _learning = _learning.copyWith(
        readingLevel: defaultReadingLevel(id),
        readingMode: defaultReadingMode(id),
      );
    });
  }

  void _next() {
    if (_step == 0 && !(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() {
      if (_step == 1) _seedRules();
      _step++;
    });
  }

  void _back() {
    FocusScope.of(context).unfocus();
    setState(() => _step--);
  }

  void _leave() {
    if (_createdId != null) {
      ref.read(selectedChildIdProvider.notifier).select(_createdId!);
      ref.invalidate(childrenListProvider);
    }
    context.pop();
  }

  Future<void> _askClose() async {
    if (_busy) return;
    final touched = _step > 0 || _nickname.isNotEmpty;
    if (touched) {
      final ok = await showConfirmDialog(
        context,
        title: _createdId != null ? 'Dừng tạo hồ sơ?' : 'Bỏ hồ sơ đang tạo?',
        message: _createdId != null
            ? 'Hồ sơ đã được lưu ở trạng thái Nháp, bạn hoàn tất sau trong Quản lý bé (tab Học tập).'
            : 'Các thông tin đã điền sẽ bị xoá.',
        confirmLabel: _createdId != null ? 'Dừng' : 'Bỏ',
        destructive: _createdId == null,
      );
      if (!ok || !mounted) return;
    }
    _leave();
  }

  /// Bấm "Tạo hồ sơ": hỏi đồng ý của phụ huynh trong popup (như web), rồi tạo.
  Future<void> _askConsentAndFinish() async {
    if (_busy) return;
    final agreed = await _showConsentDialog(context);
    if (agreed == null || !mounted) return;
    await _finish(agreed);
  }

  Future<void> _finish(bool agreed) async {
    if (_busy) return;
    setState(() => _busy = true);
    final repo = ref.read(childProfileRepositoryProvider);
    var failMsg = 'Không tạo được hồ sơ bé.';
    try {
      var id = _createdId;
      if (id == null) {
        final created = await repo.create(
          nickname: _nickname,
          ageBand: _ageBand,
        );
        id = created.id;
        setState(() => _createdId = id);
      }

      failMsg = 'Đã tạo hồ sơ nhưng chưa lưu được phần học tập.';
      await repo.setLearning(
        id,
        readingLevel: _learning.readingLevel,
        readingMode: _learning.readingMode,
        comprehensionGoal: _learning.comprehensionGoal,
        topics: [
          for (final t in _learning.favoriteTopics)
            LearningTopicDto(topic: t, relation: 'FavoriteTopic'),
          for (final t in _learning.priorityFocusAreas)
            LearningTopicDto(topic: t, relation: 'PriorityFocusArea'),
        ],
      );

      // Backend chỉ nhận cài đặt an toàn đầu tiên khi đã đồng ý; chưa đồng ý thì hồ sơ ở trạng thái Nháp.
      if (agreed) {
        failMsg = 'Đã tạo hồ sơ nhưng chưa lưu được cài đặt an toàn.';
        final catIds = _categories.map((c) => c.id).toSet();
        // PUT ghi đè mọi trường: gửi đủ giá trị mặc định như web (keptPolicyFields(null)).
        final body = safetyPolicyToRequest(
          SafetyPolicyDto(
            childProfileId: id,
            maxStoryLength: storyLengthFor(_ageBand, _learning.readingLevel),
            requiredApprovalMode: 'AlwaysManual',
            parentalGateEnabled: _gate,
            consentRecorded: true,
            storyWishesEnabled: true,
            allowInteractiveStories: true,
            childCreationEnabled: true,
            childCreationMode: 'ReviewFirst',
            voiceAnswersEnabled: false,
            categories: _policy.categories
                .where((r) => catIds.contains(r.contentCategoryId))
                .toList(),
          ),
        )..['applyAgePreset'] = false;
        await repo.setSafety(id, body);

        failMsg = 'Đã lưu hồ sơ nhưng chưa kích hoạt được.';
        await repo.activate(id);
      }

      if (!mounted) return;
      showTtToast(
        context,
        'Đã tạo hồ sơ $_nickname',
        type: TtToastType.success,
      );
      _leave();
    } on ApiException catch (e) {
      if (!mounted) return;
      // 409 khi tạo: thường là đã đủ số hồ sơ của gói, nội dung Backend đã rõ.
      final msg = e.statusCode == 409 && _createdId == null
          ? e.message
          : '$failMsg ${e.message}';
      showTtToast(context, msg, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      showTtToast(
        context,
        '$failMsg Vui lòng thử lại.',
        type: TtToastType.error,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final isLast = _step == _stepLabels.length - 1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _askClose();
      },
      child: Scaffold(
        backgroundColor: tt.bg,
        body: SafeArea(
          child: TtContentWidth(
            maxWidth: 840,
            child: Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 16, 8),
                    child: Row(
                      children: [
                        TtIconButton(
                          icon: Icons.close_rounded,
                          tooltip: 'Đóng',
                          onPressed: _busy ? null : _askClose,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: _StepProgress(current: _step)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _stepTitles[_step],
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: tt.text,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 16),
                          KeyedSubtree(
                                key: ValueKey(_step),
                                child: _buildStep(context),
                              )
                              .animate(key: ValueKey(_step))
                              .fadeIn(duration: 250.ms)
                              .slideX(
                                begin: 0.04,
                                end: 0,
                                duration: 250.ms,
                                curve: Curves.easeOut,
                              ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: Row(
                      children: [
                        if (_step > 0) ...[
                          Expanded(
                            child: TtButton(
                              label: 'Quay lại',
                              icon: Icons.arrow_back_rounded,
                              variant: TtButtonVariant.secondary,
                              onPressed: _busy ? null : _back,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: TtButton(
                            label: isLast ? 'Tạo hồ sơ' : 'Tiếp',
                            icon: isLast
                                ? Icons.check_rounded
                                : Icons.arrow_forward_rounded,
                            isLoading: _busy,
                            onPressed: isLast ? _askConsentAndFinish : _next,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context) {
    switch (_step) {
      case 0:
        return _buildChildStep(context);
      case 1:
        return LearningForm(
          value: _learning,
          onChanged: (v) => setState(() => _learning = v),
        );
      case 2:
        return _buildSafetyStep(context);
      default:
        return _buildSummaryStep(context);
    }
  }

  Widget _buildChildStep(BuildContext context) {
    final tt = context.tt;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TtTextField(
            label: 'Biệt danh của bé',
            hint: 'Ví dụ: Bé Na',
            controller: _nicknameCtrl,
            autofocus: true,
            textInputAction: TextInputAction.done,
            validator: (v) {
              final s = v?.trim() ?? '';
              if (s.isEmpty) return 'Hãy nhập biệt danh của bé.';
              if (s.length > 150) return 'Biệt danh tối đa 150 ký tự.';
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Nhóm tuổi',
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700, color: tt.text),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final a in kAgeBands) ...[
                if (a != kAgeBands.first) const SizedBox(width: 12),
                Expanded(
                  child: _AgeCard(
                    label: a.label,
                    hint: a.hint,
                    icon: a.id == 'Age_9_10'
                        ? Icons.menu_book_rounded
                        : Icons.headphones_rounded,
                    selected: _ageBand == a.id,
                    onTap: () => _pickAge(a.id),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyStep(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TtCard(
          padding: const EdgeInsets.all(8),
          child: SwitchListTile(
            // Cùng chữ với màn An toàn (SafetyRulesForm).
            title: Text(
              'Hỏi mật khẩu khi thoát',
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: tt.text,
              ),
            ),
            subtitle: Text(
              'Bé cần mật khẩu của bạn để thoát chế độ bé',
              style: textTheme.bodySmall?.copyWith(color: tt.muted),
            ),
            value: _gate,
            onChanged: (v) => setState(() => _gate = v),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            activeThumbColor: tt.primaryStrong,
          ),
        ),
        const SizedBox(height: 16),
        SafetyRulesForm(
          policy: _policy,
          categories: _categories,
          showReadingSettings: false,
          onChanged: (p) => setState(() => _policy = p),
        ),
      ],
    );
  }

  Widget _buildSummaryStep(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final rows = <(String, String)>[
      ('Biệt danh', _nickname),
      ('Nhóm tuổi', _ageLabel),
      ('Mức đọc', 'Mức ${_learning.readingLevel}'),
      (
        'Chế độ đọc',
        _learning.readingMode == 'ReadFirst' ? 'Tự đọc' : 'Nghe là chính',
      ),
      ('Chủ đề bị chặn', '$_blockedCount'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TtCard(
          child: Column(
            children: [
              for (final (label, value) in rows)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          style: textTheme.bodyMedium?.copyWith(
                            color: tt.muted,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          value,
                          textAlign: TextAlign.right,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: tt.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Popup đồng ý của phụ huynh khi bấm "Tạo hồ sơ" (như web).
/// true: đồng ý và kích hoạt; false: lưu bản nháp; null: đóng popup, chưa tạo.
Future<bool?> _showConsentDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      final tt = dialogContext.tt;
      final textTheme = Theme.of(dialogContext).textTheme;
      var checked = false;
      return StatefulBuilder(
        builder: (context, setLocal) => Dialog(
          backgroundColor: tt.panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TtRadius.xl),
            side: BorderSide(color: tt.line2, width: 1.5),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Đồng ý của phụ huynh',
                  style: textTheme.titleMedium?.copyWith(color: tt.text),
                ),
                const SizedBox(height: 12),
                Text(
                  'Trước khi bé dùng Taletale, bạn cần biết:',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: tt.text,
                  ),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < kConsentItems.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${i + 1}. ${kConsentItems[i]}',
                      style: textTheme.bodySmall?.copyWith(color: tt.text),
                    ),
                  ),
                CheckboxListTile(
                  value: checked,
                  onChanged: (v) => setLocal(() => checked = v ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: tt.primaryStrong,
                  title: Text(
                    'Tôi đã đọc và đồng ý cho bé sử dụng nền tảng theo các điều trên.',
                    style: textTheme.bodyMedium?.copyWith(color: tt.text),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TtButton(
                        label: 'Lưu nháp',
                        variant: TtButtonVariant.secondary,
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TtButton(
                        label: 'Kích hoạt',
                        icon: Icons.check_rounded,
                        onPressed: checked
                            ? () => Navigator.of(dialogContext).pop(true)
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Thanh tiến độ 4 bước: đã qua có ✓, bước hiện tại màu primary, vạch nối vàng.
class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final labelStyle = Theme.of(context).textTheme.labelSmall;
    return Row(
      children: [
        for (var i = 0; i < _stepLabels.length; i++) ...[
          if (i > 0)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 3,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: i <= current ? tt.gold : tt.line2,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Semantics(
            label: 'Bước ${i + 1}: ${_stepLabels[i]}',
            selected: i == current,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < current
                        ? tt.gold
                        : i == current
                        ? tt.primaryStrong
                        : tt.panel,
                    border: Border.all(
                      color: i <= current ? Colors.transparent : tt.line2,
                      width: 1.5,
                    ),
                  ),
                  child: i < current
                      ? Icon(Icons.check_rounded, size: 16, color: tt.text)
                      : Text(
                          '${i + 1}',
                          style: labelStyle?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: i == current ? Colors.white : tt.muted,
                          ),
                        ),
                ),
                const SizedBox(height: 2),
                Text(
                  _stepLabels[i],
                  maxLines: 1,
                  style: labelStyle?.copyWith(
                    fontWeight: i == current
                        ? FontWeight.w800
                        : FontWeight.w600,
                    color: i == current ? tt.text : tt.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Thẻ chọn nhóm tuổi lớn.
class _AgeCard extends StatelessWidget {
  const _AgeCard({
    required this.label,
    required this.hint,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(TtRadius.lg);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected
            ? tt.primary.withValues(alpha: 0.14)
            : tt.panel.withValues(alpha: 0.85),
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: selected ? tt.primaryStrong : tt.line2,
                width: selected ? 2 : 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: selected ? tt.primaryStrong : tt.goldDeep,
                    ),
                    const Spacer(),
                    if (selected)
                      Icon(
                        Icons.check_circle_rounded,
                        size: 20,
                        color: tt.primaryStrong,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hint,
                  style: textTheme.bodySmall?.copyWith(color: tt.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
