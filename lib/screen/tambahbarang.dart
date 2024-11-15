import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/model/barang_model.dart';
import '../core/provider/barang_provider.dart';
import '../core/provider/ruangan_provider.dart';

class TambahBarangScreen extends StatefulWidget {
  static const String routeName = '/tambah-barang-screen';
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() => _TambahBarangScreenState();
}

class _TambahBarangScreenState extends State<TambahBarangScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();
  String? _selectedRoom;

  @override
  void initState() {
    super.initState();
    // Fetch ruangan data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RuanganProvider>(context, listen: false).fetchRuangan();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ruanganProvider = Provider.of<RuanganProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Penambahan Barang'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dropdown untuk memilih ruangan
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                value: _selectedRoom,
                hint: const Text('Pilih Ruangan'),
                items: ruanganProvider.ruanganList.map((ruangan) {
                  return DropdownMenuItem<String>(
                    value: ruangan.id.toString(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nama :${ruangan.namaRuangan} '),
                        Text(ruangan.lokasiRuangan),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRoom = value;
                  });
                },
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                controller: _kodeController,
                decoration: InputDecoration(
                  labelText: 'Kode Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              // Tombol "Disimpan"
              Center(
                child: ElevatedButton(
                  onPressed: _simpanData,
                  child: const Text('Disimpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _simpanData() {
    final String namaBarang = _namaController.text;
    final String kodeBarang = _kodeController.text;

    if (_selectedRoom != null && namaBarang.isNotEmpty) {
      final barang = Barang(
        namaBarang: namaBarang,
        kodeBarang: kodeBarang,
        ruanganId: int.parse(_selectedRoom!),
      );

      Provider.of<BarangProvider>(context, listen: false).addBarang(barang);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data barang $namaBarang berhasil disimpan!'),
        ),
      );

      _namaController.clear();
      setState(() {
        _selectedRoom = null; // Reset dropdown
      });
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
    _namaController.dispose();
    super.dispose();
  }
}
