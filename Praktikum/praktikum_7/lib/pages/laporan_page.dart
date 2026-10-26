import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../state/pengaturan.dart';
import '../utils/format.dart';
import '../widgets/ringkasan_card.dart';

class DataLaporan {
  final Ringkasan hari;
  final Map<String, int> perKategori;
  final List<MapEntry<DateTime, Ringkasan>> tujuhHari;
  const DataLaporan(this.hari, this.perKategori, this.tujuhHari);
}

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  DateTime _tanggal = DateTime.now();
  late Future<DataLaporan> _future;

  @override
  void initState() {
    super.initState();
    _future = _ambil();
    versiData.addListener(_muat);
  }

  @override
  void dispose() {
    versiData.removeListener(_muat);
    super.dispose();
  }

  Future<DataLaporan> _ambil() async {
    final basis = _tanggal;
    final tgl = fmtTanggal(basis);
    final hari = await DbHelper.ringkasan(tgl);
    final perKategori = await DbHelper.pengeluaranPerKategori(tgl);

    final tujuh = <MapEntry<DateTime, Ringkasan>>[];
    for (var i = 0; i < 7; i++) {
      final d = DateTime(basis.year, basis.month, basis.day - i);
      tujuh.add(MapEntry(d, await DbHelper.ringkasan(fmtTanggal(d))));
    }
    return DataLaporan(hari, perKategori, tujuh);
  }

  void _ganti(DateTime baru) {
    setState(() {
      _tanggal = baru;
      _future = _ambil();
    });
  }

  void _muat() => _ganti(_tanggal);

  void _geser(int hari) {
    _ganti(DateTime(_tanggal.year, _tanggal.month, _tanggal.day + hari));
  }

  Future<void> _pilihTanggal() async {
    final dipilih = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (dipilih != null && mounted) _ganti(dipilih);
  }

  Future<void> _salin(DataLaporan d) async {
    final r = d.hari;
    final target = targetHarian.value;
    final b = StringBuffer()
      ..writeln('Laporan TabungKu - ${tampilTanggal(_tanggal)}')
      ..writeln('Kegiatan selesai : ${r.selesai}/${r.jumlahKegiatan}')
      ..writeln('Pemasukan        : ${rupiah(r.pemasukan)}')
      ..writeln('Pengeluaran      : ${rupiah(r.pengeluaran)}');
    for (final e in d.perKategori.entries) {
      b.writeln('  - ${e.key}: ${rupiah(e.value)}');
    }
    b
      ..writeln('Tabungan         : ${rupiah(r.tabungan)}')
      ..writeln('Realisasi        : ${rupiah(r.tabunganRealisasi)}')
      ..writeln('Target           : ${rupiah(target)} '
          '(${r.tabungan >= target ? 'tercapai' : 'belum tercapai'})');

    await Clipboard.setData(ClipboardData(text: b.toString()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan disalin ke clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return FutureBuilder<DataLaporan>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Galat: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final d = snapshot.data!;
        final total7 = d.tujuhHari.fold<int>(0, (s, e) => s + e.value.tabungan);

        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => _geser(-1),
                ),
                TextButton.icon(
                  onPressed: _pilihTanggal,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(tampilTanggal(_tanggal)),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _geser(1),
                ),
              ],
            ),
            ValueListenableBuilder<int>(
              valueListenable: targetHarian,
              builder: (context, target, _) {
                return RingkasanCard(
                  judul: 'Ringkasan harian',
                  ringkasan: d.hari,
                  target: target,
                );
              },
            ),
            _RencanaRealisasi(r: d.hari),
            const SizedBox(height: 16),
            Text('Pengeluaran per kategori', style: tema.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (d.perKategori.isEmpty)
              const Text('Tidak ada pengeluaran pada tanggal ini.')
            else
              for (final e in d.perKategori.entries)
                _BarisKategori(
                  nama: e.key,
                  total: e.value,
                  semua: d.hari.pengeluaran,
                ),
            const SizedBox(height: 16),
            Text('7 hari terakhir', style: tema.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Total tabungan 7 hari: ${rupiah(total7)}',
              style: tema.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: total7 >= 0 ? Colors.green : Colors.red,
              ),
            ),
            for (final e in d.tujuhHari)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(tampilTanggal(e.key)),
                subtitle: Text(
                  '${e.value.jumlahKegiatan} kegiatan | '
                  'masuk ${rupiah(e.value.pemasukan)} | '
                  'keluar ${rupiah(e.value.pengeluaran)}',
                ),
                trailing: Text(
                  rupiah(e.value.tabungan),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: e.value.tabungan >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _salin(d),
              icon: const Icon(Icons.copy_all),
              label: const Text('Salin laporan ke clipboard'),
            ),
          ],
        );
      },
    );
  }
}

class _RencanaRealisasi extends StatelessWidget {
  final Ringkasan r;
  const _RencanaRealisasi({required this.r});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final selisih = r.tabunganRealisasi - r.tabungan;

    Widget baris(String label, int rencana, int realisasi, {bool tebal = false}) {
      final gaya = tebal ? const TextStyle(fontWeight: FontWeight.bold) : null;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(label, style: gaya)),
            Expanded(
              flex: 3,
              child: Text(rupiah(rencana), textAlign: TextAlign.end, style: gaya),
            ),
            Expanded(
              flex: 3,
              child: Text(rupiah(realisasi), textAlign: TextAlign.end, style: gaya),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rencana vs Realisasi', style: tema.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Realisasi hanya menghitung kegiatan yang sudah selesai.',
              style: tema.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Expanded(flex: 3, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: Text('Rencana', textAlign: TextAlign.end),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Realisasi', textAlign: TextAlign.end),
                ),
              ],
            ),
            baris('Pemasukan', r.pemasukan, r.pemasukanSelesai),
            baris('Pengeluaran', r.pengeluaran, r.pengeluaranSelesai),
            const Divider(),
            baris('Tabungan', r.tabungan, r.tabunganRealisasi, tebal: true),
            const SizedBox(height: 6),
            Text(
              'Selisih realisasi terhadap rencana: ${rupiah(selisih)}',
              style: TextStyle(color: selisih < 0 ? Colors.red : Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarisKategori extends StatelessWidget {
  final String nama;
  final int total;
  final int semua;

  const _BarisKategori({
    required this.nama,
    required this.total,
    required this.semua,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(nama), Text(rupiah(total))],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: semua == 0 ? 0.0 : total / semua,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
