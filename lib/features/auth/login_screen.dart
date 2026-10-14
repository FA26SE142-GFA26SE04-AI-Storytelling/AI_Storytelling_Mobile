import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/tt_colors.dart';
import '../../app/theme/tt_theme.dart';
import '../../core/env.dart';
import '../../shared/motion/motion.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/frog.dart';
import '../../shared/widgets/pond_backdrop.dart';
import '../../shared/widgets/tt_button.dart';
import 'auth_controller.dart';

enum LoginMode {
  login('Chào mừng trở lại', 'Đăng nhập'),
  register('Tạo tài khoản Taletale', 'Đăng ký'),
  forgot('Quên mật khẩu', 'Gửi hướng dẫn'),
  reset('Đặt mật khẩu mới', 'Đổi mật khẩu');

  const LoginMode(this.title, this.submitLabel);
  final String title;
  final String submitLabel;

  static LoginMode parse(String? raw) => LoginMode.values.firstWhere((m) => m.name == raw, orElse: () => LoginMode.login);
}

/// Đăng nhập / đăng ký / quên mật khẩu / đặt lại mật khẩu.
/// Link đặt lại mật khẩu trong email mở thẳng vào đây với `mode=reset&token=…&email=…`.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.initialMode = LoginMode.login, this.email, this.token});

  final LoginMode initialMode;
  final String? email;
  final String? token;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _username = TextEditingController();
  final _fullName = TextEditingController();
  late final _email = TextEditingController(text: widget.email ?? '');
  late LoginMode _mode = widget.initialMode;
  late String? _token = widget.token;
  bool _busy = false;
  bool _showPassword = false;
  ({bool ok, String text})? _msg;

  @override
  void dispose() {
    for (final c in [_identifier, _password, _confirm, _username, _fullName, _email]) {
      c.dispose();
    }
    super.dispose();
  }

  void _go(LoginMode next, {({bool ok, String text})? msg}) {
    setState(() {
      _mode = next;
      _msg = msg;
      _password.clear();
      _confirm.clear();
      if (next != LoginMode.reset) _token = null;
    });
    _form.currentState?.reset();
  }

  Future<void> _submit() async {
    if (_busy || !(_form.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _msg = null;
    });
    final auth = ref.read(authControllerProvider.notifier);
    try {
      switch (_mode) {
        case LoginMode.login:
          final r = await auth.login(identifier: _identifier.text.trim(), password: _password.text);
          if (!r.success && mounted) setState(() => _msg = (ok: false, text: r.message));
        case LoginMode.register:
          final r = await auth.register(
            username: _username.text.trim(),
            email: _email.text.trim(),
            fullName: _fullName.text.trim(),
            password: _password.text,
            confirmPassword: _confirm.text,
          );
          if (!mounted) return;
          r.success
              ? _go(LoginMode.login, msg: (ok: true, text: 'Đăng ký thành công. Hãy kiểm tra email để xác thực rồi đăng nhập.'))
              : setState(() => _msg = (ok: false, text: r.message));
        case LoginMode.forgot:
          final r = await auth.forgotPassword(email: _email.text.trim());
          if (mounted) setState(() => _msg = (ok: r.success, text: r.success ? 'Đã gửi hướng dẫn đặt lại mật khẩu qua email.' : r.message));
        case LoginMode.reset:
          if (_token == null || _token!.isEmpty) {
            setState(() => _msg = (ok: false, text: 'Link đặt lại mật khẩu không hợp lệ. Hãy mở lại link trong email.'));
            return;
          }
          final r = await auth.resetPassword(email: _email.text.trim(), resetToken: _token!, newPassword: _password.text, confirmPassword: _confirm.text);
          if (!mounted) return;
          r.success
              ? _go(LoginMode.login, msg: (ok: true, text: 'Đã đổi mật khẩu. Hãy đăng nhập bằng mật khẩu mới.'))
              : setState(() => _msg = (ok: false, text: r.message));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: c.loginBg),
        child: Stack(
          children: [
            const Positioned.fill(child: PondBackdrop(flowers: false)),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400), child: _card(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    final c = context.tt;
    final text = Theme.of(context).textTheme;
    final needsPassword = _mode != LoginMode.forgot;
    final needsConfirm = _mode == LoginMode.register || _mode == LoginMode.reset;
    final isLastField = !needsPassword && !needsConfirm;

    final fields = <Widget>[
      if (_mode == LoginMode.register) ...[
        _Field(label: 'Họ và tên', controller: _fullName, autofill: AutofillHints.name, capitalize: true),
        _Field(label: 'Tên đăng nhập', controller: _username, autofill: AutofillHints.newUsername),
      ],
      if (_mode == LoginMode.login)
        _Field(label: 'Email hoặc tên đăng nhập', controller: _identifier, autofill: AutofillHints.username, keyboard: TextInputType.emailAddress)
      else
        _Field(
          label: 'Email',
          controller: _email,
          autofill: AutofillHints.email,
          keyboard: TextInputType.emailAddress,
          validator: (v) => RegExp(r'^\S+@\S+\.\S+$').hasMatch(v.trim()) ? null : 'Email chưa đúng định dạng',
          last: isLastField,
          onSubmitted: isLastField ? _submit : null,
        ),
      if (needsPassword)
        _Field(
          label: _mode == LoginMode.reset ? 'Mật khẩu mới' : 'Mật khẩu',
          controller: _password,
          obscure: !_showPassword,
          autofill: _mode == LoginMode.login ? AutofillHints.password : AutofillHints.newPassword,
          last: !needsConfirm,
          onSubmitted: needsConfirm ? null : _submit,
          suffix: IconButton(
            tooltip: _showPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu',
            icon: Icon(_showPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: c.muted),
            onPressed: () => setState(() => _showPassword = !_showPassword),
          ),
        ),
      if (needsConfirm)
        _Field(
          label: 'Nhập lại mật khẩu',
          controller: _confirm,
          obscure: !_showPassword,
          autofill: AutofillHints.newPassword,
          validator: (v) => v == _password.text ? null : 'Mật khẩu nhập lại không khớp',
          last: true,
          onSubmitted: _submit,
        ),
    ];

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.fromLTRB(22, 72, 22, 16),
          decoration: BoxDecoration(
            color: c.panel,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: c.line2),
            boxShadow: [BoxShadow(color: c.shadow.withValues(alpha: 0.4), blurRadius: 70, offset: const Offset(0, 30), spreadRadius: -30)],
          ),
          child: Form(
            key: _form,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: riseIn(context, [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(_mode.title, key: ValueKey(_mode), style: text.headlineMedium, textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 14),
                    child: Text(
                      'Nền tảng kể chuyện AI an toàn cho trẻ em, có phụ huynh đồng hành.',
                      style: text.bodyMedium?.copyWith(color: c.muted),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (Env.useMock)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Center(
                        child: StatusPill(label: 'Dữ liệu mẫu · nhập bất kỳ để đăng nhập', tone: PillTone.wait),
                      ),
                    ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [for (final f in fields) Padding(padding: const EdgeInsets.only(bottom: 12), child: f)],
                    ),
                  ),
                  if (_msg != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Notice(message: _msg!.text, ok: _msg!.ok),
                    ),
                  TtButton(label: _busy ? 'Đang xử lý…' : _mode.submitLabel, busy: _busy, expand: true, onPressed: _submit),
                  const SizedBox(height: 4),
                  // Wrap để tự xuống dòng trên màn hẹp hoặc khi phóng to chữ.
                  Wrap(
                    alignment: _mode == LoginMode.login ? WrapAlignment.spaceBetween : WrapAlignment.center,
                    children: _mode == LoginMode.login
                        ? [
                            TextButton(onPressed: () => _go(LoginMode.register), child: const Text('Tạo tài khoản')),
                            TextButton(onPressed: () => _go(LoginMode.forgot), child: const Text('Quên mật khẩu?')),
                          ]
                        : [TextButton(onPressed: () => _go(LoginMode.login), child: const Text('Quay lại đăng nhập'))],
                  ),
                ]),
              ),
            ),
          ),
        ),
        const Frog(size: 110, mood: FrogMood.happy),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.autofill,
    this.keyboard,
    this.obscure = false,
    this.capitalize = false,
    this.validator,
    this.suffix,
    this.last = false,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final String? autofill;
  final TextInputType? keyboard;
  final bool obscure;
  final bool capitalize;
  final String? Function(String value)? validator;
  final Widget? suffix;
  final bool last;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final c = context.tt;
    // Gộp nhãn và ô nhập để trình đọc màn hình đọc đúng tên ô.
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 6),
            child: Text(
              label,
              style: TextStyle(fontFamily: TtFonts.ui, fontSize: 12.5, fontWeight: FontWeight.w700, color: c.muted),
            ),
          ),
          TextFormField(
            controller: controller,
            obscureText: obscure,
            autocorrect: false,
            enableSuggestions: !obscure,
            keyboardType: keyboard,
            textCapitalization: capitalize ? TextCapitalization.words : TextCapitalization.none,
            autofillHints: autofill == null ? null : [autofill!],
            textInputAction: last ? TextInputAction.done : TextInputAction.next,
            onFieldSubmitted: onSubmitted == null ? null : (_) => onSubmitted!(),
            // Ô nhập 16px để iOS không tự phóng to.
            style: TextStyle(fontFamily: TtFonts.ui, fontSize: 16, color: c.text),
            decoration: InputDecoration(suffixIcon: suffix),
            validator: (v) {
              final value = v ?? '';
              if (value.trim().isEmpty) return 'Vui lòng nhập ${label.toLowerCase()}';
              return validator?.call(value);
            },
          ),
        ],
      ),
    );
  }
}
