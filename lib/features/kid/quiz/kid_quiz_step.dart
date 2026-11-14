import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/widgets/tt_frog.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';

/// Bước câu đố sau khi đọc truyện dành cho bé.
class KidQuizStep extends ConsumerStatefulWidget {
  const KidQuizStep({
    super.key,
    required this.sessionId,
    required this.onExpGained,
    required this.onNext,
    this.isLast = false,
  });

  final int sessionId;
  final ValueChanged<int> onExpGained;
  final VoidCallback onNext;
  final bool isLast;

  @override
  ConsumerState<KidQuizStep> createState() => _KidQuizStepState();
}

class _KidQuizStepState extends ConsumerState<KidQuizStep> {
  final ScrollController _questionScroll = ScrollController();

  final TextEditingController _textController = TextEditingController();
  final Set<int> _rewardedQuizItemIds = <int>{};

  bool _loading = true;
  bool _sending = false;
  bool _loadingResult = false;
  bool _hasError = false;

  List<ChildQuizItem> _questions = const <ChildQuizItem>[];
  Map<int, List<String>> _shuffledChoices = <int, List<String>>{};
  int _currentIndex = 0;

  String _pickedAnswer = '';
  QuizAnswerResult? _currentAnswerResult;
  ChildQuizResult? _quizSummaryResult;

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  @override
  void dispose() {
    _textController.dispose();
    _questionScroll.dispose();
    super.dispose();
  }

