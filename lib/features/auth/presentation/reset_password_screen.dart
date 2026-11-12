import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_text_field.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/auth_scaffold.dart';

/// Màn hình đặt lại mật khẩu với mã xác nhận đã gửi qua email.
class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String initialEmail;

  const ResetPasswordScreen({
    super.key,
    required this.initialEmail,
  });

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _codeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _codeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _submitting = true;
    });

    try {
      await ref.read(authRepositoryProvider).resetPassword(
            email: _emailController.text.trim(),
            code: _codeController.text.trim(),
            newPassword: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
          );

      if (!mounted) return;
      showTtToast(
        context,
        'Đã đổi mật khẩu. Bạn đăng nhập lại nhé.',
        type: TtToastType.success,
      );
      context.go('/login');
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(context, e.message, type: TtToastType.error);
    } catch (_) {
      if (!mounted) return;
      showTtToast(
        context,
        'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.',
        type: TtToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return AuthScaffold(
      title: 'Đặt lại mật khẩu',
      subtitle: 'Nhập mã đã gửi tới email và mật khẩu mới.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TtTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty || !text.contains('@')) {
                  return 'Email chưa đúng định dạng';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtTextField(
              label: 'Mã xác nhận',
              controller: _codeController,
              // Mã đặt lại là chuỗi chữ + số dài trong email, người dùng thường dán vào.
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập mã xác nhận';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtTextField(
              label: 'Mật khẩu mới',
              controller: _passwordController,
              obscure: true,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập mật khẩu mới';
                }
                if (text.length < 8) {
                  return 'Mật khẩu cần ít nhất 8 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtTextField(
              label: 'Nhập lại mật khẩu mới',
              controller: _confirmPasswordController,
              obscure: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Mật khẩu nhập lại chưa khớp';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtButton(
              label: 'Đặt lại mật khẩu',
              icon: Icons.lock_reset_rounded,
              expanded: true,
              isLoading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/login'),
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 48),
                foregroundColor: tt.link,
                textStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Quay lại đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
