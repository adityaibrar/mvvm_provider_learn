class Ruangan {
  final int? id;
  final String namaRuangan;
  final String lokasiRuangan;

  Ruangan({
    this.id,
    required this.namaRuangan,
    required this.lokasiRuangan,
  });

  factory Ruangan.fromMap(Map<String, dynamic> json) => Ruangan(
        id: json['id'],
        namaRuangan: json['nama_ruangan'],
        lokasiRuangan: json['lokasi_ruangan'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_ruangan': namaRuangan,
        'lokasi_ruangan': lokasiRuangan,
      };
}
