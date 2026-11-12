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

/// Màn hình xác thực tài khoản qua mã OTP gửi về email.
class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({
    super.key,
    this.initialEmail = '',
  });

  /// Email cần xác thực được truyền vào từ màn hình trước.
  final String initialEmail;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _otpController;

  bool _submitting = false;
  bool _resending = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  /// Gửi mã xác thực lên hệ thống.
  Future<void> _submit([String? _]) async {
    if (_submitting) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).verifyEmail(
            email: _emailController.text.trim(),
            otp: _otpController.text.trim(),
          );
      if (!mounted) return;
      showTtToast(
        context,
        'Xác thực email thành công. Bạn đăng nhập nhé.',
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
      if (mounted) setState(() => _submitting = false);
    }
  }

  /// Gửi lại mã xác thực tới email.
  Future<void> _resendCode() async {
    if (_resending) return;
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      showTtToast(
        context,
        'Vui lòng nhập email hợp lệ để nhận mã.',
        type: TtToastType.error,
      );
      return;
    }

    setState(() => _resending = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .resendVerificationEmail(email: email);
      if (!mounted) return;
      showTtToast(
        context,
        'Đã gửi lại mã xác thực.',
        type: TtToastType.success,
      );
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
      if (mounted) setState(() => _resending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return AuthScaffold(
      title: 'Xác thực email',
      subtitle: 'Nhập mã 6 số chúng tôi đã gửi tới email của bạn.',
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
            TtTextField(
              label: 'Mã xác thực',
              controller: _otpController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: _submit,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập mã xác thực';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TtButton(
              label: 'Xác nhận',
              icon: Icons.verified_rounded,
              expanded: true,
              isLoading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
            const SizedBox(height: 16),
            TtButton(
              label: 'Gửi lại mã',
              icon: Icons.refresh_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              isLoading: _resending,
              onPressed: (_submitting || _resending) ? null : _resendCode,
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
