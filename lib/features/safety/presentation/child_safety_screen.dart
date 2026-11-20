import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_profile_dto.dart';
import '../../../models/content_category_dto.dart';
import '../../../models/safety_policy_dto.dart';
import '../../auth/application/auth_controller.dart';
import '../../children/data/child_profile_repository.dart';
import '../../children/presentation/children_providers.dart';
import 'safety_rules_form.dart';

class ChildSafetyScreen extends ConsumerStatefulWidget {
  const ChildSafetyScreen({
    super.key,
    required this.childId,
  });

  final int childId;

  @override
  ConsumerState<ChildSafetyScreen> createState() => _ChildSafetyScreenState();
}

class _ChildSafetyScreenState extends ConsumerState<ChildSafetyScreen> {
  bool _loading = true;
  bool _saving = false;
  String? _errorMessage;

  ChildProfileDto? _child;
  SafetyPolicyDto? _policy;
  List<ContentCategoryDto> _categories = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      final childFuture = repo.fetchById(widget.childId);
      final categoriesFuture = repo.fetchContentCategories();

      SafetyPolicyDto? policy;
      try {
        policy = await repo.fetchSafety(widget.childId);
      } on ApiException catch (e) {
        if (e.statusCode == 404) {
          policy = null;
        } else {
          rethrow;
        }
      }

      final child = await childFuture;
      final allCategories = await categoriesFuture;
      final activeCategories = allCategories.where((c) => c.isActive).toList();

