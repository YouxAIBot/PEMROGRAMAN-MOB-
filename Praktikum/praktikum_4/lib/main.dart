//LANGKAH BAGIAN PRAKTIKUM A
// import 'package:flutter/material.dart';
// void main() => runApp(const MyApp());
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 4',
//       theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
//       home: const SalamPage(),
//     );
//   }
// }
// Future<String> ambilSalam() async {
//   await Future.delayed(const Duration(seconds: 2));
//   return 'Halo dari masa depan!';
// }
// class SalamPage extends StatefulWidget {
//   const SalamPage({super.key});
//   @override
//   State<SalamPage> createState() => _SalamPageState();
// }
// class _SalamPageState extends State<SalamPage> {
//   late Future<String> _future;
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilSalam();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Demo Future')),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
//           },
//         ),
//       ),
//     );
//   }
// }







//LANGKAH PRAKTIKUM BAGIAN B DAN C
//JALANKAN "flutter pub add http"
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class Pengguna {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String website;
//
//   const Pengguna ({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.website,
// });
//
//   factory Pengguna.fromJson(Map<String, dynamic> json) {
//     return Pengguna (
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       website: json['website'] as String,
//     );
//   }
// }
//
//
// Future<List<Pengguna>> ambilPengguna() async {
//   final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
//   final response = await http.get(uri).timeout(const Duration(seconds: 10));
//   if (response.statusCode != 200) {
//     throw Exception('Gagal memuat data (kode ${response.statusCode})');
//   }
//   final List<dynamic> data = jsonDecode(response.body);
//   return data
//       .map((e) => Pengguna.fromJson(e as Map<String, dynamic>))
//       .toList();
// }
//
//
// void main() => runApp(const MyApp());
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 4',
//       theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
//       home: const SalamPage(),
//     );
//   }
// }
// Future<String> ambilSalam() async {
//   await Future.delayed(const Duration(seconds: 2));
//   return 'Halo dari masa depan!';
// }
// class SalamPage extends StatefulWidget {
//   const SalamPage({super.key});
//   @override
//   State<SalamPage> createState() => _SalamPageState();
// }
// class _SalamPageState extends State<SalamPage> {
//   late Future<String> _future;
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilSalam();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Demo Future')),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
//           },
//         ),
//       ),
//     );
//   }
// }



//LANGKAH PRAKTIKUM BAGIAN D
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// // ==========================================
// // BAGIAN C: MODEL DATA PENGGUNA
// // ==========================================
// class Pengguna {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String website;
//
//   const Pengguna({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.website,
//   });
//
//   factory Pengguna.fromJson(Map<String, dynamic> json) {
//     return Pengguna(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       website: json['website'] as String,
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN C: FUNGSI PENGAMBIL DATA REST API
// // ==========================================
// Future<List<Pengguna>> ambilPengguna() async {
//   final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
//   final response = await http.get(uri).timeout(const Duration(seconds: 10));
//   if (response.statusCode != 200) {
//     throw Exception('Gagal memuat data (kode ${response.statusCode})');
//   }
//   final List<dynamic> data = jsonDecode(response.body);
//   return data
//       .map((e) => Pengguna.fromJson(e as Map<String, dynamic>))
//       .toList();
// }
//
// // ==========================================
// // MAIN APP & DEMO BAGIAN A
// // ==========================================
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 4',
//       theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
//       home: const PenggunaPage(), // Mengubah home ke PenggunaPage
//     );
//   }
// }
//
// Future<String> ambilSalam() async {
//   await Future.delayed(const Duration(seconds: 2));
//   return 'Halo dari masa depan!';
// }
//
// class SalamPage extends StatefulWidget {
//   const SalamPage({super.key});
//
//   @override
//   State<SalamPage> createState() => _SalamPageState();
// }
//
// class _SalamPageState extends State<SalamPage> {
//   late Future<String> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilSalam();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Demo Future')),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN D: HALAMAN PENGGUNA (FUTUREBUILDER)
// // ==========================================
// class PenggunaPage extends StatefulWidget {
//   const PenggunaPage({super.key});
//
//   @override
//   State<PenggunaPage> createState() => _PenggunaPageState();
// }
//
// class _PenggunaPageState extends State<PenggunaPage> {
//   late Future<List<Pengguna>> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilPengguna();
//   }
//
//   void _muatUlang() {
//     setState(() {
//       _future = ambilPengguna();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Pengguna'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _muatUlang,
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Pengguna>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Terjadi kesalahan:\n${snapshot.error}',
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _muatUlang,
//                       child: const Text('Coba lagi'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           final data = snapshot.data!;
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               final p = data[i];
//               return ListTile(
//                 leading: CircleAvatar(child: Text(p.name[0])),
//                 title: Text(p.name),
//                 subtitle: Text(p.email),
//                 trailing: const Icon(Icons.chevron_right),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



//LANGKAH BAGIAN PRAKTIKUM BAGIAN E
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// // ==========================================
// // BAGIAN C: MODEL DATA PENGGUNA
// // ==========================================
// class Pengguna {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String website;
//
//   const Pengguna({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.website,
//   });
//
//   factory Pengguna.fromJson(Map<String, dynamic> json) {
//     return Pengguna(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       website: json['website'] as String,
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN C: FUNGSI PENGAMBIL DATA REST API
// // ==========================================
// Future<List<Pengguna>> ambilPengguna() async {
//   final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
//   final response = await http.get(uri).timeout(const Duration(seconds: 10));
//   if (response.statusCode != 200) {
//     throw Exception('Gagal memuat data (kode ${response.statusCode})');
//   }
//   final List<dynamic> data = jsonDecode(response.body);
//   return data
//       .map((e) => Pengguna.fromJson(e as Map<String, dynamic>))
//       .toList();
// }
//
// // ==========================================
// // MAIN APP & DEMO BAGIAN A
// // ==========================================
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 4',
//       theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
//       home: const PenggunaPage(), // Mengubah home ke PenggunaPage
//     );
//   }
// }
//
// Future<String> ambilSalam() async {
//   await Future.delayed(const Duration(seconds: 2));
//   return 'Halo dari masa depan!';
// }
//
// class SalamPage extends StatefulWidget {
//   const SalamPage({super.key});
//
//   @override
//   State<SalamPage> createState() => _SalamPageState();
// }
//
// class _SalamPageState extends State<SalamPage> {
//   late Future<String> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilSalam();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Demo Future')),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN D: HALAMAN PENGGUNA (FUTUREBUILDER)
// // ==========================================
// class PenggunaPage extends StatefulWidget {
//   const PenggunaPage({super.key});
//
//   @override
//   State<PenggunaPage> createState() => _PenggunaPageState();
// }
//
// class _PenggunaPageState extends State<PenggunaPage> {
//   late Future<List<Pengguna>> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilPengguna();
//   }
//
//   void _muatUlang() {
//     setState(() {
//       _future = ambilPengguna();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Pengguna'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _muatUlang,
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Pengguna>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Terjadi kesalahan:\n${snapshot.error}',
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _muatUlang,
//                       child: const Text('Coba lagi'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           final data = snapshot.data!;
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               final p = data[i];
//               return ListTile(
//                 leading: CircleAvatar(child: Text(p.name[0])),
//                 title: Text(p.name),
//                 subtitle: Text(p.email),
//                 trailing: const Icon(Icons.chevron_right),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




//LANGKAH PRAKTIKUM BAGIAN F
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// // ==========================================
// // BAGIAN C: MODEL DATA PENGGUNA
// // ==========================================
// class Pengguna {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String website;
//
//   const Pengguna({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.website,
//   });
//
//   factory Pengguna.fromJson(Map<String, dynamic> json) {
//     return Pengguna(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       email: json['email'] as String,
//       phone: json['phone'] as String,
//       website: json['website'] as String,
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN C: FUNGSI PENGAMBIL DATA REST API
// // ==========================================
// Future<List<Pengguna>> ambilPengguna() async {
//   final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
//   final response = await http.get(uri).timeout(const Duration(seconds: 10));
//   if (response.statusCode != 200) {
//     throw Exception('Gagal memuat data (kode ${response.statusCode})');
//   }
//   final List<dynamic> data = jsonDecode(response.body);
//   return data
//       .map((e) => Pengguna.fromJson(e as Map<String, dynamic>))
//       .toList();
// }
//
// // ==========================================
// // MAIN APP & DEMO BAGIAN A
// // ==========================================
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Praktikum 4',
//       theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
//       home: const PenggunaPage(), // Mengubah home ke PenggunaPage
//     );
//   }
// }
//
// Future<String> ambilSalam() async {
//   await Future.delayed(const Duration(seconds: 2));
//   return 'Halo dari masa depan!';
// }
//
// class SalamPage extends StatefulWidget {
//   const SalamPage({super.key});
//
//   @override
//   State<SalamPage> createState() => _SalamPageState();
// }
//
// class _SalamPageState extends State<SalamPage> {
//   late Future<String> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilSalam();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Demo Future')),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: _future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // ==========================================
// // BAGIAN D: HALAMAN PENGGUNA (FUTUREBUILDER)
// // ==========================================
// class PenggunaPage extends StatefulWidget {
//   const PenggunaPage({super.key});
//
//   @override
//   State<PenggunaPage> createState() => _PenggunaPageState();
// }
//
// class _PenggunaPageState extends State<PenggunaPage> {
//   late Future<List<Pengguna>> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = ambilPengguna();
//   }
//
//   void _muatUlang() {
//     setState(() {
//       _future = ambilPengguna();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Pengguna'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _muatUlang,
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Pengguna>>(
//         future: _future,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Terjadi kesalahan:\n${snapshot.error}',
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       onPressed: _muatUlang,
//                       child: const Text('Coba lagi'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           final data = snapshot.data!;
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, i) {
//               final p = data[i];
//               return ListTile(
//                 leading: CircleAvatar(child: Text(p.name[0])),
//                 title: Text(p.name),
//                 subtitle: Text(p.email),
//                 trailing: const Icon(Icons.chevron_right),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




//LATIHAN MANDIRI
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ==========================================
// BAGIAN C & LATIHAN 1: MODEL DATA PENGGUNA
// ==========================================
class Pengguna {
  final int id;
  final String name;
  final String username; // Ditambahkan
  final String email;
  final String phone;
  final String website;
  final String city;

  const Pengguna({
    required this.id,
    required this.name,
    required this.username, // Ditambahkan
    required this.email,
    required this.phone,
    required this.website,
    required this.city,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String, // Ditambahkan
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      city: json['address']['city'] as String,
    );
  }
}

// ==========================================
// BAGIAN C: FUNGSI PENGAMBIL DATA REST API
// ==========================================
Future<List<Pengguna>> ambilPengguna() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
  final response = await http.get(uri).timeout(const Duration(seconds: 10));
  if (response.statusCode != 200) {
    throw Exception('Gagal memuat data (kode ${response.statusCode})');
  }
  final List<dynamic> data = jsonDecode(response.body);
  return data
      .map((e) => Pengguna.fromJson(e as Map<String, dynamic>))
      .toList();
}

// ==========================================
// MAIN APP & DEMO BAGIAN A
// ==========================================
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 4',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const PenggunaPage(),
    );
  }
}

