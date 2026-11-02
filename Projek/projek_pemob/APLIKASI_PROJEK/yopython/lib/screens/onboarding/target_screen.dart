import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'register_screen.dart';

/// Target harian yang bisa dipilih. Dipakai juga di Profil.
const dailyGoals = [
  (label: 'Santai', lessons: 1, xp: 10),
  (label: 'Biasa', lessons: 2, xp: 20),
  (label: 'Serius', lessons: 5, xp: 50),
];

/// 02 Target Harian. Pilihan berubah saat diketuk, jadi StatefulWidget.
class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  int selected = 1; // default: Biasa

  @override
  Widget build(BuildContext context) {
    final goal = dailyGoals[selected];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardTop(progress: 0.5),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                children: [
                  const Text('Berapa lama belajar tiap hari?', style: AppText.h1),
                  const SizedBox(height: 6),
                  const Text('Targetmu bisa diubah kapan saja di Profil.', style: AppText.lead),
                  const SizedBox(height: 16),
                  for (var i = 0; i < dailyGoals.length; i++) ...[
                    OptionTile(
                      showRadio: true,
                      state: i == selected ? OptState.selected : OptState.idle,
                      onTap: () => setState(() => selected = i),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dailyGoals[i].label),
                          Text(
                            '${dailyGoals[i].lessons} lesson · ${dailyGoals[i].xp} XP per hari',
                            style: const TextStyle(fontSize: 13, color: AppColors.muted, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text.rich(
                    TextSpan(
                      style: AppText.small,
                      children: [
                        const TextSpan(text: 'Target dipilih: '),
                        TextSpan(
                          text: goal.label,
                          style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.text),
                        ),
                        TextSpan(text: ', ${goal.xp} XP per hari'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: AppButton(
                'Lanjut',
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterScreen(dailyGoalXp: goal.xp))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bar atas onboarding: tombol kembali + progres.
class OnboardTop extends StatelessWidget {
  final double progress;
  const OnboardTop({super.key, required this.progress});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Kembali',
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(child: ProgressTrack(progress)),
          const SizedBox(width: 48),
        ],
      ),
    ),
  );
}