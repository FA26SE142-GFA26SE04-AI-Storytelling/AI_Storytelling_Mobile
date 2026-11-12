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

/// Màn hình đăng ký tài khoản phụ huynh mới.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Xử lý gửi biểu mẫu đăng ký lên hệ thống.
  Future<void> _submit() async {
    if (_submitting) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final username = _usernameController.text.trim();
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    try {
      await ref.read(authRepositoryProvider).register(
            username: username,
            email: email,
            fullName: fullName,
            password: password,
            confirmPassword: confirmPassword,
          );

      if (!mounted) return;
      showTtToast(
        context,
        'Đã gửi mã xác thực tới email của bạn. Vui lòng kiểm tra hộp thư.',
        type: TtToastType.success,
      );
      context.go('/verify-email', extra: email);
    } on ApiException catch (e) {
      if (!mounted) return;
      showTtToast(
        context,
        e.message,
        type: TtToastType.error,
      );
    } catch (_) {
      if (!mounted) return;
      showTtToast(
        context,
        'Chưa kết nối được máy chủ. Bạn thử lại sau ít phút nhé.',
        type: TtToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return AuthScaffold(
      title: 'Tạo tài khoản',
      subtitle: 'Tạo tài khoản phụ huynh để bắt đầu cho bé đọc truyện.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ô nhập tên đăng nhập
            TtTextField(
              label: 'Tên đăng nhập',
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập';
                }
                if (text.length < 3) {
                  return 'Tên đăng nhập cần ít nhất 3 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Ô nhập họ và tên
            TtTextField(
              label: 'Họ và tên',
              controller: _fullNameController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Ô nhập email
            TtTextField(
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!text.contains('@')) {
                  return 'Email chưa đúng định dạng';
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
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (value.length < 8) {
                  return 'Mật khẩu cần ít nhất 8 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Ô nhập lại mật khẩu
            TtTextField(
              label: 'Nhập lại mật khẩu',
              controller: _confirmPasswordController,
              obscure: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập lại mật khẩu';
                }
                if (value != _passwordController.text) {
                  return 'Mật khẩu nhập lại chưa khớp';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Nút bấm đăng ký tài khoản
            TtButton(
              label: 'Tạo tài khoản',
              icon: Icons.person_add_alt_1_rounded,
              expanded: true,
              isLoading: _submitting,
              onPressed: _submitting ? null : _submit,
            ),
            const SizedBox(height: 12),

            // Chuyển hướng tới màn hình đăng nhập
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Đã có tài khoản?'),
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
                  child: const Text('Đăng nhập'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
