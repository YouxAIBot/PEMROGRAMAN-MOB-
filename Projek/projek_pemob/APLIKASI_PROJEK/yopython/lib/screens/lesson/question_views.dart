import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'fill_view.dart';
import 'output_view.dart';
import 'parsons_view.dart';
import 'spot_bug_view.dart';

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
    FillQuestion q => FillView(key: key, q: q, locked: locked, onChanged: onChanged),
    SpotBugQuestion q => SpotBugView(key: key, q: q, locked: locked, onChanged: onChanged),
    OutputQuestion q => OutputView(key: key, q: q, locked: locked, onChanged: onChanged),
  };
}

// ======================= Soal pilihan (dasar) =======================
/// Menyimpan pilihan dan menghitung warna tiap opsi.
mixin ChoiceLogic<T extends StatefulWidget> on State<T> {
  int? selected;
  ChoiceQuestion get cq;
  bool get locked;
  ValueChanged<QAnswer> get onChanged;

  void pick(int i) {
    if (locked) return;
    setState(() => selected = i);
    onChanged(QAnswer(ready: true, correct: i == cq.correctIndex, choice: i, text: cq.choices[i]));
  }

  OptState stateOf(int i) {
    if (!locked) return i == selected ? OptState.selected : OptState.idle;
    if (i == cq.correctIndex) return OptState.correct; // tampilkan jawaban benar
    if (i == selected) return OptState.wrong;
    return OptState.dim;
  }

  Widget? tagOf(int i) {
    if (!locked) return null;
    if (i == cq.correctIndex && selected != cq.correctIndex) {
      return const Pill('Jawaban benar', bg: AppColors.posSoft, fg: AppColors.posInk);
    }
    if (i == selected && selected != cq.correctIndex) {
      return const Pill('Pilihanmu', bg: AppColors.negSoft, fg: AppColors.negInk);
    }
    return null;
  }

  Widget options({bool mono = true}) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < cq.choices.length; i++) ...[
        OptionTile(
          state: stateOf(i),
          onTap: () => pick(i),
          trailing: tagOf(i),
          child: Text(cq.choices[i], style: mono ? const TextStyle(fontFamily: AppTheme.mono, fontSize: 15) : null),
        ),
        const SizedBox(height: 12),
      ],
    ],
  );
}