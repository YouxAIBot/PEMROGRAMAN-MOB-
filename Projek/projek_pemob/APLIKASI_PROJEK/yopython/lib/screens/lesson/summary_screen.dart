import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

/// 11 Ringkasan lesson.
class SummaryScreen extends StatelessWidget {
  final Lesson? lesson;
  final List<AnswerResult> results;
  final int xpGained;
  final Duration duration;
  final bool practice;
  const SummaryScreen({
    super.key,
    required this.lesson,
    required this.results,
    required this.xpGained,
    required this.duration,
    required this.practice,
  });

  @override
  Widget build(BuildContext context) {
    final correct = results.where((r) => r.correct).length;
    final total = results.length;
    final acc = total == 0 ? 0 : (correct * 100 / total).round();
    final wrong = results.where((r) => !r.correct).toList();
    final time = '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    final subtitle = practice
        ? 'Latihan ulang · $correct dari $total soal benar'
        : '${lesson!.title} · $correct dari $total soal benar';

    Widget kv(String k, String v) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(k, style: const TextStyle(color: AppColors.muted)),
          const Spacer(),
          Text(v, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
    const divider = Divider(height: 1, color: AppColors.rule);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(height: 56, child: Row(children: const [Brand()])),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                children: [
                  Text(practice ? 'Latihan selesai' : 'Lesson selesai', style: AppText.h1.copyWith(fontSize: 32)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: AppText.lead),
                  const SizedBox(height: 20),
                  CardBox(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        kv('XP didapat', '+$xpGained'),
                        divider,
                        kv('Akurasi', '$acc%'),
                        divider,
                        kv('Waktu', time),
                        divider,
                        kv('Streak', '${Sample.streak} hari'),
                      ],
                    ),
                  ),
                  if (wrong.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    CardBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Perlu diulang', style: AppText.h2),
                          const SizedBox(height: 6),
                          for (final r in wrong)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Text(r.question.prompt)),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      r.chosenText ?? '',
                                      textAlign: TextAlign.right,
                                      style: AppText.small.copyWith(fontFamily: AppTheme.mono),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 4),
                          const Text('Soal ini masuk ke "Ulangi soal yang salah" di Home.', style: AppText.small),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  CardBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text('Target harian', style: AppText.h2),
                            Spacer(),
                            Text('${Sample.dailyDoneLessons} dari 2 lesson', style: AppText.small),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const ProgressTrack(Sample.dailyDoneLessons / 2),
                        const SizedBox(height: 8),
                        const Text('Satu lesson lagi untuk menyelesaikan targetmu hari ini.', style: AppText.small),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: AppButton('Kembali ke Home', onPressed: () => Navigator.of(context).pop()),
            ),
          ],
        ),
      ),
    );
  }
}