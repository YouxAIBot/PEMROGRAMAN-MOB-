import 'package:flutter_test/flutter_test.dart';
import '../lib/models/kegiatan.dart';
import '../lib/utils/format.dart';


void main() {
  test('Kegiatan toMap/fromMap bolak-balik sama', () {
    const k = Kegiatan(
      id: 1,
      judul: 'Makan siang',
      tanggal: '2026-10-26',
      selesai: true,
      tipe: Tipe.pengeluaran,
      nominal: 15000,
      kategori: 'Makan',
    );
    final m = k.toMap();
    expect(m['selesai'], 1);
    expect(m['tipe'], 'pengeluaran');
    final k2 = Kegiatan.fromMap(m);
    expect(k2.selesai, true);
    expect(k2.tipe, Tipe.pengeluaran);
    expect(k2.nominal, 15000);
  });

  test('Contoh skenario satu hari (modul 3.2)', () {
    const r = Ringkasan(
      jumlahKegiatan: 4,
      selesai: 2,
      pemasukan: 50000,
      pengeluaran: 25000,
    );
    expect(r.tabungan, 25000);
  });

  test('Format rupiah dan tanggal', () {
    expect(rupiah(20000), 'Rp 20.000');
    expect(rupiah(-5000), '-Rp 5.000');
    expect(fmtTanggal(DateTime(2026, 1, 5)), '2026-01-05');
  });
}