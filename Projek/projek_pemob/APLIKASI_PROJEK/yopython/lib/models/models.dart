// Model data YoPython.
// Nanti, data ini bisa diisi dari API Laravel (lihat lib/data/curriculum.dart).

class Unit {
  final int number;
  final String title;
  final List<Lesson> lessons;
  const Unit({required this.number, required this.title, required this.lessons});
}

class Lesson {
  final String id; // contoh: 'u2l1'
  final int unitNumber;
  final int number;
  final String title;
  final LessonIntro intro;
  final List<Question> questions;
  const Lesson({
    required this.id,
    required this.unitNumber,
    required this.number,
    required this.title,
    required this.intro,
    required this.questions,
  });

  int get minutes => (questions.length * 0.8).ceil();
}

/// Kartu materi singkat sebelum kuis.
class LessonIntro {
  final String heading;
  final String body;
  final List<String> code;
  final String output;
  const LessonIntro({required this.heading, required this.body, required this.code, required this.output});
}

/// Semua tipe soal turunan dari Question.
sealed class Question {
  final String id;
  final String prompt; // judul soal, contoh: "Apa yang dicetak kode ini?"
  final String correctNote; // penjelasan saat benar
  const Question({required this.id, required this.prompt, required this.correctNote});

  String get kindLabel;

  /// Penjelasan saat salah. [answer] berisi indeks pilihan (atau null untuk Parsons).
  String wrongNote(int? answer);
}

/// Susun kode: ketuk baris dari bank untuk mengisi slot.
class ParsonsQuestion extends Question {
  final List<String> fixedTop; // baris yang sudah terpasang di atas
  final List<String> bank; // baris yang bisa dipilih (termasuk pengecoh)
  final List<int> answer; // urutan indeks bank yang benar
  final String wrong;
  const ParsonsQuestion({
    required super.id,
    required super.prompt,
    required super.correctNote,
    required this.fixedTop,
    required this.bank,
    required this.answer,
    required this.wrong,
  });

  @override
  String get kindLabel => 'Susun kode';

  @override
  String wrongNote(int? answer) => wrong;

  bool isCorrect(List<int> placed) {
    if (placed.length != answer.length) return false;
    for (var i = 0; i < answer.length; i++) {
      if (placed[i] != answer[i]) return false;
    }
    return true;
  }
}

/// Soal pilihan (isian, temukan bug, prediksi output) punya pola yang sama.
sealed class ChoiceQuestion extends Question {
  final List<String> choices;
  final int correctIndex;
  final Map<int, String> wrongNotes; // penjelasan per pilihan salah
  const ChoiceQuestion({
    required super.id,
    required super.prompt,
    required super.correctNote,
    required this.choices,
    required this.correctIndex,
    required this.wrongNotes,
  });

  @override
  String wrongNote(int? answer) => wrongNotes[answer] ?? wrongNotes.values.first;
}

/// Isi bagian kosong. Tulis `___` di baris kode untuk kotak kosong.
class FillQuestion extends ChoiceQuestion {
  final List<String> code;
  const FillQuestion({
    required super.id,
    required super.prompt,
    required super.correctNote,
    required this.code,
    required super.choices,
    required super.correctIndex,
    required super.wrongNotes,
  });

  @override
  String get kindLabel => 'Isi bagian kosong';
}

/// Temukan bug: baris [bugLine] ditandai, pengguna memilih perbaikannya.
class SpotBugQuestion extends ChoiceQuestion {
  final List<String> code;
  final int bugLine; // indeks mulai dari 0
  const SpotBugQuestion({
    required super.id,
    required super.prompt,
    required super.correctNote,
    required this.code,
    required this.bugLine,
    required super.choices,
    required super.correctIndex,
    required super.wrongNotes,
  });

  @override
  String get kindLabel => 'Temukan bug';
}

/// Prediksi output.
class OutputQuestion extends ChoiceQuestion {
  final List<String> code;
  const OutputQuestion({
    required super.id,
    required super.prompt,
    required super.correctNote,
    required this.code,
    required super.choices,
    required super.correctIndex,
    required super.wrongNotes,
  });

  @override
  String get kindLabel => 'Prediksi output';
}

/// Hasil satu soal di dalam sesi kuis.
class AnswerResult {
  final Question question;
  final bool correct;
  final String? chosenText; // jawaban pengguna (untuk ringkasan)
  const AnswerResult(this.question, this.correct, this.chosenText);
}