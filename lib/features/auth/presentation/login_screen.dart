import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ai_storytelling_mobile/core/network/api_exception.dart';
import 'package:ai_storytelling_mobile/core/theme/tt_colors.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_button.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_text_field.dart';
import 'package:ai_storytelling_mobile/core/widgets/tt_toast.dart';
import 'package:ai_storytelling_mobile/features/auth/application/auth_controller.dart';
import 'package:ai_storytelling_mobile/features/auth/presentation/auth_scaffold.dart';

/// Màn hình đăng nhập tài khoản phụ huynh.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _identifierController;
  late final TextEditingController _passwordController;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _identifierController = TextEditingController();
    _passwordController = TextEditingController();

    // Kiểm tra thông báo phiên đăng nhập hết hạn sau khi render khung hình đầu tiên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final authState = ref.read(authControllerProvider);
      if (authState is AuthSignedOut && authState.sessionExpired) {
        showTtToast(
          context,
          'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
          type: TtToastType.error,
        );
        ref.read(authControllerProvider.notifier).acknowledgeSessionExpired();
      }
    });
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Xử lý gửi biểu mẫu đăng nhập
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      await ref.read(authControllerProvider.notifier).login(
            identifier: _identifierController.text.trim(),
            password: _passwordController.text,
          );
      // Khi thành công, router sẽ tự động chuyển hướng theo trạng thái xác thực.
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
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Đăng nhập',
      subtitle: 'Chào mừng bạn trở lại. Đăng nhập để cho bé đọc truyện.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ô nhập tài khoản (email hoặc username)
            TtTextField(
              label: 'Email hoặc tên đăng nhập',
              controller: _identifierController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập email hoặc tên đăng nhập';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Ô nhập mật khẩu
            TtTextField(
              label: 'Mật khẩu',
              controller: _passwordController,
              obscure: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              autofillHints: const [AutofillHints.password],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nút quên mật khẩu
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 48),
                  foregroundColor: context.tt.link,
                  textStyle: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () => context.push('/forgot-password'),
                child: const Text('Quên mật khẩu?'),
              ),
            ),
            const SizedBox(height: 16),

            // Nút bấm đăng nhập
            TtButton(
              label: 'Đăng nhập',
              icon: Icons.login_rounded,
              expanded: true,
              isLoading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
            const SizedBox(height: 12),

            // Nút vào bằng mã QR cho bé
            TtButton(
              label: 'Bé vào bằng mã QR',
              icon: Icons.qr_code_scanner_rounded,
              variant: TtButtonVariant.secondary,
              expanded: true,
              onPressed: () => context.push('/kid-entry'),
            ),
            const SizedBox(height: 12),

            // Điều hướng sang màn hình đăng ký
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Chưa có tài khoản?'),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(48, 48),
                    foregroundColor: context.tt.link,
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => context.push('/register'),
                  child: const Text('Tạo tài khoản'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
