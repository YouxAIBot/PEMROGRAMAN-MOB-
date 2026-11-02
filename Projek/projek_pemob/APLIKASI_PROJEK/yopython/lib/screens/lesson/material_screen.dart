import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_view.dart';
import '../../widgets/common.dart';

/// 05 Kartu Materi. Hanya menampilkan data lesson, jadi StatelessWidget.
class MaterialScreen extends StatelessWidget {
  final Lesson lesson;
  const MaterialScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final intro = lesson.intro;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Keluar dari lesson',
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Center(child: Text(lesson.title, style: AppText.h2)),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                children: [
                  Text(intro.heading, style: AppText.h1.copyWith(fontSize: 26)),
                  const SizedBox(height: 18),
                  Text(intro.body, style: AppText.body),
                  const SizedBox(height: 18),
                  CodeBlock(intro.code),
                  const SizedBox(height: 12),
                  OutputBox(intro.output),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: AppButton('Mulai kuis', onPressed: () => showSoon(context, 'Kuis')),
            ),
          ],
        ),
      ),
    );
  }
}