import 'package:flutter/material.dart';

/// Warna YoPython, sama persis dengan mockup.
class AppColors {
  static const ground = Color(0xFFF6F9FA); // latar layar
  static const surface = Color(0xFFFFFFFF); // kartu
  static const raised = Color(0xFFEEF3F4); // tombol nonaktif, latar segmen
  static const border = Color(0xFFE3E8EA);
  static const rule = Color(0xFFEEF1F2);
  static const control = Color(0xFFC9D1D4); // garis tombol pilihan
  static const text = Color(0xFF12161A);
  static const muted = Color(0xFF566066);
  static const accent = Color(0xFF1B6C80); // warna utama
  static const soft = Color(0xFFEAF4F7); // latar pilihan terpilih
  static const track = Color(0xFFCFE6EC); // latar progress bar
  static const ink = Color(0xFF0F4553);
  static const pos = Color(0xFF1E7B4F); // benar
  static const posSoft = Color(0xFFDCFAE5);
  static const posInk = Color(0xFF04250E);
  static const neg = Color(0xFFC4242A); // salah / nyawa
  static const negSoft = Color(0xFFFFEDEA);
  static const negInk = Color(0xFF831C1E);
  static const amber = Color(0xFFA86F0C); // streak
  static const code = Color(0xFF12161A); // latar blok kode
  static const codeInk = Color(0xFFE8EEF0);
  static const codeKeyword = Color(0xFF9FC9D6);
  static const codeNumber = Color(0xFFE3B65B);
  static const codeString = Color(0xFF9BD6A8);
  static const codeComment = Color(0xFF8A989D);
}

class AppTheme {
  static const radius = 8.0;
  static const sans = 'IBMPlexSans';
  static const mono = 'IBMPlexMono';

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: sans,
      scaffoldBackgroundColor: AppColors.ground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        primary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.neg,
      ),
      splashFactory: InkRipple.splashFactory,
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(bodyColor: AppColors.text, displayColor: AppColors.text),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ground,
        foregroundColor: AppColors.text,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.text,
      ),
    );
  }
}

/// Gaya teks yang dipakai berulang.
class AppText {
  static const h1 = TextStyle(fontSize: 24, height: 1.2, fontWeight: FontWeight.w600, color: AppColors.text);
  static const h2 = TextStyle(fontSize: 16, height: 1.3, fontWeight: FontWeight.w600, color: AppColors.text);
  static const lead = TextStyle(fontSize: 15, height: 1.5, color: AppColors.muted);
  static const body = TextStyle(fontSize: 16, height: 1.5, color: AppColors.text);
  static const small = TextStyle(fontSize: 13, height: 1.4, color: AppColors.muted);
  static const mono =
  TextStyle(fontFamily: AppTheme.mono, fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.text);
}