import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/curriculum.dart';
import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/stat_bar.dart';
import 'quiz_screen.dart';

/// 12 Nyawa habis. StatefulWidget karena ada hitung mundur tiap detik.
class NoHeartsScreen extends StatefulWidget {
  const NoHeartsScreen({super.key});

  @override
  State<NoHeartsScreen> createState() => _NoHeartsScreenState();
}

class _NoHeartsScreenState extends State<NoHeartsScreen> {
  Duration left = Sample.nextHeartIn;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || left == Duration.zero) return;
      setState(() => left -= const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(height: 56, child: Row(children: [Brand(), Spacer(), StatBar(hearts: 0)])),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                children: [
                  Text('Nyawamu habis', style: AppText.h1.copyWith(fontSize: 32)),
                  const SizedBox(height: 8),
                  const Text(
                    'XP dari soal yang sudah kamu jawab benar tetap tersimpan. Nyawa pulih sendiri, satu tiap 4 jam.',
                    style: TextStyle(fontSize: 16, height: 1.5, color: AppColors.muted),
                  ),
                  const SizedBox(height: 20),
                  CardBox(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nyawa berikutnya pulih dalam', style: AppText.small),
                        const SizedBox(height: 12),
                        Text(_fmt(left), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500, height: 1)),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            for (var i = 0; i < 5; i++)
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.favorite_border, color: AppColors.neg, size: 28),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CardBox(
                    child: Row(
                      children: [
                        Text('Latihan ulang', style: TextStyle(color: AppColors.muted)),
                        Spacer(),
                        Text('5 XP per soal, tanpa nyawa', style: AppText.small),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                children: [
                  AppButton(
                    'Latihan ulang tanpa nyawa',
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => QuizScreen.practice(questions: Curriculum.practiceQuestions)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppButton('Kembali ke Home', kind: BtnKind.ghost, onPressed: () => Navigator.of(context).pop()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}