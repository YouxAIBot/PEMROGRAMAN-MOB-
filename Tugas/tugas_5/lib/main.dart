import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _muatTema();
  }

  Future<void> _muatTema() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('mode_gelap') ?? false;
    });
  }

  void _ubahTema(bool nilai) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('mode_gelap', nilai);
    setState(() {
      _isDarkMode = nilai;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pencatat Pengeluaran',
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: BerandaPage(
        isDarkMode: _isDarkMode,
        onThemeChanged: _ubahTema,
      ),
    );
  }
}

class Pengeluaran {
  final int? id;
  final String nama;
  final int jumlah;
  final String kategori;
  final String tanggal;

  const Pengeluaran({
    this.id,
    required this.nama,
    required this.jumlah,
    required this.kategori,
    required this.tanggal,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'nama': nama,
    'jumlah': jumlah,
    'kategori': kategori,
    'tanggal': tanggal,
  };

  factory Pengeluaran.fromMap(Map<String, Object?> m) => Pengeluaran(
    id: m['id'] as int,
    nama: m['nama'] as String,
    jumlah: m['jumlah'] as int,
    kategori: m['kategori'] as String,
    tanggal: m['tanggal'] as String,
  );
}

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path = p.join(await getDatabasesPath(), 'pengeluaran.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE pengeluaran('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'nama TEXT NOT NULL, '
              'jumlah INTEGER NOT NULL, '
              'kategori TEXT NOT NULL, '
              'tanggal TEXT NOT NULL)',
        );
      },
    );
    return _db!;
  }

  static Future<int> tambah(Pengeluaran pData) async {
    final db = await database;
    return db.insert('pengeluaran', pData.toMap());
  }

  static Future<List<Pengeluaran>> semua() async {
    final db = await database;
    final rows = await db.query('pengeluaran', orderBy: 'id DESC');
    return rows.map(Pengeluaran.fromMap).toList();
  }

  static Future<int> totalPengeluaran() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(jumlah) as total FROM pengeluaran');
    final total = result.first['total'];
    if (total != null) {
      return total as int;
    }
    return 0;
  }

  static Future<int> ubah(Pengeluaran pData) async {
    final db = await database;
    return db.update('pengeluaran', pData.toMap(), where: 'id=?', whereArgs: [pData.id]);
  }

  static Future<int> hapus(int id) async {
    final db = await database;
    return db.delete('pengeluaran', where: 'id=?', whereArgs: [id]);
  }
}

class BerandaPage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const BerandaPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<Pengeluaran> _daftarPengeluaran = [];
  int _total = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    final data = await DbHelper.semua();
    final total = await DbHelper.totalPengeluaran();
    if (!mounted) return;
    setState(() {
      _daftarPengeluaran = data;
      _total = total;
      _isLoading = false;
    });
  }

  Future<void> _bukaForm([Pengeluaran? pengeluaran]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPengeluaranPage(pengeluaran: pengeluaran),
      ),
    );
    if (!mounted) return;
    _muatData();
  }

  Future<void> _konfirmasiHapus(int id) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Pengeluaran'),
        content: const Text('Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      await DbHelper.hapus(id);
      _muatData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatat Pengeluaran'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              children: [
                const Text(
                  'Total Pengeluaran',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp $_total',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _daftarPengeluaran.isEmpty
                ? const Center(child: Text('Belum ada data pengeluaran'))
                : ListView.builder(
              itemCount: _daftarPengeluaran.length,
              itemBuilder: (context, index) {
                final pData = _daftarPengeluaran[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      pData.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${pData.kategori}\n${pData.tanggal}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Rp ${pData.jumlah}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _bukaForm(pData),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _konfirmasiHapus(pData.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bukaForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormPengeluaranPage extends StatefulWidget {
  final Pengeluaran? pengeluaran;

  const FormPengeluaranPage({super.key, this.pengeluaran});

  @override
  State<FormPengeluaranPage> createState() => _FormPengeluaranPageState();
}

class _FormPengeluaranPageState extends State<FormPengeluaranPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _namaController;
  late final TextEditingController _jumlahController;
  String? _kategoriTerpilih;

  final List<String> _kategoriOptions = [
    'Makanan',
    'Transportasi',
    'Belanja',
    'Tagihan',
    'Hiburan',
    'Lainnya'
  ];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.pengeluaran?.nama ?? '');
    _jumlahController = TextEditingController(
      text: widget.pengeluaran != null ? widget.pengeluaran!.jumlah.toString() : '',
    );
    if (widget.pengeluaran != null &&
        _kategoriOptions.contains(widget.pengeluaran!.kategori)) {
      _kategoriTerpilih = widget.pengeluaran!.kategori;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final pData = Pengeluaran(
      id: widget.pengeluaran?.id,
      nama: _namaController.text.trim(),
      jumlah: int.parse(_jumlahController.text.trim()),
      kategori: _kategoriTerpilih!,
      tanggal: widget.pengeluaran?.tanggal ?? DateTime.now().toString().split(' ')[0],
    );

    if (widget.pengeluaran == null) {
      await DbHelper.tambah(pData);
    } else {
      await DbHelper.ubah(pData);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isBaru = widget.pengeluaran == null;
    return Scaffold(
      appBar: AppBar(title: Text(isBaru ? 'Tambah Pengeluaran' : 'Ubah Pengeluaran')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Pengeluaran',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama pengeluaran wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah (Rp)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Jumlah wajib diisi';
                }
                final number = int.tryParse(value.trim());
                if (number == null || number <= 0) {
                  return 'Jumlah harus berupa angka lebih dari 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _kategoriTerpilih,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _kategoriOptions.map((String kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _kategoriTerpilih = newValue;
                });
              },
              validator: (value) => value == null ? 'Kategori wajib dipilih' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _simpan,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Simpan', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}