import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_toast.dart';
import '../data/kid_repository.dart';
import '../data/kid_session_controller.dart';
import '../data/stored_kid_session.dart';
import 'kid_qr_parser.dart';

/// Màn hình quét mã QR để vào Chế độ của bé.
class KidQrScreen extends ConsumerStatefulWidget {
  const KidQrScreen({super.key});

  @override
  ConsumerState<KidQrScreen> createState() => _KidQrScreenState();
}

class _KidQrScreenState extends ConsumerState<KidQrScreen> {
  late MobileScannerController _controller;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _retryCamera() {
    setState(() {
      _controller.dispose();
      _controller = MobileScannerController();
    });
  }

  Future<void> _handleDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final raw =
        capture.barcodes.isEmpty ? null : capture.barcodes.first.rawValue;
    final secret = parseKidSecret(raw ?? '');
    if (secret == null) {
      if (mounted) {
        setState(() {
          _isProcessing = true;
        });
      }
      showTtToast(
        context,
        'Mã này chưa đúng. Em tìm đúng mã QR của bé nhé.',
        type: TtToastType.error,
      );
      await Future<void>.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final dto =
          await ref.read(kidRepositoryProvider).loginWithEasyLogin(secret);
      final session = StoredKidSession.fromChildSession(
        dto,
        via: KidSessionVia.easyLogin,
        parentalGateEnabled: true,
      );
      await ref.read(kidSessionProvider.notifier).start(session);
      if (mounted) {
        context.go('/kid');
      }
    } on ApiException catch (e) {
      if (mounted) {
        showTtToast(context, e.message, type: TtToastType.error);
      }
      await Future<void>.delayed(const Duration(seconds: 2));
    } catch (_) {
      if (mounted) {
        showTtToast(
          context,
          'Có lỗi xảy ra. Vui lòng thử lại.',
          type: TtToastType.error,
        );
      }
      await Future<void>.delayed(const Duration(seconds: 2));
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/login');
            }
          },
        ),
        title: const Text('Quét mã QR của bé'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _handleDetect,
            onDetectError: (Object error, StackTrace st) {
              // Bỏ qua lỗi quét mã
            },
            errorBuilder: (
              BuildContext context,
              MobileScannerException error,
            ) {
              return TtErrorState(
                title: 'Chưa mở được camera',
                message:
                    'Hãy cho phép dùng camera trong cài đặt của máy rồi thử lại.',
                onRetry: _retryCamera,
              );
            },
          ),
          IgnorePointer(
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _isProcessing
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TtFrog(
                                mood: TtFrogMood.think,
                                size: 96,
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                      BorderRadius.circular(TtRadius.md),
                                ),
                                child: const Text(
                                  'Đang mở cửa vào đầm sen…',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Baloo2',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(TtRadius.md),
                            ),
                            child: const Text(
                              'Đưa mã QR của bé vào giữa khung nhé',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Baloo2',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(TtRadius.xl),
                      border: Border.all(
                        color: tt.gold,
                        width: 4,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