  Future<void> _loadQuiz() async {
    setState(() {
      _loading = true;
      _hasError = false;
    });

    try {
      final quiz = await ref
          .read(kidReadingRepositoryProvider)
          .quiz(widget.sessionId.toString());

      if (!mounted) return;

      final random = Random();
      // Giữ thứ tự câu như Backend (giống web); chỉ xáo đáp án.
      final questions = List<ChildQuizItem>.from(quiz.questions);
      final choicesMap = <int, List<String>>{};

      for (final q in questions) {
        if (q.choices != null && q.choices!.isNotEmpty) {
          choicesMap[q.quizItemId] = List<String>.from(q.choices!)
            ..shuffle(random);
        }
      }

      setState(() {
        _questions = questions;
        _shuffledChoices = choicesMap;
        _currentIndex = 0;
        _pickedAnswer = '';
        _currentAnswerResult = null;
        _quizSummaryResult = null;
        _loading = false;
        _rewardedQuizItemIds.clear();
      });
      _textController.clear();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _hasError = true;
      });
      final msg = e is ApiException
          ? e.message
          : 'Có lỗi khi tải câu đố. Bé thử lại nhé!';
      showTtToast(context, msg, type: TtToastType.error);
    }
  }

  Future<void> _sendAnswer(String answerText) async {
    final trimmed = answerText.trim();
    if (_sending || _currentAnswerResult != null || trimmed.isEmpty) return;
    if (_currentIndex >= _questions.length) return;

    final q = _questions[_currentIndex];

    setState(() {
      _sending = true;
      _pickedAnswer = trimmed;
    });

    try {
      final result = await ref
          .read(kidReadingRepositoryProvider)
          .quizAnswer(
            widget.sessionId.toString(),
            quizItemId: q.quizItemId,
            answer: trimmed,
          );

      if (!mounted) return;

      if (result.expGained > 0 &&
          !_rewardedQuizItemIds.contains(q.quizItemId)) {
        _rewardedQuizItemIds.add(q.quizItemId);
        widget.onExpGained(result.expGained);
      }

      setState(() {
        _currentAnswerResult = result;
        _sending = false;
      });
      // Cuộn xuống để bé thấy lời khen / gợi ý của ếch ngay dưới các đáp án.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_questionScroll.hasClients) return;
        _questionScroll.animateTo(
          _questionScroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _pickedAnswer = '';
      });
      final msg = e is ApiException
          ? e.message
          : 'Chưa gửi được câu trả lời. Bé thử lại nhé!';
      showTtToast(context, msg, type: TtToastType.error);
    }
  }

  void _nextQuestion() {
    _textController.clear();
    setState(() {
      _currentIndex++;
      _pickedAnswer = '';
      _currentAnswerResult = null;
    });
  }

  Future<void> _finishQuiz() async {
    if (_loadingResult) return;
    setState(() {
      _loadingResult = true;
    });

    try {
      final res = await ref
          .read(kidReadingRepositoryProvider)
          .quizResult(widget.sessionId.toString());

      if (!mounted) return;

      setState(() {
        _quizSummaryResult = res;
        _loadingResult = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingResult = false;
      });
      final msg = e is ApiException
          ? e.message
          : 'Có lỗi khi lấy kết quả câu đố.';
      showTtToast(context, msg, type: TtToastType.error);
    }
  }

  void _onSkip() {
    if (_sending || _loadingResult) return;
    if (_currentIndex < _questions.length - 1) {
      _nextQuestion();
    } else {
      _finishQuiz();
    }
  }

  void _onProceedNext() {
    if (_currentIndex < _questions.length - 1) {
      _nextQuestion();
    } else {
      _finishQuiz();
    }
  }

  String _formatPct(int? percent) {
    if (percent == null) return '--';
    return '$percent%';
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    if (_loading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TtFrog(mood: TtFrogMood.idle, size: 80),
            const SizedBox(height: 16),
            Text(
              'Đang chuẩn bị câu đố cho bé...',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: tt.muted,
              ),
            ),
          ],
        ),
      );
    }

    if (_hasError) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: const TtFrog(mood: TtFrogMood.think, size: 80),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _KidQuizButton(
              label: 'Thử lại',
              icon: Icons.refresh_rounded,
              onPressed: _loadQuiz,
            ),
          ),
        ],
      );
    }

    if (_questions.isEmpty) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TtFrog(mood: TtFrogMood.idle, size: 80),
                  const SizedBox(height: 16),
                  Text(
                    'Truyện này chưa có câu đố.',
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: tt.text,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: _KidQuizButton(
              label: widget.isLast ? 'Về trang chính' : 'Tiếp',
              icon: widget.isLast
                  ? Icons.home_rounded
                  : Icons.arrow_forward_rounded,
              onPressed: widget.onNext,
            ),
          ),
        ],
      );
    }

    if (_quizSummaryResult != null) {
      final res = _quizSummaryResult!;
      final skipped = (res.totalQuestions - res.answered).clamp(
        0,
        res.totalQuestions,
      );

      return Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TtFrog(mood: TtFrogMood.happy, size: 100),
                    const SizedBox(height: 20),
                    Text(
                      'Em trả lời đúng ${res.correct}/${res.totalQuestions} câu',
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: tt.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (skipped > 0) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Đã bỏ qua $skipped câu',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: tt.muted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 12),
                    Text(
                      'Lần này: ${_formatPct(res.currentPercent)} · Tốt nhất: ${_formatPct(res.bestPercent)}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: tt.inkWarm,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _KidQuizButton(
                  label: widget.isLast ? 'Về trang chính' : 'Tiếp',
                  icon: widget.isLast
                      ? Icons.home_rounded
                      : Icons.arrow_forward_rounded,
                  onPressed: widget.onNext,
                ),
                const SizedBox(height: 12),
                _KidQuizButton(
                  label: 'Làm lại câu đố',
                  icon: Icons.refresh_rounded,
                  isSecondary: true,
                  onPressed: _loadQuiz,
                ),
              ],
            ),
          ),
        ],
      );
    }

    final q = _questions[_currentIndex];
    final choices = _shuffledChoices[q.quizItemId] ?? const <String>[];
    final hasChoices = choices.isNotEmpty;
    final isAnswered = _currentAnswerResult != null;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _questionScroll,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Chỉ số câu hỏi và nội dung câu hỏi
                Center(
                  child: Text(
                    'Câu ${_currentIndex + 1}/${_questions.length}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: tt.muted,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  q.question,
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: tt.text,
                    height: 1.25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Danh sách lựa chọn A/B/C/D
                if (hasChoices)
                  ...List.generate(choices.length, (index) {
                    final choiceText = choices[index];
                    final letter = String.fromCharCode(65 + index);
                    final isSelected = choiceText == _pickedAnswer;

                    Color cardBg = tt.panel;
                    Color cardBorder = tt.line2;
                    Color textColor = tt.text;
                    Color letterBg = tt.surface;
                    Color letterBorder = tt.line2;
                    Color letterText = tt.text;

                    if (isAnswered) {
                      if (isSelected) {
                        if (_currentAnswerResult!.isCorrect) {
                          cardBg = tt.surface2;
                          cardBorder = tt.primary;
                          textColor = tt.primaryStrong;
                          letterBg = tt.primary;
                          letterBorder = tt.primary;
                          letterText = Colors.white;
                        } else {
                          cardBg = tt.danger.withValues(alpha: 0.12);
                          cardBorder = tt.danger;
                          textColor = tt.danger;
                          letterBg = tt.danger;
                          letterBorder = tt.danger;
                          letterText = Colors.white;
                        }
                      } else {
                        textColor = tt.muted;
                        cardBg = tt.panel.withValues(alpha: 0.6);
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: (_sending || isAnswered)
                              ? null
                              : () => _sendAnswer(choiceText),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 64),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: cardBorder, width: 2),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: letterBg,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: letterBorder,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Text(
                                    letter,
                                    style: TextStyle(
                                      fontFamily: 'Baloo2',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: letterText,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    choiceText,
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                else ...[
                  // Câu tự luận (không có choices)
                  TextField(
                    controller: _textController,
                    maxLength: 200,
                    enabled: !_sending && !isAnswered,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: tt.text,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nhập câu trả lời của em...',
                      hintStyle: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: tt.faint,
                      ),
                      filled: true,
                      fillColor: tt.panel,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tt.line2, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tt.line2, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: tt.primary, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _KidQuizButton(
                    label: 'Gửi câu trả lời',
                    icon: Icons.send_rounded,
                    isLoading: _sending,
                    onPressed: isAnswered
                        ? null
                        : () => _sendAnswer(_textController.text),
                  ),
                ],

                // Khối phản hồi feedback & linh vật ếch
                if (isAnswered) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _currentAnswerResult!.isCorrect
                          ? tt.surface2
                          : tt.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _currentAnswerResult!.isCorrect
                            ? tt.primary
                            : tt.line2,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TtFrog(
                          mood: _currentAnswerResult!.isCorrect
                              ? TtFrogMood.happy
                              : TtFrogMood.think,
                          size: 80,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _currentAnswerResult!.feedback.isNotEmpty
                              ? _currentAnswerResult!.feedback
                              : (_currentAnswerResult!.isCorrect
                                    ? 'Đúng rồi!'
                                    : 'Mình thử nghĩ lại nhé.'),
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: tt.text,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (_currentAnswerResult!.expGained > 0) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: tt.gold.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: tt.gold.withValues(alpha: 0.6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.stars_rounded,
                                  color: tt.goldDeep,
                                  size: 24,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '+${_currentAnswerResult!.expGained} EXP',
                                  style: TextStyle(
                                    fontFamily: 'Baloo2',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: tt.warnInk,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (_currentAnswerResult!.newBadges.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.military_tech_rounded,
                                color: tt.gold,
                                size: 24,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Em mở được ${_currentAnswerResult!.newBadges.length} huy hiệu mới',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: tt.text,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                ],
              ],
            ),
          ),
        ),

        // Footer cố định dưới đáy
        Padding(
          padding: const EdgeInsets.all(24),
          child: isAnswered
              ? _KidQuizButton(
                  label: _currentIndex < _questions.length - 1
                      ? 'Câu tiếp'
                      : 'Xem kết quả',
                  icon: _currentIndex < _questions.length - 1
                      ? Icons.arrow_forward_rounded
                      : Icons.flag_rounded,
                  isLoading: _loadingResult,
                  onPressed: _onProceedNext,
                )
              : _KidQuizButton(
                  label: 'Bỏ qua câu này',
                  icon: Icons.skip_next_rounded,
                  isSecondary: true,
                  onPressed: _onSkip,
                ),
        ),
      ],
    );
  }
}

/// Nút lớn chế độ bé với chiều cao tối thiểu 64dp, bo tròn và chữ 22sp.
class _KidQuizButton extends StatelessWidget {
  const _KidQuizButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isSecondary = false,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final bg = isSecondary ? tt.panel : tt.primaryStrong;
    final fg = isSecondary ? tt.text : Colors.white;

    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: bg.withValues(alpha: 0.5),
          disabledForegroundColor: fg.withValues(alpha: 0.5),
          elevation: isSecondary ? 0 : 2,
          side: isSecondary
              ? BorderSide(color: tt.line2, width: 2)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(fg),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 26),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
