class Barang {
  final int? id;
  final String namaBarang;
  final String kodeBarang;
  final int ruanganId; // Menggunakan ID ruangan
  bool? isAvailable;

  Barang(
      {this.id,
      required this.namaBarang,
      required this.ruanganId,
      required this.kodeBarang,
      this.isAvailable = false,});

  factory Barang.fromMap(Map<String, dynamic> json) => Barang(
        id: json['id'],
        namaBarang: json['nama_barang'],
        ruanganId: json['ruangan_id'],
        kodeBarang: json['kode'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_barang': namaBarang,
        'kode': kodeBarang,
        'ruangan_id': ruanganId,
      };
}
