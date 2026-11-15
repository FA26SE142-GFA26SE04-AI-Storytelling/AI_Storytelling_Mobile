import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_confirm_dialog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_access_credential_dto.dart';
import '../../children/presentation/children_providers.dart';
import '../data/child_access_repository.dart';

/// Link bé quét để vào góc đọc (khớp web và màn quét QR của mobile).
String kidLoginLink(String secret) =>
    'https://www.taletale.site/?kid=${Uri.encodeQueryComponent(secret)}';

class ChildAccessScreen extends ConsumerStatefulWidget {
  const ChildAccessScreen({super.key, required this.childId});

  final int childId;

  @override
  ConsumerState<ChildAccessScreen> createState() => _ChildAccessScreenState();
}

enum _Busy { generate, revoke }

class _ChildAccessScreenState extends ConsumerState<ChildAccessScreen> {
  ChildAccessCredentialDto? _cred;
  bool _isLoading = true;
  String? _errorMessage;
  _Busy? _busy;

  @override
  void initState() {
    super.initState();
    _load();
  }

  String _message(Object e) =>
      e is ApiException ? e.message : ApiException.defaultFallbackMessage;

  String _formatDateTime(DateTime dt) {
    final l = dt.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(l.day)}/${two(l.month)}/${l.year} ${two(l.hour)}:${two(l.minute)}';
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final cred = await ref
          .read(childAccessRepositoryProvider)
          .fetchCredential(widget.childId);
      if (!mounted) return;
      setState(() {
        _cred = cred;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        // 404 = bé chưa có mã nào.
        if (e.statusCode == 404) {
          _cred = null;
        } else {
          _errorMessage = e.message;
        }
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = _message(e);
        _isLoading = false;
      });
    }
  }

  Future<void> _generate() async {
    if (_busy != null) return;
    final hasCode = _cred?.hasEasyLogin ?? false;
    if (hasCode) {
      final ok = await showConfirmDialog(
        context,
        title: 'Tạo mã QR mới?',
        message: 'Mã QR cũ sẽ hết hiệu lực và phiên của bé đang mở bằng mã cũ sẽ bị đóng.',
        confirmLabel: 'Tạo mã mới',
      );
      if (!ok || !mounted) return;
    }

    setState(() => _busy = _Busy.generate);
    try {
      final r = await ref
          .read(childAccessRepositoryProvider)
          .generateEasyLogin(widget.childId);
      if (!mounted) return;
      setState(() {
        _cred = ChildAccessCredentialDto(
          childProfileId: widget.childId,
          hasEasyLogin: true,
          easyLoginCreatedAt: r.createdAt,
          secret: r.secret,
        );
      });
      ref.invalidate(childOverviewProvider(widget.childId));
      showTtToast(
        context,
        hasCode
            ? 'Đã tạo mã QR mới. Mã cũ không dùng được nữa.'
            : 'Đã tạo mã QR. Cho bé quét mã để vào góc đọc.',
        type: TtToastType.success,
      );
    } catch (e) {
      if (!mounted) return;
      showTtToast(context, _message(e), type: TtToastType.error);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  Future<void> _revoke() async {
    if (_busy != null) return;
    final ok = await showConfirmDialog(
      context,
      title: 'Thu hồi mã QR?',
      message: 'Mã hiện tại hết hiệu lực ngay và phiên của bé đang mở bằng mã này sẽ bị đóng.',
      confirmLabel: 'Thu hồi',
      destructive: true,
    );
    if (!ok || !mounted) return;

    setState(() => _busy = _Busy.revoke);
    try {
      await ref
          .read(childAccessRepositoryProvider)
          .revokeCredential(widget.childId);
      if (!mounted) return;
      setState(() {
        _cred = ChildAccessCredentialDto(
          childProfileId: widget.childId,
          hasEasyLogin: false,
        );
      });
      ref.invalidate(childOverviewProvider(widget.childId));
      showTtToast(
        context,
        'Đã thu hồi mã QR. Tạo mã mới khi bé cần đăng nhập lại.',
        type: TtToastType.success,
      );
    } catch (e) {
      if (!mounted) return;
      showTtToast(context, _message(e), type: TtToastType.error);
    } finally {
      if (mounted) setState(() => _busy = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mã QR')),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TtSkeleton(height: 300),
            SizedBox(height: 16),
            TtSkeleton(height: 52),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return TtErrorState(message: _errorMessage!, onRetry: _load);
    }

    final cred = _cred;
    if (cred == null || !cred.hasEasyLogin) {
      return TtEmptyState(
        icon: Icons.qr_code_2_rounded,
        title: 'Bé chưa có mã QR',
        message: 'Tạo mã để bé quét và vào góc đọc.',
        actionLabel: 'Tạo mã QR',
        onAction: _busy == null ? _generate : null,
      ).animate().fadeIn(duration: 300.ms);
    }

    final secret = cred.secret;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: TtCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (secret != null && secret.isNotEmpty)
              _QrBox(data: kidLoginLink(secret)).animate().scale(
                begin: const Offset(0.92, 0.92),
                duration: 350.ms,
                curve: Curves.easeOutBack,
              )
            else
              const _OldCodeNotice(),
            if (cred.easyLoginCreatedAt != null) ...[
              const SizedBox(height: 16),
              _CreatedAt(
                text: 'Tạo lúc ${_formatDateTime(cred.easyLoginCreatedAt!)}',
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TtButton(
                    label: 'Tạo mã mới',
                    icon: Icons.refresh_rounded,
                    variant: TtButtonVariant.secondary,
                    isLoading: _busy == _Busy.generate,
                    onPressed: _busy == null ? _generate : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TtButton(
                    label: 'Thu hồi',
                    icon: Icons.link_off_rounded,
                    variant: TtButtonVariant.danger,
                    isLoading: _busy == _Busy.revoke,
                    onPressed: _busy == null ? _revoke : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0),
    );
  }
}

/// Khung QR luôn nền trắng (cả dark mode) để máy quét đọc được.
class _QrBox extends StatelessWidget {
  const _QrBox({required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(color: tt.gold, width: 3),
        boxShadow: [
          BoxShadow(
            color: tt.gold.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Semantics(
        label: 'Mã QR đăng nhập của bé',
        child: QrImageView(
          data: data,
          size: 200,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Colors.black,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

/// Mã tạo trước khi backend lưu lại được nên không hiện lại QR.
class _OldCodeNotice extends StatelessWidget {
  const _OldCodeNotice();

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: tt.gold.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.qr_code_2_rounded, size: 36, color: tt.goldDeep),
        ),
        const SizedBox(height: 12),
        Text(
          'Bé đang dùng mã QR cũ',
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Mã này chưa xem lại được. Tạo mã mới để hiện QR (mã cũ sẽ hết hiệu lực).',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: tt.muted),
        ),
      ],
    );
  }
}

class _CreatedAt extends StatelessWidget {
  const _CreatedAt({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(TtRadius.lg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 18, color: tt.goldDeep),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: tt.text, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
