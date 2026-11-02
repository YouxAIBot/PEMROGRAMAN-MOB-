import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../theme/app_theme.dart';

/// Streak, nyawa, XP di kanan atas (angka contoh dari mockup).
class StatBar extends StatelessWidget {
  final int hearts;
  final VoidCallback? onTap;
  const StatBar({super.key, this.hearts = Sample.hearts, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget stat(IconData icon, Color color, String value, String label) => Semantics(
      label: label,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          ],
        ),
      ),
    );
    return InkWell(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      onTap: onTap,
      child: SizedBox(
        height: 44,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            stat(Icons.local_fire_department, AppColors.amber, '${Sample.streak}', 'Streak ${Sample.streak} hari'),
            stat(Icons.favorite, AppColors.neg, '$hearts', 'Nyawa $hearts'),
            stat(Icons.bolt, AppColors.accent, Sample.xp, '${Sample.xp} XP'),
          ],
        ),
      ),
    );
  }
}