      if (!mounted) return;
      setState(() {
        _child = child;
        _categories = activeCategories;
        _policy = policy;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.message;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';
        _loading = false;
      });
    }
  }

  Future<void> _commit(
    SafetyPolicyDto next, {
    bool voiceConsentAccepted = false,
  }) async {
    if (_saving) return;

    final old = _policy;
    setState(() {
      _saving = true;
      _policy = next;
    });

    final body = safetyPolicyToRequest(next);
    if (voiceConsentAccepted) {
      body['voiceConsentAccepted'] = true;
    }

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      await repo.setSafety(widget.childId, body);
      // Ô "An toàn" ở Quản lý bé đọc từ overview: làm mới để không hiện giá trị cũ.
      ref.invalidate(childOverviewProvider(widget.childId));
      if (!mounted) return;
      showTtToast(context, 'Đã lưu cài đặt an toàn', type: TtToastType.success);
      try {
        final fresh = await repo.fetchSafety(widget.childId);
        if (!mounted) return;
        setState(() {
          _policy = fresh;
        });
      } catch (_) {}
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _policy = old;
      });
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _policy = old;
      });
      showTtToast(context, 'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error);
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  Future<void> _onRulesChanged(SafetyPolicyDto next) async {
    final needsVoiceConsent = next.voiceAnswersEnabled == true &&
        _policy?.voiceAnswersEnabled != true &&
        _policy?.voiceConsentAt == null;

    if (needsVoiceConsent) {
      final agreed = await _showVoiceConsentDialog();
      if (agreed == true) {
        await _commit(next, voiceConsentAccepted: true);
      }
    } else {
      await _commit(next);
    }
  }

  Future<bool?> _showVoiceConsentDialog() {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final tt = dialogContext.tt;
        bool agreed = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: tt.panel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TtRadius.xl),
                side: BorderSide(color: tt.line2, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bật trả lời bằng giọng nói',
                        style: Theme.of(dialogContext)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: tt.text,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Trước khi bật, bạn cần biết:',
                        style: Theme.of(dialogContext)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tt.text,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Khi bật giọng nói: lúc bé luyện đọc to, giọng của bé chỉ được nhận dạng tạm thời rồi bỏ, không lưu lại; bản ghi âm bé kể lại cuối truyện được lưu để bạn nghe lại, bạn xoá được bất cứ lúc nào.',
                        style: Theme.of(dialogContext)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: tt.text,
                            ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          setDialogState(() {
                            agreed = !agreed;
                          });
                        },
                        borderRadius: BorderRadius.circular(TtRadius.sm),
                        child: Row(
                          children: [
                            Checkbox(
                              value: agreed,
                              activeColor: tt.primary,
                              onChanged: (val) {
                                setDialogState(() {
                                  agreed = val ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Tôi đã đọc và đồng ý',
                                style: Theme.of(dialogContext)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: tt.text,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TtButton(
                              variant: TtButtonVariant.secondary,
                              label: 'Huỷ',
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TtButton(
                              label: 'Đồng ý và bật',
                              onPressed: agreed
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
      },
    );
  }

  Future<bool?> _showParentConsentDialog() {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final tt = dialogContext.tt;
        bool agreed = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: tt.panel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TtRadius.xl),
                side: BorderSide(color: tt.line2, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đồng ý của phụ huynh',
                        style: Theme.of(dialogContext)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: tt.text,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Trước khi bé dùng Taletale, bạn cần biết:',
                        style: Theme.of(dialogContext)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tt.text,
                            ),
                      ),
                      const SizedBox(height: 12),
                      _buildNumberedPoint(
                        1,
                        'Nền tảng chỉ lưu biệt danh, nhóm tuổi và cấu hình học tập của bé; không thu thập họ tên đầy đủ, ngày sinh, trường học hay địa chỉ.',
                        dialogContext,
                      ),
                      _buildNumberedPoint(
                        2,
                        'Truyện của bé do AI sinh ra và được kiểm tra an toàn tự động trước khi tới bước duyệt của bạn.',
                        dialogContext,
                      ),
                      _buildNumberedPoint(
                        3,
                        'Truyện bị AI gắn cờ nghi vấn có thể được kiểm duyệt viên của nền tảng đọc để kiểm tra an toàn. Kiểm duyệt viên không thấy biệt danh của bé hay thông tin gia đình. Bạn không nên đặt tên nhân vật trùng tên thật của con.',
                        dialogContext,
                      ),
                      _buildNumberedPoint(
                        4,
                        'Hệ thống tự phát hiện số điện thoại, địa chỉ, tên trường và biệt danh của bé trong truyện để cảnh báo bạn.',
                        dialogContext,
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          setDialogState(() {
                            agreed = !agreed;
                          });
                        },
                        borderRadius: BorderRadius.circular(TtRadius.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: agreed,
                              activeColor: tt.primary,
                              onChanged: (val) {
                                setDialogState(() {
                                  agreed = val ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Tôi đã đọc và đồng ý cho bé sử dụng nền tảng theo các điều trên.',
                                style: Theme.of(dialogContext)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: tt.text,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TtButton(
                              variant: TtButtonVariant.secondary,
                              label: 'Huỷ',
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TtButton(
                              label: 'Đồng ý và tạo',
                              onPressed: agreed
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
      },
    );
  }

  Widget _buildNumberedPoint(int number, String text, BuildContext context) {
    final tt = context.tt;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: tt.text,
                ),
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: tt.text,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _create() async {
    if (_saving) return;

    final agreed = await _showParentConsentDialog();
    if (agreed != true) return;

    setState(() {
      _saving = true;
    });

    final body = <String, dynamic>{
      'maxStoryLength': _child?.ageBand == 'Age_9_10' ? 1500 : 900,
      'requiredApprovalMode': 'AlwaysManual',
      'parentalGateEnabled': true,
      'consentRecorded': true,
      'storyWishesEnabled': true,
      'allowInteractiveStories': true,
      'applyAgePreset': false,
      'categories': <String, dynamic>{},
    };

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      await repo.setSafety(widget.childId, body);
      ref.invalidate(childOverviewProvider(widget.childId));
      if (!mounted) return;
      showTtToast(context, 'Đã tạo cài đặt an toàn',
          type: TtToastType.success);
      await _load();
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      showTtToast(context, 'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error);
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  Future<void> _reconsent() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Đồng ý điều khoản mới',
      message:
          'Bạn đã đọc và đồng ý với điều khoản đã thay đổi để tiếp tục cho bé dùng nền tảng?',
      confirmLabel: 'Đồng ý',
    );

    if (confirmed != true) return;
    if (_saving) return;

    setState(() {
      _saving = true;
    });

    try {
      final repo = ref.read(childProfileRepositoryProvider);
      await repo.reconsent(widget.childId);
      ref.invalidate(childOverviewProvider(widget.childId));
      if (!mounted) return;
      showTtToast(context, 'Đã đồng ý điều khoản mới',
          type: TtToastType.success);
      final fresh = await repo.fetchSafety(widget.childId);
      if (!mounted) return;
      setState(() {
        _policy = fresh;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      showTtToast(context, 'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error);
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  String _formatConsentDate(DateTime? dt) {
    if (dt == null) return 'Chưa đồng ý';
    final local = dt.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final year = local.year.toString();
    return 'Đã đồng ý lúc $day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final authState = ref.watch(authControllerProvider);
    final currentUserId =
        authState is AuthSignedIn ? authState.user.id : null;
    final isOwner = _child != null &&
        _child!.ownerUserId != null &&
        _child!.ownerUserId == currentUserId;
    final canEdit = isOwner;

    Widget body;
    if (_loading) {
      body = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TtSkeleton(height: 220),
            SizedBox(height: 16),
            TtSkeleton(height: 180),
            SizedBox(height: 16),
            TtSkeleton(height: 120),
          ],
        ),
      );
    } else if (_errorMessage != null) {
      body = Center(
        child: TtErrorState(
          message: _errorMessage!,
          onRetry: _load,
        ),
      );
    } else {
      body = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!canEdit)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Chỉ người quản lý chính mới chỉnh được cài đặt này.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tt.muted,
                      ),
                ),
              ),
            if (_policy != null) ...[
              SafetyRulesForm(
                policy: _policy!,
                categories: _categories,
                enabled: canEdit && !_saving,
                onChanged: _onRulesChanged,
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.05, end: 0),
              const SizedBox(height: 16),
              TtCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Điều khoản',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: tt.text,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatConsentDate(_policy!.consentRecordedAt),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: tt.text,
                          ),
                    ),
                    if (_policy!.consentOutdated == true) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: tt.gold.withValues(alpha: 0.15),
                          border: Border.all(color: tt.goldDeep, width: 1.5),
                          borderRadius: BorderRadius.circular(TtRadius.md),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Điều khoản đã thay đổi. Bạn cần đọc và đồng ý lại.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: tt.text,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            if (canEdit)
                              TtButton(
                                label: 'Đồng ý điều khoản mới',
                                expanded: true,
                                isLoading: _saving,
                                onPressed:
                                    (canEdit && !_saving) ? _reconsent : null,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ] else ...[
              TtCard(
                padding: const EdgeInsets.all(16),
                child: TtEmptyState(
                  icon: Icons.shield_outlined,
                  title: 'Chưa có cài đặt an toàn',
                  message: 'Tạo cài đặt để bé bắt đầu đọc truyện.',
                  actionLabel: canEdit ? 'Tạo cài đặt an toàn' : null,
                  onAction: (canEdit && !_saving) ? _create : null,
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('An toàn'),
      ),
      // Màn rộng: giới hạn 720 như các màn Tài khoản.
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: body,
        ),
      ),
    );
  }
}
