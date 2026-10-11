//LANGKAH PRAKTIKUM BAGIAN A
//===============================
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 5',
//       home: const PengaturanPage(),
//     );
//   }
// }
//
// class PengaturanPage extends StatefulWidget {
//   const PengaturanPage({super.key});
//
//   @override
//   State<PengaturanPage> createState() => PengaturanPageState();
// }
//
// class PengaturanPageState extends State<PengaturanPage> {
//   final _controller = TextEditingController();
//   bool _gelap = false;
//   int _bukake = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _muat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _muat() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!mounted) return;
//     setState(() {
//       _controller.text = prefs.getString('nama') ?? '';
//       _gelap = prefs.getBool('gelap') ?? false;
//       _bukake = (prefs.getInt('bukake') ?? 0) + 1;
//     });
//     await prefs.setInt('bukake', _bukake);
//   }
//
//   Future<void> _simpanNama() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nama', _controller.text.trim());
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Nama disimpan')),
//     );
//   }
//
//   Future<void> _ubahTema(bool nilai) async {
//     setState(() => _gelap = nilai);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('gelap', nilai);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         brightness: _gelap ? Brightness.dark : Brightness.light,
//         colorSchemeSeed: Colors.blue,
//         useMaterial3: true,
//       ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Pengaturan')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: _simpanNama,
//                 child: const Text('Simpan nama'),
//               ),
//               SwitchListTile(
//                 title: const Text('Mode gelap'),
//                 value: _gelap,
//                 onChanged: _ubahTema,
//               ),
//               const SizedBox(height: 12),
//               Text('Aplikasi dibuka ke-$_bukake kali'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




//=========================================
//LANGKAH PRAKTIKUM BAGIAN B
//=========================================
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 5',
//       home: const PengaturanPage(),
//     );
//   }
// }
//
// class PengaturanPage extends StatefulWidget {
//   const PengaturanPage({super.key});
//
//   @override
//   State<PengaturanPage> createState() => PengaturanPageState();
// }
//
// class PengaturanPageState extends State<PengaturanPage> {
//   final _controller = TextEditingController();
//   bool _gelap = false;
//   int _bukake = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _muat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _muat() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!mounted) return;
//     setState(() {
//       _controller.text = prefs.getString('nama') ?? '';
//       _gelap = prefs.getBool('gelap') ?? false;
//       _bukake = (prefs.getInt('bukake') ?? 0) + 1;
//     });
//     await prefs.setInt('bukake', _bukake);
//   }
//
//   Future<void> _simpanNama() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nama', _controller.text.trim());
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Nama disimpan')),
//     );
//   }
//
//   Future<void> _ubahTema(bool nilai) async {
//     setState(() => _gelap = nilai);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('gelap', nilai);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         brightness: _gelap ? Brightness.dark : Brightness.light,
//         colorSchemeSeed: Colors.blue,
//         useMaterial3: true, // Diperbaiki dari useMaterial: true
//       ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Pengaturan')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: _simpanNama,
//                 child: const Text('Simpan nama'),
//               ),
//               SwitchListTile(
//                 title: const Text('Mode gelap'),
//                 value: _gelap,
//                 onChanged: _ubahTema,
//               ),
//               const SizedBox(height: 12),
//               Text('Aplikasi dibuka ke-$_bukake kali'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Catatan {
//   final int? id;
//   final String judul;
//   final String isi;
//
//   const Catatan({this.id, required this.judul, required this.isi});
//
//   //Memetakan objek ke Map untuk SQLite
//   Map<String, Object?> toMap() => {'id': id, 'judul': judul, 'isi': isi};
//
//   //Membaca Map dari SQLite menjadi objek Catatan
//   factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
//     id: m['id'] as int,
//     judul: m['judul'] as String,
//     isi: m['isi'] as String,
//   );
// }
//
// class DbHelper {
//   static Database? _db;
//
//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//
//     final path = p.join(await getDatabasesPath(), 'catatan.db');
//     _db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE catatan('
//               'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//               'judul TEXT NOT NULL, '
//               'isi TEXT NOT NULL)',
//         );
//       },
//     );
//     return _db!;
//   }
//
//   static Future<int> tambah(Catatan c) async {
//     final db = await database;
//     return db.insert('catatan', c.toMap());
//   }
//
//   static Future<List<Catatan>> semua() async {
//     final db = await database;
//     final rows = await db.query('catatan', orderBy: 'id DESC');
//     return rows.map(Catatan.fromMap).toList();
//   }
//
//   static Future<int> ubah(Catatan c) async {
//     final db = await database;
//     return db.update('catatan', c.toMap(), where: 'id=?', whereArgs: [c.id]);
//   }
//
//   static Future<int> hapus(int id) async {
//     final db = await database;
//     return db.delete('catatan', where: 'id=?', whereArgs: [id]);
//   }
// }



