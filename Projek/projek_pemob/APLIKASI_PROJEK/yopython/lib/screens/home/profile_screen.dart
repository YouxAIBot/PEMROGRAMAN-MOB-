import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../onboarding/target_screen.dart' show dailyGoals;
import '../onboarding/welcome_screen.dart';

/// 14 Profil dan prestasi. StatefulWidget karena pilihan target harian bisa diganti.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int goal = 1; // Biasa

  Future<void> _logout() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text('Kamu akan kembali ke layar sambutan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.negInk),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const WelcomeScreen()), (_) => false);
  }

  static const _heatColors = [AppColors.raised, AppColors.track, Color(0xFF8EC1CF), AppColors.accent, AppColors.ink];

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('Total XP', Sample.xp),
      ('Streak / terbaik', '${Sample.streak} / ${Sample.bestStreak} hari'),
      ('Lesson selesai', '${Sample.lessonsDone}'),
      ('Akurasi', '${Sample.accuracy}%'),
    ];
    const badges = [
      (title: 'Langkah pertama', desc: 'Selesaikan lesson pertama', now: 1, goal: 1),
      (title: 'Tanpa cela', desc: 'Satu lesson tanpa salah', now: 1, goal: 1),
      (title: 'Streak 7 hari', desc: 'Belajar 7 hari berturut-turut', now: Sample.streak, goal: 7),
    ];

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
                IconButton(tooltip: 'Keluar', icon: const Icon(Icons.logout), onPressed: _logout),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.accent,
                    child: Text(
                      Sample.name[0],
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Sample.name, style: AppText.h1),
                        Text('${Sample.division} · ${Sample.joined}', style: AppText.small),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CardBox(
                padding: EdgeInsets.zero,
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.4,
                  children: [
                    for (var i = 0; i < stats.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            left: i.isOdd ? const BorderSide(color: AppColors.rule) : BorderSide.none,
                            top: i > 1 ? const BorderSide(color: AppColors.rule) : BorderSide.none,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(stats[i].$1, style: AppText.small),
                            Text(stats[i].$2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              CardBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Target harian', style: AppText.h2),
                        const Spacer(),
                        Text('${dailyGoals[goal].xp} XP per hari', style: AppText.small),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SegmentedChoice(
                      options: [for (final d in dailyGoals) d.label],
                      selected: goal,
                      onChanged: (i) => setState(() => goal = i),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              CardBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Keaktifan harian', style: AppText.h2),
                        Spacer(),
                        Text('14 hari terakhir', style: AppText.small),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        for (var i = 0; i < Sample.activity.length; i++)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: i == Sample.activity.length - 1 ? 0 : 4),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _heatColors[Sample.activity[i]],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text('Lencana', style: AppText.h2),
              const SizedBox(height: 8),
              CardBox(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < badges.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: i == 0 ? null : const Border(top: BorderSide(color: AppColors.rule)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(badges[i].title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                      Text(badges[i].desc, style: AppText.small),
                                    ],
                                  ),
                                ),
                                if (badges[i].now >= badges[i].goal)
                                  const Pill('Diraih', bg: AppColors.posSoft, fg: AppColors.posInk)
                                else
                                  Text('${badges[i].now} dari ${badges[i].goal}', style: AppText.small),
                              ],
                            ),
                            if (badges[i].now < badges[i].goal) ...[
                              const SizedBox(height: 8),
                              ProgressTrack(badges[i].now / badges[i].goal),
                            ],
                          ],
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