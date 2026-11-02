import '../models/models.dart';

/// Data contoh untuk tampilan. Isinya mengikuti mockup: Unit 2 dengan 4 lesson.
/// Nanti bisa diganti data dari API Laravel tanpa mengubah layar.
class Curriculum {
  static const List<Unit> units = [unit2];

  static List<Lesson> get allLessons => [for (final u in units) ...u.lessons];

  /// Soal contoh untuk "Ulangi soal yang salah" (3 soal minggu ini).
  static List<Question> get practiceQuestions {
    final all = [for (final l in allLessons) ...l.questions];
    const ids = ['u2l1q4', 'u2l2q1', 'u2l3q4'];
    return [for (final id in ids) all.firstWhere((q) => q.id == id)];
  }
}

const unit2 = Unit(number: 2, title: 'Tipe data dan operator', lessons: [u2l1, u2l2, u2l3, u2l4]);

const u2l1 = Lesson(
  id: 'u2l1',
  unitNumber: 2,
  number: 1,
  title: 'Angka dan operator',
  intro: LessonIntro(
    heading: 'Operator untuk berhitung',
    body: '+ tambah, - kurang, * kali, / bagi. // membagi lalu membulatkan ke bawah, % mengambil sisa bagi.',
    code: ['print(7 // 2)', 'print(7 % 2)'],
    output: '3\n1',
  ),
  questions: [
    ParsonsQuestion(
      id: 'u2l1q1',
      prompt: 'Susun baris agar mencetak 12',
      correctNote: '3 dikali 4 menjadi 12.',
      fixedTop: ['n = 3'],
      bank: ['print(n)', 'n = n * 4', 'n = n + 4'],
      answer: [1, 0],
      wrong: '3 dikali 4 menjadi 12, lalu dicetak. Kalau ditambah 4 hasilnya 7.',
    ),
    FillQuestion(
      id: 'u2l1q2',
      prompt: 'Lengkapi agar hasilnya 1',
      correctNote: '% mengambil sisa bagi: 10 dibagi 3 sisa 1.',
      code: ['print(10 ___ 3)', '# hasil: 1'],
      choices: ['%', '//', '/'],
      correctIndex: 0,
      wrongNotes: {
        1: '// adalah pembagian bulat: 10 // 3 hasilnya 3.',
        2: '/ adalah pembagian biasa: 10 / 3 hasilnya 3.333...',
      },
    ),
    SpotBugQuestion(
      id: 'u2l1q3',
      prompt: 'Pilih perbaikan untuk baris 2',
      correctNote: 'Perkalian di Python memakai tanda *.',
      code: ['harga = 5000', 'total = harga x 3', 'print(total)'],
      bugLine: 1,
      choices: ['total = harga * 3', 'total = harga X 3', 'total = harga . 3'],
      correctIndex: 0,
      wrongNotes: {
        1: 'Huruf X bukan operator di Python. Perkalian memakai *.',
        2: 'Titik bukan operator perkalian. Perkalian memakai *.',
      },
    ),
    OutputQuestion(
      id: 'u2l1q4',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: '* dikerjakan sebelum +: 3 * 4 = 12, lalu 2 + 12 = 14.',
      code: ['print(2 + 3 * 4)'],
      choices: ['20', '14', '24'],
      correctIndex: 1,
      wrongNotes: {
        0: '* dikerjakan dulu sebelum +: 3 * 4 = 12, lalu 2 + 12 = 14.',
        2: '* dikerjakan dulu sebelum +: 3 * 4 = 12, lalu 2 + 12 = 14.',
      },
    ),
    OutputQuestion(
      id: 'u2l1q5',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: 'Operator / selalu menghasilkan float, jadi 9 / 3 = 3.0.',
      code: ['print(9 / 3)'],
      choices: ['3', '3.0', '3.3'],
      correctIndex: 1,
      wrongNotes: {
        0: 'Operator / selalu menghasilkan float, jadi hasilnya 3.0.',
        2: '9 dibagi 3 tepat 3, dan / menghasilkan float: 3.0.',
      },
    ),
  ],
);

const u2l2 = Lesson(
  id: 'u2l2',
  unitNumber: 2,
  number: 2,
  title: 'Teks (string)',
  intro: LessonIntro(
    heading: 'Teks di Python disebut string',
    body: 'String diapit tanda kutip. len() menghitung jumlah karakter, dan + menyambung dua teks.',
    code: ['kata = "Halo"', 'print(len(kata))', 'print(kata + "!")'],
    output: '4\nHalo!',
  ),
  questions: [
    ParsonsQuestion(
      id: 'u2l2q1',
      prompt: 'Susun baris agar mencetak Halo Rina',
      correctNote: 'Teks disambung dulu dengan +, lalu dicetak.',
      fixedTop: ['nama = "Rina"'],
      bank: ['print(sapa)', 'sapa = "Halo " + nama', 'sapa = "Halo" + nama'],
      answer: [1, 0],
      wrong: 'Perlu spasi setelah Halo agar hasilnya "Halo Rina". Buat teksnya dulu, baru cetak.',
    ),
    FillQuestion(
      id: 'u2l2q2',
      prompt: 'Lengkapi agar mencetak jumlah huruf',
      correctNote: 'len() menghitung jumlah karakter: Bogor ada 5 huruf.',
      code: ['kota = "Bogor"', 'print(___(kota))', '# hasil: 5'],
      choices: ['len', 'print', 'str'],
      correctIndex: 0,
      wrongNotes: {
        1: 'print di dalam print tidak menghitung apa pun. Untuk jumlah karakter, pakai len().',
        2: 'str() mengubah nilai menjadi teks, bukan menghitung panjangnya.',
      },
    ),
    SpotBugQuestion(
      id: 'u2l2q3',
      prompt: 'Pilih perbaikan untuk baris 1',
      correctNote: 'Tanda kutip pembuka dan penutup harus sama.',
      code: ['salam = "Selamat pagi\'', 'print(salam)'],
      bugLine: 0,
      choices: ['salam = "Selamat pagi"', 'salam = Selamat pagi', 'salam = "Selamat" pagi"'],
      correctIndex: 0,
      wrongNotes: {
        1: 'Teks tanpa tanda kutip dianggap kode, jadi error.',
        2: 'Tanda kutip harus sepasang: satu di awal teks, satu di akhir.',
      },
    ),
    OutputQuestion(
      id: 'u2l2q4',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: 'Tanda * pada teks mengulang teksnya: ab tiga kali.',
      code: ['print("ab" * 3)'],
      choices: ['ababab', 'ab3', 'ab ab ab'],
      correctIndex: 0,
      wrongNotes: {
        1: 'Tanda * pada teks mengulang teksnya, bukan menempelkan angka.',
        2: 'Teks diulang tanpa spasi, jadi hasilnya ababab.',
      },
    ),
    OutputQuestion(
      id: 'u2l2q5',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: 'P-y-t-h-o-n ada 6 huruf.',
      code: ['print(len("Python"))'],
      choices: ['6', '5', 'Python'],
      correctIndex: 0,
      wrongNotes: {
        1: 'Hitung lagi: P-y-t-h-o-n ada 6 huruf.',
        2: 'len() mengembalikan jumlah karakter, bukan teksnya.',
      },
    ),
  ],
);

