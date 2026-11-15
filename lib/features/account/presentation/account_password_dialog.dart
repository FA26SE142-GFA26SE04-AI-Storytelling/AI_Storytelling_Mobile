import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_text_field.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';

/// Hiển thị hộp thoại đổi mật khẩu người dùng.
Future<void> showChangePasswordDialog(
  BuildContext context,
  WidgetRef ref,
) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _ChangePasswordDialog(
      rootContext: context,
      ref: ref,
    ),
  );
}

class _ChangePasswordDialog extends StatefulWidget {
  final BuildContext rootContext;
  final WidgetRef ref;

  const _ChangePasswordDialog({
    required this.rootContext,
    required this.ref,
  });

  @override
  State<_ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<_ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _currentPasswordController.addListener(_onTextChanged);
    _newPasswordController.addListener(_onTextChanged);
    _confirmPasswordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _currentPasswordController.removeListener(_onTextChanged);
    _newPasswordController.removeListener(_onTextChanged);
    _confirmPasswordController.removeListener(_onTextChanged);

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Nút Lưu chỉ bật khi cả 3 ô đã nhập và hợp lệ
  bool get _canSave {
    if (_isLoading) return false;
    final current = _currentPasswordController.text;
    final next = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    return current.isNotEmpty &&
        next.length >= 8 &&
        confirm.isNotEmpty &&
        next == confirm;
  }

  Future<void> _submit() async {
    if (!_canSave) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() => _isLoading = true);

    try {
      await widget.ref.read(accountRepositoryProvider).changePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          );

      if (!mounted) return;
      Navigator.of(context).pop();

      if (widget.rootContext.mounted) {
        showTtToast(
          widget.rootContext,
          'Đã đổi mật khẩu. Các thiết bị khác đã được đăng xuất.',
          type: TtToastType.success,
        );
      }
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
      }
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.',
          type: TtToastType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Dialog(
      backgroundColor: tt.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TtRadius.xl),
        side: BorderSide(color: tt.line2, width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Đổi mật khẩu',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: tt.text,
                      ),
                ),
                const SizedBox(height: 16),
                TtTextField(
                  label: 'Mật khẩu hiện tại',
                  controller: _currentPasswordController,
                  obscure: true,
                  enabled: !_isLoading,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu hiện tại';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TtTextField(
                  label: 'Mật khẩu mới',
                  controller: _newPasswordController,
                  obscure: true,
                  enabled: !_isLoading,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu mới';
                    }
                    if (value.length < 8) {
                      return 'Mật khẩu mới phải có tối thiểu 8 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TtTextField(
                  label: 'Nhập lại mật khẩu mới',
                  controller: _confirmPasswordController,
                  obscure: true,
                  enabled: !_isLoading,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) {
                    if (_canSave) {
                      _submit();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lại mật khẩu mới';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Mật khẩu xác nhận không khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TtButton(
                        label: 'Huỷ',
                        variant: TtButtonVariant.secondary,
                        onPressed: _isLoading
                            ? null
                            : () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TtButton(
                        label: 'Lưu',
                        variant: TtButtonVariant.primary,
                        isLoading: _isLoading,
                        onPressed: _canSave ? _submit : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
