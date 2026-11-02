import 'package:flutter/material.dart';

import '../../data/curriculum.dart';
import '../../data/sample_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/code_view.dart';
import '../../widgets/common.dart';
import '../../widgets/stat_bar.dart';

/// 04 Home (learning path). Isinya data contoh: lesson 1-2 selesai, 3 sedang berjalan, 4 terkunci.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unit = Curriculum.units.first;
    final done = Sample.doneScores.length;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 56,
            child: Row(
              children: [
                const Brand(),
                const Spacer(),
                StatBar(onTap: () => showHeartsSheet(context)),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Text('Unit ${unit.number} · ${unit.title}', style: AppText.h1),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: ProgressTrack(done / unit.lessons.length)),
                  const SizedBox(width: 12),
                  Text('$done dari ${unit.lessons.length} lesson', style: AppText.small),
                ],
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < unit.lessons.length; i++)
                _PathItem(lesson: unit.lessons[i], last: i == unit.lessons.length - 1),
              const SizedBox(height: 20),
              CardBox(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ulangi soal yang salah', style: AppText.h2),
                          Text('3 soal dari minggu ini · tanpa nyawa', style: AppText.small),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 84,
                      child: AppButton(
                        'Mulai',
                        kind: BtnKind.ghost,
                        height: 40,
                        onPressed: () => showSoon(context, 'Latihan ulang'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PathItem extends StatelessWidget {
  final Lesson lesson;
  final bool last;
  const _PathItem({required this.lesson, required this.last});

  @override
  Widget build(BuildContext context) {
    final score = Sample.doneScores[lesson.id];
    final done = score != null;
    final isCurrent = lesson.id == Sample.currentLessonId;
    final locked = !done && !isCurrent;

    void open() => showSoon(context, 'Kartu Materi');

    final Widget node;
    if (done) {
      node = _node(AppColors.accent, null, const Icon(Icons.check, color: Colors.white, size: 20));
    } else if (isCurrent) {
      node = _node(AppColors.soft, AppColors.accent, const Icon(Icons.play_arrow, color: AppColors.accent, size: 20));
    } else {
      node = _node(AppColors.raised, null, const Icon(Icons.lock_outline, color: AppColors.muted, size: 18));
    }
    final connector = last
        ? const SizedBox(height: 0)
        : Expanded(
      child: Container(
        width: 3,
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: done ? AppColors.accent : AppColors.track,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );

    final Widget content;
    if (isCurrent) {
      content = Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: CardBox(
          borderColor: AppColors.accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lesson.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              Text('Lesson ${lesson.number} · ${lesson.questions.length} soal · sekitar 4 menit', style: AppText.small),
              const SizedBox(height: 12),
              CodeBlock([lesson.intro.code.last], fontSize: 14),
              const SizedBox(height: 12),
              AppButton('Mulai lesson ${lesson.number}', onPressed: open),
            ],
          ),
        ),
      );
    } else {
      final meta = done
          ? 'Lesson ${lesson.number} · selesai, $score dari ${lesson.questions.length} benar'
          : 'Lesson ${lesson.number} · terbuka setelah lesson ${lesson.number - 1}';
      content = Padding(
        padding: EdgeInsets.only(top: 6, bottom: last ? 0 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: done ? FontWeight.w600 : FontWeight.w500,
                color: done ? AppColors.text : AppColors.muted,
              ),
            ),
            Text(meta, style: AppText.small),
          ],
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      onTap: isCurrent
          ? null
          : () {
        if (locked) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terkunci. Selesaikan lesson ${lesson.number - 1} dulu untuk membukanya.')),
          );
        } else {
          open(); // lesson selesai bisa diulang
        }
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(children: [node, connector]),
            const SizedBox(width: 14),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }

  Widget _node(Color bg, Color? ring, Widget icon) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: bg,
      shape: BoxShape.circle,
      border: ring == null ? null : Border.all(color: ring, width: 2),
    ),
    child: Center(child: icon),
  );
}

/// Info nyawa saat status bar diketuk.
void showHeartsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nyawa ${Sample.hearts} dari 5', style: AppText.h1),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    i < Sample.hearts ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.neg,
                    size: 28,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Setiap jawaban salah mengurangi satu nyawa. Nyawa pulih sendiri, satu tiap 4 jam.',
            style: AppText.lead,
          ),
          const SizedBox(height: 4),
          const Text('Streak ${Sample.streak} hari · ${Sample.xp} XP total', style: AppText.small),
        ],
      ),
    ),
  );
}