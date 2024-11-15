import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/model/ruangan_model.dart';
import '../core/provider/ruangan_provider.dart';

class TambahRuangScreen extends StatefulWidget {
  static const String routeName = '/tambah-ruang-screen';
  const TambahRuangScreen({super.key});

  @override
  State<TambahRuangScreen> createState() => _TambahRuangScreenState();
}

class _TambahRuangScreenState extends State<TambahRuangScreen> {
  // Controller untuk form field
  //kalo udh ganti" di dynamic routes itu di restart
  final TextEditingController _ruangController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Penambahan Ruangan'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _ruangController,
                decoration: InputDecoration(
                  labelText: 'Tambah Ruang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi Ruangan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              const SizedBox(height: 25.0),
              // Tombol "Disimpan"
              Center(
                child: ElevatedButton(
                  onPressed: _simpanData, // Fungsi saat tombol ditekan
                  child: const Text('Disimpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan data
  void _simpanData() {
    final String ruang = _ruangController.text;
    final String lokasi = _lokasiController.text;

    if (ruang.isNotEmpty && lokasi.isNotEmpty) {
      final ruangan = Ruangan(
        id: null, // Atur ID jika Anda menggunakan auto-increment
        namaRuangan: ruang,
        lokasiRuangan: lokasi,
      );

      Provider.of<RuanganProvider>(context, listen: false).addRuangan(ruangan);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data ruang $ruang berhasil disimpan!'),
        ),
      );

      _ruangController.clear();
      _lokasiController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua data dengan benar!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _ruangController.dispose();
    _lokasiController.dispose();
    super.dispose();
  }
}
