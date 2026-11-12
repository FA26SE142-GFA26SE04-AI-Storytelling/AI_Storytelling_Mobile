import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_repository.dart';

/// Hiển thị popup Cổng phụ huynh yêu cầu nhập email và mật khẩu để thoát Chế độ của bé.
Future<bool> showParentalGateDialog(
  BuildContext context, {
  required String initialEmail,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => ParentalGateDialog(initialEmail: initialEmail),
  );
  return result ?? false;
}

/// Hộp thoại xác thực cổng phụ huynh.
class ParentalGateDialog extends ConsumerStatefulWidget {
  const ParentalGateDialog({
    super.key,
    required this.initialEmail,
  });

  final String initialEmail;

  @override
  ConsumerState<ParentalGateDialog> createState() => _ParentalGateDialogState();
}

class _ParentalGateDialogState extends ConsumerState<ParentalGateDialog> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showTtToast(context, 'Bố mẹ nhập đủ email và mật khẩu nhé.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(kidRepositoryProvider).verifyParentalGate(
            email: email,
            password: password,
          );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          ApiException.defaultFallbackMessage,
          type: TtToastType.error,
        );
        setState(() {
          _isLoading = false;
        });
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cổng phụ huynh',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: 'Baloo2',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: tt.text,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bố mẹ nhập lại email và mật khẩu để thoát Chế độ của bé.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: tt.muted,
                    ),
              ),
              const SizedBox(height: 20),
              TtTextField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TtTextField(
                label: 'Mật khẩu',
                controller: _passwordController,
                obscure: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _handleSubmit(),
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
                          : () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TtButton(
                      label: 'Xác nhận',
                      variant: TtButtonVariant.primary,
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _handleSubmit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
