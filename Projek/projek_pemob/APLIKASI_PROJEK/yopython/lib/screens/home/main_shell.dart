import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'home_screen.dart';
import 'leaderboard_screen.dart';

/// Tiga tab bawah: Belajar, Peringkat, Profil. Tab aktif disimpan di state.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: tab, children: const [HomeScreen(), LeaderboardScreen(), _Soon('Profil')]),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.soft,
          labelTextStyle: WidgetStateProperty.resolveWith(
                (s) => TextStyle(
              fontSize: 12,
              fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
              color: s.contains(WidgetState.selected) ? AppColors.ink : AppColors.muted,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
                (s) => IconThemeData(color: s.contains(WidgetState.selected) ? AppColors.accent : AppColors.muted),
          ),
        ),
        child: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Belajar',
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined),
              selectedIcon: Icon(Icons.emoji_events),
              label: 'Peringkat',
            ),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

/// Sementara: tab yang halamannya belum dibuat.
class _Soon extends StatelessWidget {
  final String name;
  const _Soon(this.name);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text('Halaman $name dibuat di langkah berikutnya.', style: AppText.lead));
}