Future<String> ambilSalam() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Halo dari masa depan!';
}

class SalamPage extends StatefulWidget {
  const SalamPage({super.key});

  @override
  State<SalamPage> createState() => _SalamPageState();
}

class _SalamPageState extends State<SalamPage> {
  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = ambilSalam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Future')),
      body: Center(
        child: FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Text(snapshot.data!, style: const TextStyle(fontSize: 24));
          },
        ),
      ),
    );
  }
}

// ==========================================
// BAGIAN D: HALAMAN PENGGUNA (FUTUREBUILDER)
// ==========================================
class PenggunaPage extends StatefulWidget {
  const PenggunaPage({super.key});

  @override
  State<PenggunaPage> createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  late Future<List<Pengguna>> _future;

  @override
  void initState() {
    super.initState();
    _future = ambilPengguna();
  }

  Future<void> _muatUlang() async {
    setState(() {
      _future = ambilPengguna();
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<Pengguna>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Daftar Pengguna (${snapshot.data!.length})');
            }
            return const Text('Daftar Pengguna');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: FutureBuilder<List<Pengguna>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 8),
                    Text(
                      'Terjadi kesalahan:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _muatUlang,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return RefreshIndicator(
              onRefresh: _muatUlang,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('Tidak ada data')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _muatUlang,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final p = data[i];
                return ListTile(
                  leading: CircleAvatar(child: Text(p.name[0])),
                  title: Text(p.name),
                  subtitle: Text('@${p.username} • ${p.city}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPenggunaPage(pengguna: p),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// BAGIAN E: HALAMAN DETAIL PENGGUNA (Dipindah ke luar)
// ==========================================
class DetailPenggunaPage extends StatelessWidget {
  final Pengguna pengguna;

  const DetailPenggunaPage({super.key, required this.pengguna});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pengguna.name)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(pengguna.username),
            subtitle: const Text('Username'),
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(pengguna.city),
            subtitle: const Text('Kota'),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(pengguna.email),
            subtitle: const Text('Email'),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(pengguna.phone),
            subtitle: const Text('Telepon'),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(pengguna.website),
            subtitle: const Text('Website'),
          ),
        ],
      ),
    );
  }
}