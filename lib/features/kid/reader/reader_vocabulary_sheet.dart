import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../models/reading_start_dto.dart';
import '../data/kid_session_controller.dart';
import 'data/reading_repository.dart';

/// Hiển thị bottom sheet giải nghĩa từ vựng cho bé khi đọc truyện.
Future<void> showReaderVocabularySheet(
  BuildContext context,
  WidgetRef ref, {
  required int sessionId,
  required int vocabularyId,
  required String term,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ReaderVocabularySheet(
      sessionId: sessionId,
      vocabularyId: vocabularyId,
      term: term,
    ),
  );
}

/// Bottom sheet hiển thị nghĩa của một từ khi bé chạm vào từ trong truyện.
class ReaderVocabularySheet extends ConsumerStatefulWidget {
  const ReaderVocabularySheet({
    super.key,
    required this.sessionId,
    required this.vocabularyId,
    required this.term,
  });

  /// Mã phiên đọc truyện của bé.
  final int sessionId;

  /// Mã định danh từ vựng cần tra cứu.
  final int vocabularyId;

  /// Từ vựng bé vừa chạm vào.
  final String term;

  @override
  ConsumerState<ReaderVocabularySheet> createState() =>
      _ReaderVocabularySheetState();
}

class _ReaderVocabularySheetState extends ConsumerState<ReaderVocabularySheet> {
  bool _isLoading = true;
  String? _errorMessage;
  VocabularyDefinitionDto? _definition;

  @override
  void initState() {
    super.initState();
    _loadDefinition();
  }

  Future<void> _loadDefinition() async {
    final sessionState = ref.read(kidSessionProvider);
    if (sessionState is! KidActive) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Phiên của bé đã hết hạn.';
        });
      }
      return;
    }

    final token = sessionState.session.accessToken;
    try {
      final repo = ref.read(readingRepositoryProvider);
      final result = await repo.definition(
        token: token,
        sessionId: widget.sessionId,
        vocabularyId: widget.vocabularyId,
      );
      if (mounted) {
        setState(() {
          _isLoading = false;
          _definition = result;
        });
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Container(
      decoration: BoxDecoration(
        color: tt.panel,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(TtRadius.xl),
        ),
        border: Border.all(
          color: tt.line2,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thanh nắm kéo nhỏ ở trên
            Center(
              child: Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: tt.line2,
                  borderRadius: BorderRadius.circular(TtRadius.full),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Nội dung theo trạng thái
            _buildContent(context, tt),
            const SizedBox(height: 24),
            // Nút Đóng
            SizedBox(
              width: double.infinity,
              height: 64,
              child: TtButton(
                label: 'Đóng',
                icon: Icons.check_rounded,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TtColors tt) {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TtFrog(
              mood: TtFrogMood.think,
              size: 96,
            ),
            const SizedBox(height: 16),
            TtSkeleton(
              width: 180,
              height: 28,
              radius: BorderRadius.circular(TtRadius.sm),
            ),
            const SizedBox(height: 12),
            TtSkeleton(
              width: double.infinity,
              height: 52,
              radius: BorderRadius.circular(TtRadius.sm),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          _errorMessage!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            color: tt.danger,
            height: 1.4,
          ),
        ),
      );
    }

    final displayTerm = (_definition?.term.trim().isNotEmpty ?? false)
        ? _definition!.term.trim()
        : widget.term.trim();
    final rawDef = _definition?.definition.trim();
    final definitionText = (rawDef != null && rawDef.isNotEmpty)
        ? rawDef
        : 'Em chưa có nghĩa cho từ này.';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          displayTerm,
          style: TextStyle(
            fontFamily: 'Baloo2',
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: tt.text,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          definitionText,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            height: 1.6,
            color: tt.text,
          ),
        ),
      ],
    );
  }
}
