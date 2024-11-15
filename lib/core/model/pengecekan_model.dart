class PengecekanBarang {
  final int? id;
  final String namaBarang;
  final int ruanganId; // Menggunakan ID ruangan
  final String namaUser;
  final String createdAt;
  final String tanggalCek;
  final String status;
  final String keterangan;
  final String kondisiRuangan;

  PengecekanBarang({
    this.id,
    required this.namaBarang,
    required this.ruanganId,
    required this.namaUser,
    required this.createdAt,
    required this.tanggalCek,
    required this.status,
    required this.keterangan,
    required this.kondisiRuangan,
  });

  factory PengecekanBarang.fromMap(Map<String, dynamic> json) =>
      PengecekanBarang(
        id: json['id'],
        namaBarang: json['nama_barang'],
        ruanganId: json['ruangan_id'],
        namaUser: json['nama_user'],
        createdAt: json['created_at'],
        tanggalCek: json['tanggal_cek'],
        status: json['status'],
        keterangan: json['keterangan'],
        kondisiRuangan: json['kondisi'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_barang': namaBarang,
        'ruangan_id': ruanganId,
        'nama_user': namaUser,
        'created_at': createdAt,
        'tanggal_cek': tanggalCek,
        'status': status,
        'keterangan': keterangan,
        'kondisi': kondisiRuangan,
      };
}
