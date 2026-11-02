import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'question_views.dart';
import 'summary_screen.dart';

/// 06-10 Alur kuis: jawab, Periksa, umpan balik, lanjut.
/// StatefulWidget karena soal aktif, pilihan, nyawa, dan fase berubah terus.
/// Versi tampilan: nyawa dan XP hanya dihitung selama layar ini terbuka.
class QuizScreen extends StatefulWidget {
  final Lesson? lesson;
  final List<Question> questions;
  final bool practice; // latihan ulang: tanpa nyawa, 5 XP per soal

  QuizScreen.lesson({super.key, required Lesson this.lesson}) : questions = lesson.questions, practice = false;

  const QuizScreen.practice({super.key, required this.questions}) : lesson = null, practice = true;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

enum _Phase { answering, feedback }

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  QAnswer answer = QAnswer.empty;
  _Phase phase = _Phase.answering;
  final List<AnswerResult> results = [];
  final Stopwatch watch = Stopwatch()..start();
  int hearts = Sample.hearts;
  static const xpPerCorrect = 10;
  static const xpPerPractice = 5;

  Question get q => widget.questions[index];

  void _check() {
    if (!answer.correct && !widget.practice) hearts--;
    results.add(AnswerResult(q, answer.correct, answer.text));
    setState(() => phase = _Phase.feedback);
  }

  void _next() {
    if (!widget.practice && hearts == 0) {
      showSoon(context, 'Nyawa Habis');
      Navigator.of(context).pop();
      return;
    }
    if (index + 1 < widget.questions.length) {
      setState(() {
        index++;
        answer = QAnswer.empty;
        phase = _Phase.answering;
      });
      return;
    }
    watch.stop();
    final correct = results.where((r) => r.correct).length;
    final gained = correct * (widget.practice ? xpPerPractice : xpPerCorrect);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => SummaryScreen(
          lesson: widget.lesson,
          results: List.of(results),
          xpGained: gained,
          duration: watch.elapsed,
          practice: widget.practice,
        ),
      ),
    );
  }

  Future<void> _confirmExit() async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari lesson?'),
        content: const Text('Jawaban di sesi ini tidak disimpan. Nyawa yang sudah berkurang tidak kembali.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Lanjut belajar')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Keluar')),
        ],
      ),
    );
    if (leave == true && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.questions.length;
    final done = index + (phase == _Phase.feedback ? 1 : 0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 16),
                  child: Row(
                    children: [
                      IconButton(tooltip: 'Keluar dari lesson', icon: const Icon(Icons.close), onPressed: _confirmExit),
                      Expanded(child: ProgressTrack(done / total)),
                      const SizedBox(width: 12),
                      if (widget.practice)
                        const Pill('Latihan', bg: AppColors.soft, fg: AppColors.ink)
                      else
                        Semantics(
                          label: 'Nyawa $hearts',
                          child: Row(
                            children: [
                              const Icon(Icons.favorite, color: AppColors.neg, size: 18),
                              const SizedBox(width: 4),
                              Text('$hearts', style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                  children: [
                    Text('Soal ${index + 1} dari $total · ${q.kindLabel}', style: AppText.small),
                    const SizedBox(height: 4),
                    Text(q.prompt, style: AppText.h1),
                    const SizedBox(height: 16),
                    buildQuestionView(
                      key: ValueKey('${q.id}-$index'),
                      question: q,
                      locked: phase == _Phase.feedback,
                      onChanged: (a) => setState(() => answer = a),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: phase == _Phase.answering
                    ? Padding(
                  key: const ValueKey('check'),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: AppButton('Periksa', onPressed: answer.ready ? _check : null),
                )
                    : _FeedbackPanel(
                  key: const ValueKey('feedback'),
                  correct: answer.correct,
                  note: answer.correct ? q.correctNote : q.wrongNote(answer.choice),
                  heartsLeft: widget.practice ? null : hearts,
                  xp: widget.practice ? xpPerPractice : xpPerCorrect,
                  onNext: _next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackPanel extends StatelessWidget {
  final bool correct;
  final String note;
  final int? heartsLeft; // null saat latihan
  final int xp;
  final VoidCallback onNext;
  const _FeedbackPanel({
    super.key,
    required this.correct,
    required this.note,
    required this.heartsLeft,
    required this.xp,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final ink = correct ? AppColors.posInk : AppColors.negInk;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: correct ? AppColors.posSoft : AppColors.negSoft,
        border: Border(top: BorderSide(color: correct ? const Color(0xFFA9DDB9) : const Color(0xFFF2C4BF))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                correct ? 'Benar' : 'Belum tepat',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: ink),
              ),
              const Spacer(),
              if (correct)
                Pill('+$xp XP', bg: Colors.white, fg: ink)
              else if (heartsLeft != null)
                Pill('Nyawa −1 · sisa $heartsLeft', bg: Colors.white, fg: ink),
            ],
          ),
          const SizedBox(height: 10),
          Text(note, style: TextStyle(color: ink, height: 1.5, fontSize: 15)),
          const SizedBox(height: 12),
          AppButton(
            heartsLeft == 0 ? 'Lihat nyawa' : 'Lanjut',
            kind: correct ? BtnKind.primary : BtnKind.danger,
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}