//=========================================
//LANGKAH PRAKTIKUM BAGIAN C
//=========================================
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 5',
//       // Diubah dari PengaturanPage menjadi CatatanPage (Bagian C)
//       home: const CatatanPage(),
//     );
//   }
// }
//
// class PengaturanPage extends StatefulWidget {
//   const PengaturanPage({super.key});
//
//   @override
//   State<PengaturanPage> createState() => PengaturanPageState();
// }
//
// class PengaturanPageState extends State<PengaturanPage> {
//   final _controller = TextEditingController();
//   bool _gelap = false;
//   int _bukake = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _muat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _muat() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!mounted) return;
//     setState(() {
//       _controller.text = prefs.getString('nama') ?? '';
//       _gelap = prefs.getBool('gelap') ?? false;
//       _bukake = (prefs.getInt('bukake') ?? 0) + 1;
//     });
//     await prefs.setInt('bukake', _bukake);
//   }
//
//   Future<void> _simpanNama() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nama', _controller.text.trim());
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Nama disimpan')),
//     );
//   }
//
//   Future<void> _ubahTema(bool nilai) async {
//     setState(() => _gelap = nilai);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('gelap', nilai);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         brightness: _gelap ? Brightness.dark : Brightness.light,
//         colorSchemeSeed: Colors.blue,
//         useMaterial3: true,
//       ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Pengaturan')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: _simpanNama,
//                 child: const Text('Simpan nama'),
//               ),
//               SwitchListTile(
//                 title: const Text('Mode gelap'),
//                 value: _gelap,
//                 onChanged: _ubahTema,
//               ),
//               const SizedBox(height: 12),
//               Text('Aplikasi dibuka ke-$_bukake kali'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Catatan {
//   final int? id;
//   final String judul;
//   final String isi;
//
//   const Catatan({this.id, required this.judul, required this.isi});
//   Map<String, Object?> toMap() => {'id': id, 'judul': judul, 'isi': isi};
//   factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
//     id: m['id'] as int,
//     judul: m['judul'] as String,
//     isi: m['isi'] as String,
//   );
// }
//
// class DbHelper {
//   static Database? _db;
//
//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//
//     final path = p.join(await getDatabasesPath(), 'catatan.db');
//     _db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE catatan('
//               'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//               'judul TEXT NOT NULL, '
//               'isi TEXT NOT NULL)',
//         );
//       },
//     );
//     return _db!;
//   }
//
//   static Future<int> tambah(Catatan c) async {
//     final db = await database;
//     return db.insert('catatan', c.toMap());
//   }
//
//   static Future<List<Catatan>> semua() async {
//     final db = await database;
//     final rows = await db.query('catatan', orderBy: 'id DESC');
//     return rows.map(Catatan.fromMap).toList();
//   }
//
//   static Future<int> ubah(Catatan c) async {
//     final db = await database;
//     return db.update('catatan', c.toMap(), where: 'id=?', whereArgs: [c.id]);
//   }
//
//   static Future<int> hapus(int id) async {
//     final db = await database;
//     return db.delete('catatan', where: 'id=?', whereArgs: [id]);
//   }
// }
//
// class CatatanPage extends StatefulWidget {
//   const CatatanPage({super.key});
//
//   @override
//   State<CatatanPage> createState() => _CatatanPageState();
// }
//
// class _CatatanPageState extends State<CatatanPage> {
//   late Future<List<Catatan>> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = DbHelper.semua();
//   }
//
//   void _muat() {
//     setState(() {
//       _future = DbHelper.semua();
//     });
//   }
//
//   Future<void> _buka([Catatan? catatan]) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => FormCatatanPage(catatan: catatan)),
//     );
//     if (!mounted) return;
//     _muat();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Catatan Saya'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const PengaturanPage()),
//               );
//             },
//           )
//         ],
//       ),
//       body: FutureBuilder<List<Catatan>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Galat: ${snapshot.error}'));
//           }
//           final data = snapshot.data!;
//           if (data.isEmpty) {
//             return const Center(child: Text('Belum ada catatan'));
//           }
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               final c = data[i];
//               return ListTile(
//                 title: Text(c.judul),
//                 subtitle: Text(c.isi, maxLines: 2, overflow: TextOverflow.ellipsis),
//                 onTap: () => _buka(c),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () async {
//                     await DbHelper.hapus(c.id!);
//                     _muat();
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _buka(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class FormCatatanPage extends StatelessWidget {
//   final Catatan? catatan;
//   const FormCatatanPage({super.key, this.catatan});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Form Catatan (Belum Selesai)')),
//     );
//   }
// }






//=========================================
//LANGKAH PRAKTIKUM BAGIAN D
//=========================================
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:path/path.dart' as p;
// import 'package:sqflite/sqflite.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 5',
//       home: const CatatanPage(),
//     );
//   }
// }
//
// class PengaturanPage extends StatefulWidget {
//   const PengaturanPage({super.key});
//
//   @override
//   State<PengaturanPage> createState() => PengaturanPageState();
// }
//
// class PengaturanPageState extends State<PengaturanPage> {
//   final _controller = TextEditingController();
//   bool _gelap = false;
//   int _bukake = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _muat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _muat() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!mounted) return;
//     setState(() {
//       _controller.text = prefs.getString('nama') ?? '';
//       _gelap = prefs.getBool('gelap') ?? false;
//       _bukake = (prefs.getInt('bukake') ?? 0) + 1;
//     });
//     await prefs.setInt('bukake', _bukake);
//   }
//
//   Future<void> _simpanNama() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nama', _controller.text.trim());
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Nama disimpan')),
//     );
//   }
//
//   Future<void> _ubahTema(bool nilai) async {
//     setState(() => _gelap = nilai);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('gelap', nilai);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         brightness: _gelap ? Brightness.dark : Brightness.light,
//         colorSchemeSeed: Colors.blue,
//         useMaterial3: true,
//       ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Pengaturan')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: _simpanNama,
//                 child: const Text('Simpan nama'),
//               ),
//               SwitchListTile(
//                 title: const Text('Mode gelap'),
//                 value: _gelap,
//                 onChanged: _ubahTema,
//               ),
//               const SizedBox(height: 12),
//               Text('Aplikasi dibuka ke-$_bukake kali'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Catatan {
//   final int? id;
//   final String judul;
//   final String isi;
//
//   const Catatan({this.id, required this.judul, required this.isi});
//
//   Map<String, Object?> toMap() => {'id': id, 'judul': judul, 'isi': isi};
//
//   factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
//     id: m['id'] as int,
//     judul: m['judul'] as String,
//     isi: m['isi'] as String,
//   );
// }
//
// class DbHelper {
//   static Database? _db;
//
//   static Future<Database> get database async {
//     if (_db != null) return _db!;
//
//     final path = p.join(await getDatabasesPath(), 'catatan.db');
//     _db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE catatan('
//               'id INTEGER PRIMARY KEY AUTOINCREMENT, '
//               'judul TEXT NOT NULL, '
//               'isi TEXT NOT NULL)',
//         );
//       },
//     );
//     return _db!;
//   }
//
//   static Future<int> tambah(Catatan c) async {
//     final db = await database;
//     return db.insert('catatan', c.toMap());
//   }
//
//   static Future<List<Catatan>> semua() async {
//     final db = await database;
//     final rows = await db.query('catatan', orderBy: 'id DESC');
//     return rows.map(Catatan.fromMap).toList();
//   }
//
//   static Future<int> ubah(Catatan c) async {
//     final db = await database;
//     return db.update('catatan', c.toMap(), where: 'id=?', whereArgs: [c.id]);
//   }
//
//   static Future<int> hapus(int id) async {
//     final db = await database;
//     return db.delete('catatan', where: 'id=?', whereArgs: [id]);
//   }
// }
//
// class CatatanPage extends StatefulWidget {
//   const CatatanPage({super.key});
//
//   @override
//   State<CatatanPage> createState() => _CatatanPageState();
// }
//
// class _CatatanPageState extends State<CatatanPage> {
//   late Future<List<Catatan>> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = DbHelper.semua();
//   }
//
//   void _muat() {
//     setState(() {
//       _future = DbHelper.semua();
//     });
//   }
//
//   Future<void> _buka([Catatan? catatan]) async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => FormCatatanPage(catatan: catatan)),
//     );
//     if (!mounted) return;
//     _muat();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Catatan Saya')),
//       body: FutureBuilder<List<Catatan>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Galat: ${snapshot.error}'));
//           }
//           final data = snapshot.data!;
//           if (data.isEmpty) {
//             return const Center(child: Text('Belum ada catatan'));
//           }
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               final c = data[i];
//               return ListTile(
//                 title: Text(c.judul),
//                 subtitle: Text(c.isi, maxLines: 2, overflow: TextOverflow.ellipsis),
//                 onTap: () => _buka(c),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () async {
//                     await DbHelper.hapus(c.id!);
//                     _muat();
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _buka(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class FormCatatanPage extends StatefulWidget {
//   final Catatan? catatan;
//   const FormCatatanPage({super.key, this.catatan});
//
//   @override
//   State<FormCatatanPage> createState() => _FormCatatanPageState();
// }
//
// class _FormCatatanPageState extends State<FormCatatanPage> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _judul;
//   late final TextEditingController _isi;
//
//   @override
//   void initState() {
//     super.initState();
//     _judul = TextEditingController(text: widget.catatan?.judul ?? '');
//     _isi = TextEditingController(text: widget.catatan?.isi ?? '');
//   }
//
//   @override
//   void dispose() {
//     _judul.dispose();
//     _isi.dispose();
//     super.dispose();
//   }
//
//   Future<void> _simpan() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final c = Catatan(
//       id: widget.catatan?.id,
//       judul: _judul.text.trim(),
//       isi: _isi.text.trim(),
//     );
//
//     if (widget.catatan == null) {
//       await DbHelper.tambah(c);
//     } else {
//       await DbHelper.ubah(c);
//     }
//
//     if (!mounted) return;
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final baru = widget.catatan == null;
//     return Scaffold(
//       appBar: AppBar(title: Text(baru ? 'Catatan Baru' : 'Ubah Catatan')),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             TextFormField(
//               controller: _judul,
//               decoration: const InputDecoration(
//                 labelText: 'Judul',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (v) =>
//               (v == null || v.trim().isEmpty) ? 'Judul wajib diisi' : null,
//             ),
//             const SizedBox(height: 12),
//             TextFormField(
//               controller: _isi,
//               maxLines: 6,
//               decoration: const InputDecoration(
//                 labelText: 'Isi catatan',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (v) =>
//               (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//                 onPressed: _simpan,
//                 child: const Text('Simpan')
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




//LATIHAN MANDIRI
//
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 5 - Latihan Mandiri',
      home: const CatatanPage(),
    );
  }
}

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => PengaturanPageState();
}

