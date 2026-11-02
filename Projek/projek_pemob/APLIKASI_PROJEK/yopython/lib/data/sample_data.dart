import 'package:flutter/material.dart';

/// Angka contoh yang tampil di layar, sama dengan mockup.
/// Ini hanya untuk tampilan: belum ada logika nyawa, XP, atau penyimpanan.
class Sample {
  static const name = 'Rina';
  static const email = 'rina@email.com';
  static const division = 'Divisi Perak';
  static const joined = 'bergabung Okt 2026';

  static const streak = 4;
  static const bestStreak = 9;
  static const hearts = 5;
  static const xp = '1.240';
  static const lessonsDone = 6;
  static const accuracy = 86;

  /// Status lesson di Home: id -> jumlah benar (lesson selesai).
  static const doneScores = {'u2l1': 5, 'u2l2': 4};
  static const currentLessonId = 'u2l3';

  /// Target harian: 1 dari 2 lesson hari ini.
  static const dailyDoneLessons = 1;

  /// Hitung mundur di layar Nyawa Habis.
  static const nextHeartIn = Duration(hours: 3, minutes: 41, seconds: 20);

  /// Tingkat keaktifan 14 hari terakhir (0 = tidak aktif, 4 = sangat aktif).
  static const activity = [0, 1, 0, 2, 2, 0, 3, 1, 0, 2, 3, 3, 2, 4];
}

/// Papan peringkat contoh. 'Kamu' adalah pengguna.
const leaderboard = [
  (name: 'Dimas', xp: 410, bg: Color(0xFFE4F0E8), fg: Color(0xFF1E5A38)),
  (name: 'Sari', xp: 365, bg: Color(0xFFF6E7E1), fg: Color(0xFF7A3A22)),
  (name: 'Andi', xp: 340, bg: Color(0xFFE6EDF6), fg: Color(0xFF2A4A7A)),
  (name: 'Wulan', xp: 320, bg: Color(0xFFF2EAF6), fg: Color(0xFF5A3A74)),
  (name: 'Kamu', xp: 295, bg: Color(0xFF1B6C80), fg: Color(0xFFFFFFFF)),
  (name: 'Bayu', xp: 270, bg: Color(0xFFEAEFDD), fg: Color(0xFF4A5A1E)),
  (name: 'Putri', xp: 255, bg: Color(0xFFF7ECDD), fg: Color(0xFF7A5418)),
  (name: 'Fajar', xp: 230, bg: Color(0xFFE0F0F0), fg: Color(0xFF1E5A5A)),
];
const promoteZone = 4;