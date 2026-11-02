import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'parsons_view.dart';

/// Jawaban yang sedang dipilih pengguna.
class QAnswer {
  final bool ready; // tombol Periksa boleh aktif
  final bool correct;
  final int? choice; // indeks pilihan (soal pilihan)
  final String? text; // jawaban dalam bentuk teks, untuk ringkasan
  const QAnswer({required this.ready, required this.correct, this.choice, this.text});
  static const empty = QAnswer(ready: false, correct: false);
}

/// Memilih tampilan sesuai tipe soal. `switch` pada sealed class wajib lengkap,
/// jadi kalau nanti ada tipe soal baru, Dart akan mengingatkan di sini.
Widget buildQuestionView({
  required Key key,
  required Question question,
  required bool locked,
  required ValueChanged<QAnswer> onChanged,
}) {
  return switch (question) {
    ParsonsQuestion q => ParsonsView(key: key, q: q, locked: locked, onChanged: onChanged),
    _ => ComingSoonView(key: key, onChanged: onChanged), // sementara
  };
}

/// Sementara: tipe soal yang belum dibuat. Dihapus di langkah 9.
class ComingSoonView extends StatelessWidget {
  final ValueChanged<QAnswer> onChanged;
  const ComingSoonView({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) => CardBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipe soal ini dibuat di langkah berikutnya.', style: AppText.body),
        const SizedBox(height: 12),
        AppButton(
          'Anggap benar (sementara)',
          kind: BtnKind.ghost,
          onPressed: () => onChanged(const QAnswer(ready: true, correct: true)),
        ),
      ],
    ),
  );
}