class PengaturanPageState extends State<PengaturanPage> {
  final _controller = TextEditingController();
  bool _gelap = false;
  int _bukake = 0;

  @override
  void initState() {
    super.initState();
    _muat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _muat() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _controller.text = prefs.getString('nama') ?? '';
      _gelap = prefs.getBool('gelap') ?? false;
      _bukake = (prefs.getInt('bukake') ?? 0) + 1;
    });
    await prefs.setInt('bukake', _bukake);
  }

  Future<void> _simpanNama() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', _controller.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nama disimpan')),
    );
  }

  Future<void> _ubahTema(bool nilai) async {
    setState(() => _gelap = nilai);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('gelap', nilai);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _gelap ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pengaturan')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _simpanNama,
                child: const Text('Simpan nama'),
              ),
              SwitchListTile(
                title: const Text('Mode gelap'),
                value: _gelap,
                onChanged: _ubahTema,
              ),
              const SizedBox(height: 12),
              Text('Aplikasi dibuka ke-$_bukake kali'),
            ],
          ),
        ),
      ),
    );
  }
}

class Catatan {
  final int? id;
  final String judul;
  final String isi;
  final String? dibuat;

  const Catatan({
    this.id,
    required this.judul,
    required this.isi,
    this.dibuat,
  });

  Map<String, Object?> toMap() => {
    'id': id,
    'judul': judul,
    'isi': isi,
    'dibuat': dibuat,
  };

