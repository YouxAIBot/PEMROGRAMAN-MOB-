import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late ValueNotifier<ThemeMode> themeMode;
late ValueNotifier<Color> seedColor;

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? false;
  final colorVal = prefs.getInt('colorVal') ?? Colors.indigo.toARGB32();

  themeMode = ValueNotifier<ThemeMode>(isDark ? ThemeMode.dark : ThemeMode.light);
  seedColor = ValueNotifier<Color>(Color(colorVal));

  runApp(const MyApp());
}

class TempatWisata {
  final String nama;
  final String lokasi;
  final String deskripsi;
  final IconData ikon;
  final Color warna;

  const TempatWisata({
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.ikon,
    required this.warna,
  });
}

const daftarWisata = [
  TempatWisata(
    nama: 'Raja Ampat',
    lokasi: 'Papua Barat',
    deskripsi: 'Surga bahari dengan keindahan bawah laut dan gugusan pulau karang yang menakjubkan.',
    ikon: Icons.waves,
    warna: Colors.blue,
  ),
  TempatWisata(
    nama: 'Gunung Bromo',
    lokasi: 'Jawa Timur',
    deskripsi: 'Gunung berapi aktif yang terkenal dengan pemandangan matahari terbit dan lautan pasir.',
    ikon: Icons.landscape,
    warna: Colors.orange,
  ),
  TempatWisata(
    nama: 'Candi Borobudur',
    lokasi: 'Jawa Tengah',
    deskripsi: 'Candi Buddha terbesar di dunia yang merupakan warisan budaya dunia UNESCO.',
    ikon: Icons.account_balance,
    warna: Colors.brown,
  ),
  TempatWisata(
    nama: 'Pulau Komodo',
    lokasi: 'Nusa Tenggara Timur',
    deskripsi: 'Habitat asli kadal raksasa purba Komodo di tengah savana dan pantai berpasir pink.',
    ikon: Icons.pets,
    warna: Colors.green,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeMode, seedColor]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Katalog Wisata Nusantara',
          debugShowCheckedModeBanner: false,
          theme: buatTema(seedColor.value, Brightness.light),
          darkTheme: buatTema(seedColor.value, Brightness.dark),
          themeMode: themeMode.value,
          initialRoute: '/',
          routes: {
            '/': (context) => const ShellPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final wisata = settings.arguments as TempatWisata;
              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) => DetailWisataPage(wisata: wisata),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }
            return null;
          },
        );
      },
    );
  }
}

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => ShellPageState();
}

class ShellPageState extends State<ShellPage> {
  int _index = 0;
  static const _halaman = [BerandaTab(), KatalogTab(), PengaturanTab()];
  static const _judul = ['Beranda', 'Katalog Wisata', 'Pengaturan'];

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(_judul[_index])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: tema.colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.explore, size: 48, color: tema.colorScheme.onPrimary),
                  const SizedBox(height: 8),
                  Text(
                    'Menu Wisata',
                    style: TextStyle(
                      color: tema.colorScheme.onPrimary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _index = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Katalog Wisata'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _index = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _index = 2);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _index, children: _halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Katalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

class BerandaTab extends StatefulWidget {
  const BerandaTab({super.key});

  @override
  State<BerandaTab> createState() => _BerandaTabState();
}

class _BerandaTabState extends State<BerandaTab> with SingleTickerProviderStateMixin {
  bool _besar = false;
  bool _terlihat = true;
  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();
    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Selamat Datang di Pesona Nusantara',
                  style: tema.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Temukan keindahan destinasi wisata terbaik di Indonesia dengan galeri interaktif.',
                  style: tema.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text('Animasi Implisit & Eksplorasi', style: tema.textTheme.titleMedium),
        const SizedBox(height: 12),
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            width: _besar ? 220 : 120,
            height: 120,
            decoration: BoxDecoration(
              color: _besar ? warna.primary : warna.secondary,
              borderRadius: BorderRadius.circular(_besar ? 60 : 16),
            ),
            child: Center(
              child: Icon(
                Icons.star,
                size: 48,
                color: warna.onPrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _besar = !_besar),
            child: const Text('Ubah Bentuk Kontainer'),
          ),
        ),
        const Divider(height: 32),
        Text('Animasi Eksploratif (Eksplisit)', style: tema.textTheme.titleMedium),
        const SizedBox(height: 12),
        Center(
          child: RotationTransition(
            turns: _putar,
            child: Icon(Icons.explore, size: 64, color: warna.primary),
          ),
        ),
        const SizedBox(height: 16),
        Text('Animasi Transparansi (Implisit)', style: tema.textTheme.titleMedium),
        const SizedBox(height: 12),
        AnimatedOpacity(
          opacity: _terlihat ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Card(
            color: warna.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Informasi Khusus Wisatawan: Nikmati liburan Anda dengan menjaga kebersihan lingkungan.',
                style: tema.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => setState(() => _terlihat = !_terlihat),
            child: const Text('Sembunyikan/Tampilkan Info'),
          ),
        ),
      ],
    );
  }
}

class KatalogTab extends StatelessWidget {
  const KatalogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daftarWisata.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, i) {
        final wisata = daftarWisata[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Hero(
              tag: 'wisata-${wisata.nama}',
              child: CircleAvatar(
                radius: 32,
                backgroundColor: wisata.warna,
                child: Icon(wisata.ikon, size: 32, color: Colors.white),
              ),
            ),
            title: Text(
              wisata.nama,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(wisata.lokasi),
                const SizedBox(height: 4),
                Text(
                  wisata.deskripsi,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: wisata);
            },
          ),
        );
      },
    );
  }
}

class DetailWisataPage extends StatelessWidget {
  final TempatWisata wisata;

  const DetailWisataPage({super.key, required this.wisata});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(wisata.nama)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'wisata-${wisata.nama}',
              child: CircleAvatar(
                radius: 80,
                backgroundColor: wisata.warna,
                child: Icon(wisata.ikon, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              wisata.nama,
              style: tema.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Lokasi: ${wisata.lokasi}',
              style: tema.textTheme.titleMedium?.copyWith(
                color: tema.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Deskripsi Destinasi',
              style: tema.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              wisata.deskripsi,
              style: tema.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Mode Gelap'),
          subtitle: const Text('Sesuaikan tampilan tema aplikasi'),
          value: themeMode.value == ThemeMode.dark,
          onChanged: (v) async {
            themeMode.value = v ? ThemeMode.dark : ThemeMode.light;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isDark', v);
          },
        ),
        const Divider(height: 32),
        Text(
          'Pilihan Warna Tema',
          style: tema.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          children: [
            for (final c in pilihanWarna)
              GestureDetector(
                onTap: () async {
                  seedColor.value = c;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('colorVal', c.toARGB32());
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: c,
                  child: seedColor.value == c
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}