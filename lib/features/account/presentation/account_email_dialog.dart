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
import 'package:ai_storytelling_mobile/features/auth/data/auth_repository.dart';

/// Hiển thị popup đổi email người dùng qua quy trình 2 bước.
Future<void> showChangeEmailDialog(
  BuildContext context,
  WidgetRef ref,
  UserProfile user,
) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => ChangeEmailDialog(user: user),
  );
}

/// Hộp thoại 2 bước thay đổi email và xác thực OTP.
class ChangeEmailDialog extends ConsumerStatefulWidget {
  const ChangeEmailDialog({super.key, required this.user});

  final UserProfile user;

  @override
  ConsumerState<ChangeEmailDialog> createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends ConsumerState<ChangeEmailDialog> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 1;
  bool _isLoading = false;

  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _otpController;

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController()..addListener(_onFieldChanged);
    _emailController = TextEditingController()..addListener(_onFieldChanged);
    _otpController = TextEditingController()..addListener(_onOtpChanged);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onFieldChanged);
    _emailController.removeListener(_onFieldChanged);
    _otpController.removeListener(_onOtpChanged);
    _passwordController.dispose();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {});
  }

  void _onOtpChanged() {
    // TtTextField không nhận inputFormatters nên lọc tại đây: chỉ giữ số, tối đa 6 ký tự.
    final text = _otpController.text;
    var clean = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.length > 6) clean = clean.substring(0, 6);
    if (clean != text) {
      // Gán value sẽ gọi lại listener này với chuỗi đã sạch.
      _otpController.value = TextEditingValue(
        text: clean,
        selection: TextSelection.collapsed(offset: clean.length),
      );
      return;
    }
    setState(() {});
  }

  bool _isEmailValid(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  bool get _isStep1Valid {
    final password = _passwordController.text;
    final email = _emailController.text.trim();
    return password.isNotEmpty &&
        _isEmailValid(email) &&
        email.toLowerCase() != widget.user.email.toLowerCase();
  }

  bool get _isStep2Valid {
    return _otpController.text.trim().length == 6;
  }

  /// Bước 1: Yêu cầu đổi email
  Future<void> _handleRequestEmailChange() async {
    if (_isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false) || !_isStep1Valid) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(accountRepositoryProvider)
          .requestEmailChange(
            currentPassword: _passwordController.text,
            newEmail: _emailController.text.trim(),
          );
      if (!mounted) return;
      setState(() {
        _currentStep = 2;
        _otpController.clear();
      });
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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Bước 2: Xác nhận OTP đổi email
  Future<void> _handleConfirmEmailChange() async {
    if (_isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false) || !_isStep2Valid) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final otp = _otpController.text.trim();
      final newEmail = _emailController.text.trim();

      await ref.read(accountRepositoryProvider).confirmEmailChange(otp);

      // Cập nhật thông tin user mới từ server (/Auth/me)
      try {
        final newUser = await ref.read(authRepositoryProvider).fetchMe();
        ref.read(authControllerProvider.notifier).updateUser(newUser);
      } catch (_) {
        // Fallback cập nhật email mới vào state nếu lấy thông tin mới gặp sự cố tạm thời
        final fallbackUser = UserProfile(
          id: widget.user.id,
          username: widget.user.username,
          email: newEmail,
          fullName: widget.user.fullName,
          role: widget.user.role,
          status: widget.user.status,
          avatarUrl: widget.user.avatarUrl,
        );
        ref.read(authControllerProvider.notifier).updateUser(fallbackUser);
      }

      if (!mounted) return;
      Navigator.of(context).pop();
      showTtToast(
        context,
        'Đã đổi email. Email mới đã được xác nhận',
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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: tt.panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TtRadius.xl),
        side: BorderSide(color: tt.line2, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _currentStep == 1 ? 'Đổi email' : 'Xác thực email mới',
                  style: textTheme.titleMedium?.copyWith(
                    color: tt.text,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                if (_currentStep == 1) ...[
                  TtTextField(
                    label: 'Mật khẩu hiện tại',
                    controller: _passwordController,
                    obscure: true,
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TtTextField(
                    label: 'Email mới',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _handleRequestEmailChange(),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Vui lòng nhập email mới';
                      }
                      if (!_isEmailValid(text)) {
                        return 'Email không đúng định dạng';
                      }
                      if (text.toLowerCase() ==
                          widget.user.email.toLowerCase()) {
                        return 'Email mới không được trùng với email hiện tại';
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
                          label: 'Tiếp tục',
                          isLoading: _isLoading,
                          // Luôn bấm được để validate() hiện lỗi dưới từng ô.
                          onPressed: _handleRequestEmailChange,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Text(
                    'Nhập mã 6 số đã gửi tới ${_emailController.text.trim()}',
                    style: textTheme.bodyMedium?.copyWith(color: tt.muted),
                  ),
                  const SizedBox(height: 16),
                  TtTextField(
                    label: 'Mã xác thực',
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    enabled: !_isLoading,
                    autofocus: true,
                    hint: 'Nhập 6 chữ số',
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _handleConfirmEmailChange(),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Vui lòng nhập mã xác thực';
                      }
                      if (text.length != 6) {
                        return 'Mã xác thực phải đủ 6 chữ số';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TtButton(
                          label: 'Quay lại',
                          variant: TtButtonVariant.secondary,
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _currentStep = 1;
                                    _otpController.clear();
                                  });
                                },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TtButton(
                          label: 'Xác nhận',
                          isLoading: _isLoading,
                          onPressed: _handleConfirmEmailChange,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
