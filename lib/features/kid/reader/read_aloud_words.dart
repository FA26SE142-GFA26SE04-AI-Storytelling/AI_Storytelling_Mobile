import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/read_aloud_dto.dart';

/// Widget hiển thị kết quả đọc to từng chữ của bé.
class ReadAloudWordsView extends StatelessWidget {
  /// Khởi tạo [ReadAloudWordsView].
  const ReadAloudWordsView({
    super.key,
    required this.result,
    required this.onRetry,
  });

  /// Kết quả đọc to gồm danh sách từ và số lượng đánh giá.
  final ReadAloudResultDto result;

  /// Callback khi bé muốn đọc lại.
  final VoidCallback onRetry;

  String _hintMessage(String hint) {
    switch (hint) {
      case 'tone':
        return 'Sai dấu, em thử lại nhé';
      case 'unclear':
        return 'Chưa nghe rõ';
      case 'different':
        return 'Em đọc thành chữ khác';
      default:
        return hint;
    }
  }

  Widget _buildWord(BuildContext context, ReadAloudWordDto word, TtColors tt) {
    Widget wordWidget;
    switch (word.status) {
      case 'good':
        wordWidget = Text(
          word.text,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            height: 1.6,
            fontWeight: FontWeight.bold,
            color: tt.primaryStrong,
          ),
        );
        break;
      case 'retry':
        wordWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: tt.gold.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            word.text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              height: 1.6,
              color: tt.text,
            ),
          ),
        );
        break;
      case 'skipped':
      default:
        wordWidget = Opacity(
          opacity: 0.6,
          child: Text(
            word.text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 24,
              height: 1.6,
              color: tt.muted,
            ),
          ),
        );
        break;
    }

    final hint = word.hint;
    if (hint != null && hint.isNotEmpty) {
      wordWidget = GestureDetector(
        onTap: () {
          showTtToast(
            context,
            _hintMessage(hint),
            type: TtToastType.info,
          );
        },
        child: wordWidget,
      );
    }

    return wordWidget;
  }

  @override
  Widget build(BuildContext context) {
    final retryButton = SizedBox(
      height: 64,
      child: TtButton(
        label: 'Đọc lại',
        icon: Icons.replay_rounded,
        variant: TtButtonVariant.secondary,
        expanded: true,
        onPressed: onRetry,
      ),
    );

    if (result.words.isEmpty) {
      return retryButton;
    }

    final tt = context.tt;
    final sortedWords = List<ReadAloudWordDto>.from(result.words)
      ..sort((a, b) => a.index.compareTo(b.index));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: sortedWords
              .map((word) => _buildWord(context, word, tt))
              .toList(),
        ),
        const SizedBox(height: 24),
        Text(
          '${result.goodCount} chữ đọc đúng',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: tt.text,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        retryButton,
      ],
    );
  }
}
