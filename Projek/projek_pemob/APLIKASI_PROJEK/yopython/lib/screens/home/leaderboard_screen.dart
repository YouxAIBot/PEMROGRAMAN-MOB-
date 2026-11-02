import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/stat_bar.dart';

/// 13 Peringkat minggu ini (data contoh).
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final me = leaderboard.firstWhere((r) => r.name == 'Kamu');
    final gap = leaderboard[promoteZone - 1].xp - me.xp;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(height: 56, child: Row(children: [Brand(), Spacer(), StatBar()])),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              const Text('Peringkat minggu ini', style: AppText.h1),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  style: AppText.lead,
                  children: [
                    const TextSpan(text: 'Divisi Perak · reset dalam 3 hari 4 jam. Kurang '),
                    TextSpan(
                      text: '$gap XP',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.text),
                    ),
                    const TextSpan(text: ' lagi untuk masuk zona naik.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < leaderboard.length; i++) ...[
                _Row(rank: i + 1, entry: leaderboard[i]),
                if (i == promoteZone - 1)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12, 10, 12, 6),
                    child: Text(
                      'Zona naik: 4 teratas masuk Divisi Emas',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.muted),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final int rank;
  final ({String name, int xp, Color bg, Color fg}) entry;
  const _Row({required this.rank, required this.entry});

  @override
  Widget build(BuildContext context) {
    final me = entry.name == 'Kamu';
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: me ? AppColors.soft : null,
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '$rank',
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.muted),
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: entry.bg,
            child: Text(
              me ? Sample.name[0] : entry.name[0],
              style: TextStyle(color: entry.fg, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(entry.name, style: TextStyle(fontWeight: me ? FontWeight.w600 : FontWeight.w500)),
          ),
          Text('${entry.xp} ', style: const TextStyle(fontWeight: FontWeight.w500)),
          const Text('XP', style: AppText.small),
        ],
      ),
    );
  }
}