import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_radius.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_text_field.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/account/data/account_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_models.dart';

/// Hiển thị hộp thoại chỉnh sửa họ và tên người dùng.
Future<void> showEditNameDialog(
  BuildContext context,
  WidgetRef ref,
  UserProfile user,
) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _EditNameDialog(
      rootContext: context,
      ref: ref,
      user: user,
    ),
  );
}

class _EditNameDialog extends StatefulWidget {
  final BuildContext rootContext;
  final WidgetRef ref;
  final UserProfile user;

  const _EditNameDialog({
    required this.rootContext,
    required this.ref,
    required this.user,
  });

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  bool _isLoading = false;
  late String _currentText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.user.fullName);
    _currentText = widget.user.fullName;
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_currentText != _controller.text) {
      setState(() {
        _currentText = _controller.text;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  /// Nút Lưu chỉ bật khi nội dung hợp lệ và có thay đổi so với ban đầu
  bool get _canSave {
    final trimmed = _currentText.trim();
    return !_isLoading &&
        trimmed.isNotEmpty &&
        trimmed != widget.user.fullName &&
        trimmed.length <= 100;
  }

  Future<void> _submit() async {
    if (!_canSave) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final trimmedName = _controller.text.trim();

    setState(() => _isLoading = true);

    try {
      await widget.ref.read(accountRepositoryProvider).updateProfile(
            fullName: trimmedName,
            avatarUrl: widget.user.avatarUrl,
          );

      // UserProfile không có copyWith nên tạo instance mới giữ nguyên các thuộc tính khác
      final updatedUser = UserProfile(
        id: widget.user.id,
        username: widget.user.username,
        email: widget.user.email,
        fullName: trimmedName,
        role: widget.user.role,
        status: widget.user.status,
        avatarUrl: widget.user.avatarUrl,
      );
      widget.ref.read(authControllerProvider.notifier).updateUser(updatedUser);

      if (!mounted) return;
      Navigator.of(context).pop();

      if (widget.rootContext.mounted) {
        showTtToast(
          widget.rootContext,
          'Đã cập nhật họ tên',
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Đổi họ và tên',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: tt.text,
                    ),
              ),
              const SizedBox(height: 16),
              TtTextField(
                label: 'Họ và tên',
                controller: _controller,
                enabled: !_isLoading,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (_canSave) {
                    _submit();
                  }
                },
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  if (trimmed.length > 100) {
                    return 'Họ và tên không được vượt quá 100 ký tự';
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
                      onPressed:
                          _isLoading ? null : () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Nút Lưu chỉ hiện khi tên đã đổi (quy tắc thiết kế).
                  if (_canSave || _isLoading) ...[
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
