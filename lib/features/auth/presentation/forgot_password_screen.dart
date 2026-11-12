import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_text_field.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/auth_scaffold.dart';

/// Màn hình yêu cầu gửi mã xác nhận để đặt lại mật khẩu.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Gửi yêu cầu đặt lại mật khẩu.
  Future<void> _submit([String? _]) async {
    if (_submitting) return;
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).forgotPassword(email: email);
      if (!mounted) return;
      showTtToast(
        context,
        'Đã gửi mã đặt lại mật khẩu tới email của bạn.',
        type: TtToastType.success,
      );
      context.go('/reset-password', extra: email);
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
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Quên mật khẩu',
      subtitle: 'Nhập email tài khoản, chúng tôi sẽ gửi mã đặt lại mật khẩu.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TtTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              onSubmitted: _submit,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!text.contains('@')) {
                  return 'Email không đúng định dạng';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtButton(
              label: 'Gửi mã',
              icon: Icons.mail_outline_rounded,
              expanded: true,
              isLoading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('Quay lại đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