  factory Catatan.fromMap(Map<String, Object?> m) => Catatan(
    id: m['id'] as int,
    judul: m['judul'] as String,
    isi: m['isi'] as String,
    dibuat: m['dibuat'] as String?,
  );
}

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path = p.join(await getDatabasesPath(), 'catatan.db');
    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE catatan('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'judul TEXT NOT NULL, '
              'isi TEXT NOT NULL, '
              'dibuat TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('ALTER TABLE catatan ADD COLUMN dibuat TEXT');
        }
      },
    );
    return _db!;
  }

  static Future<int> tambah(Catatan c) async {
    final db = await database;
    return db.insert('catatan', c.toMap());
  }

  static Future<List<Catatan>> semua({String? kata, bool urutTerbaru = true}) async {
    final db = await database;
    String orderBy = urutTerbaru ? 'id DESC' : 'id ASC';

    List<Map<String, Object?>> rows;

    if (kata != null && kata.isNotEmpty) {
      rows = await db.query(
        'catatan',
        where: 'judul LIKE ?',
        whereArgs: ['%$kata%'],
        orderBy: orderBy,
      );
    } else {
      rows = await db.query('catatan', orderBy: orderBy);
    }

    return rows.map(Catatan.fromMap).toList();
  }

  static Future<int> ubah(Catatan c) async {
    final db = await database;
    return db.update('catatan', c.toMap(), where: 'id=?', whereArgs: [c.id]);
  }

  static Future<int> hapus(int id) async {
    final db = await database;
    return db.delete('catatan', where: 'id=?', whereArgs: [id]);
  }
}

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  late Future<List<Catatan>> _future;
  bool _urutTerbaru = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _muatPreferensiUrutan();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _muatPreferensiUrutan() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _urutTerbaru = prefs.getBool('urut_terbaru') ?? true;
    });
    _muat();
  }

  Future<void> _simpanPreferensiUrutan(bool terbaru) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('urut_terbaru', terbaru);
    setState(() {
      _urutTerbaru = terbaru;
    });
    _muat();
  }

  void _muat() {
    setState(() {
      _future = DbHelper.semua(
        kata: _searchController.text,
        urutTerbaru: _urutTerbaru,
      );
    });
  }

  Future<void> _buka([Catatan? catatan]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormCatatanPage(catatan: catatan)),
    );
    if (!mounted) return;
    _muat();
  }

  Future<void> _konfirmasiHapus(Catatan c) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Catatan?'),
        content: Text('Apakah Anda yakin ingin menghapus "${c.judul}"?'),
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

    if (hapus == true && mounted) {
      await DbHelper.hapus(c.id!);
      _muat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Saya'),
        actions: [
          // Latihan 4: Tombol Ubah Urutan
          IconButton(
            icon: Icon(_urutTerbaru ? Icons.arrow_downward : Icons.arrow_upward),
            tooltip: 'Urutkan',
            onPressed: () => _simpanPreferensiUrutan(!_urutTerbaru),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PengaturanPage()),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Latihan 2: Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Cari judul catatan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _muat(), // Muat ulang daftar saat diketik
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Catatan>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Galat: ${snapshot.error}'));
                }
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return const Center(child: Text('Belum ada catatan'));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    final c = data[i];
                    return ListTile(
                      title: Text(c.judul),
                      // Tampilkan isi dan tanggal dibuat (jika ada)
                      subtitle: Text(
                        '${c.dibuat ?? 'Tanpa tanggal'}\n${c.isi}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => _buka(c),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _konfirmasiHapus(c), // Panggil Latihan 1
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _buka(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormCatatanPage extends StatefulWidget {
  final Catatan? catatan;
  const FormCatatanPage({super.key, this.catatan});

  @override
  State<FormCatatanPage> createState() => _FormCatatanPageState();
}

class _FormCatatanPageState extends State<FormCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _judul;
  late final TextEditingController _isi;

  @override
  void initState() {
    super.initState();
    _judul = TextEditingController(text: widget.catatan?.judul ?? '');
    _isi = TextEditingController(text: widget.catatan?.isi ?? '');
  }

  @override
  void dispose() {
    _judul.dispose();
    _isi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;
    String? tanggalDibuat = widget.catatan?.dibuat;
    if (widget.catatan == null) {
      tanggalDibuat = DateTime.now().toString().split('.')[0]; // Format: YYYY-MM-DD HH:MM:SS
    }

    final c = Catatan(
      id: widget.catatan?.id,
      judul: _judul.text.trim(),
      isi: _isi.text.trim(),
      dibuat: tanggalDibuat, // Latihan 3
    );

    if (widget.catatan == null) {
      await DbHelper.tambah(c);
    } else {
      await DbHelper.ubah(c);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final baru = widget.catatan == null;
    return Scaffold(
      appBar: AppBar(title: Text(baru ? 'Catatan Baru' : 'Ubah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judul,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Judul wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _isi,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Isi catatan',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _simpan,
                child: const Text('Simpan')
            ),
          ],
        ),
      ),
    );
  }
}