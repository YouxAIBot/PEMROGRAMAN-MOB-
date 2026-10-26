String fmtTanggal(DateTime d) {
  final bulan = d.month.toString().padLeft(2, '0');
  final hari = d.day.toString().padLeft(2, '0');
  return '${d.year}-$bulan-$hari';
}

const _namaHari = [
  'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
];

const _namaBulan = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

String tampilTanggal(DateTime d) {
  return '${_namaHari[d.weekday - 1]}, ${d.day} '
      '${_namaBulan[d.month - 1]} ${d.year}';
}

String rupiah(int nilai) {
  final teks = nilai.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < teks.length; i++) {
    if (i > 0 && (teks.length - i) % 3 == 0) buf.write('.');
    buf.write(teks[i]);
  }
  final tanda = nilai < 0 ? '-' : '';
  return '${tanda}Rp $buf';
}