const u2l3 = Lesson(
  id: 'u2l3',
  unitNumber: 2,
  number: 3,
  title: 'Tipe data dasar',
  intro: LessonIntro(
    heading: 'Python punya beberapa tipe data',
    body:
    'Angka bulat disebut int, angka desimal float, dan teks str. Tipe menentukan apa yang bisa dilakukan pada sebuah nilai.',
    code: ['# tiga tipe data', 'umur = 17', 'tinggi = 1.65', 'nama = "Budi"', 'print(type(umur))'],
    output: "<class 'int'>",
  ),
  questions: [
    ParsonsQuestion(
      id: 'u2l3q1',
      prompt: 'Susun baris agar mencetak 5',
      correctNote: 'Nilai total ditambah 5 dulu, baru dicetak.',
      fixedTop: ['total = 0'],
      bank: ['print(total)', 'total = total + 5', 'total = total - 5'],
      answer: [1, 0],
      wrong: 'Urutannya: total = 0, lalu total = total + 5, baru print(total). Kode berjalan dari atas ke bawah.',
    ),
    FillQuestion(
      id: 'u2l3q2',
      prompt: 'Lengkapi kode agar mencetak nama',
      correctNote: 'print() menampilkan isi variabel ke layar.',
      code: ['nama = str("Budi")', '___(nama)'],
      choices: ['print', 'input', 'len'],
      correctIndex: 0,
      wrongNotes: {
        1: 'input() meminta ketikan dari pengguna, bukan mencetak. Untuk menampilkan nama, pakai print().',
        2: 'len() menghitung panjang teks, bukan mencetaknya. Untuk menampilkan nama, pakai print().',
      },
    ),
    SpotBugQuestion(
      id: 'u2l3q3',
      prompt: 'Pilih perbaikan untuk baris 2',
      correctNote: 'Baris if harus diakhiri titik dua (:).',
      code: ['umur = 17', 'if umur >= 17', '    print("Boleh")'],
      bugLine: 1,
      choices: ['if umur >= 17:', 'if umur => 17:', 'if (umur >= 17)'],
      correctIndex: 0,
      wrongNotes: {
        1: 'Operator => tidak ada di Python. Pakai >= lalu akhiri baris dengan titik dua (:).',
        2: 'Kurung boleh dipakai, tapi baris if tetap harus diakhiri titik dua (:).',
      },
    ),
    OutputQuestion(
      id: 'u2l3q4',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: 'Tanda * berarti perkalian, jadi 3 * 2 = 6.',
      code: ['x = 3', 'y = 2', 'print(x * y)'],
      choices: ['5', '6', '32'],
      correctIndex: 1,
      wrongNotes: {
        0: '5 adalah hasil x + y. Tanda * berarti perkalian, jadi 3 * 2 = 6.',
        2: '32 muncul bila angka ditulis berdampingan. Di Python, tanda * berarti perkalian, jadi 3 * 2 = 6.',
      },
    ),
    OutputQuestion(
      id: 'u2l3q5',
      prompt: 'Apa yang dicetak kode ini?',
      correctNote: 'Angka berkoma termasuk float.',
      code: ['print(type(1.65))'],
      choices: ["<class 'float'>", "<class 'int'>", "<class 'str'>"],
      correctIndex: 0,
      wrongNotes: {
        1: 'int hanya untuk angka bulat. Angka berkoma seperti 1.65 adalah float.',
        2: '1.65 ditulis tanpa tanda kutip, jadi ia angka, bukan teks.',
      },
    ),
  ],
);

/// Lesson 4 masih terkunci di tampilan contoh, jadi soalnya belum diisi.
const u2l4 = Lesson(
  id: 'u2l4',
  unitNumber: 2,
  number: 4,
  title: 'Input dari pengguna',
  intro: LessonIntro(
    heading: 'input() meminta ketikan dari pengguna',
    body: 'Hasil input() selalu berupa teks.',
    code: ['nama = input("Siapa namamu? ")', 'print("Halo " + nama)'],
    output: 'Siapa namamu? Rina\nHalo Rina',
  ),
  questions: [],
);