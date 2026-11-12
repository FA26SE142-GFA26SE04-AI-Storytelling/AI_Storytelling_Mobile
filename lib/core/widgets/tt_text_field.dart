import 'package:flutter/material.dart';

import '../theme/tt_colors.dart';
import '../theme/tt_radius.dart';

/// Ô nhập văn bản chuẩn của ứng dụng với nhãn phía trên và hỗ trợ ẩn/hiện mật khẩu.
class TtTextField extends StatefulWidget {
  const TtTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.obscure = false,
    this.enabled = true,
    this.autofillHints,
    this.hint,
    this.autofocus = false,
  });

  /// Nhãn hiển thị phía trên ô nhập.
  final String label;

  /// Bộ điều khiển văn bản.
  final TextEditingController? controller;

  /// Hàm kiểm tra tính hợp lệ của giá trị nhập.
  final String? Function(String?)? validator;

  /// Kiểu bàn phím hiển thị.
  final TextInputType? keyboardType;

  /// Hành động của nút gửi/tiếp tục trên bàn phím.
  final TextInputAction? textInputAction;

  /// Callback khi nhấn nút gửi/tiếp tục trên bàn phím.
  final void Function(String)? onSubmitted;

  /// Chế độ ẩn ký tự (mật khẩu).
  final bool obscure;

  /// Cho phép chỉnh sửa hay không.
  final bool enabled;

  /// Gợi ý tự động điền thông tin (autofill).
  final Iterable<String>? autofillHints;

  /// Văn bản gợi ý mờ trong ô nhập.
  final String? hint;

  /// Tự động lấy tiêu điểm khi hiển thị.
  final bool autofocus;

  @override
  State<TtTextField> createState() => _TtTextFieldState();
}

class _TtTextFieldState extends State<TtTextField> {
  late bool _obscured;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscure;
  }

  @override
  void didUpdateWidget(covariant TtTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscure != widget.obscure) {
      _obscured = widget.obscure;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;

    // Kiểu chữ nhãn phía trên ô nhập
    final labelStyle = (textTheme.titleSmall ?? const TextStyle()).copyWith(
      fontFamily: 'Nunito',
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: tt.text,
    );

    // Kiểu chữ nội dung người dùng nhập
    final inputStyle = (textTheme.bodyLarge ?? const TextStyle()).copyWith(
      color: tt.text,
    );

    // Nút chuyển đổi ẩn/hiện mật khẩu nếu obscure == true
    Widget? suffixIcon;
    if (widget.obscure) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscured ? Icons.visibility_rounded : Icons.visibility_off_rounded,
          color: tt.muted,
        ),
        tooltip: _obscured ? 'Hiện mật khẩu' : 'Ẩn mật khẩu',
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        onPressed: () {
          setState(() {
            _obscured = !_obscured;
          });
        },
      );
    }

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(TtRadius.md),
      borderSide: BorderSide(color: tt.line2, width: 1.5),
    );

    // MergeSemantics gộp nhãn phía trên vào chính ô nhập, để trình đọc màn hình
    // (và aria-label trên web) gắn nhãn cho ô thật thay vì tạo thêm một node riêng.
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label, style: labelStyle),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            // Kiểm tra lại khi người dùng gõ, để lỗi tự mất khi đã nhập đúng.
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            autofillHints: widget.autofillHints,
            obscureText: widget.obscure ? _obscured : false,
            style: inputStyle,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: tt.panel,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(color: tt.primary, width: 2.0),
              ),
              errorBorder: border.copyWith(
                borderSide: BorderSide(color: tt.danger, width: 1.5),
              ),
              focusedErrorBorder: border.copyWith(
                borderSide: BorderSide(color: tt.danger, width: 2.0),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
