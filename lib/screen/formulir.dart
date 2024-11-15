import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/model/pengecekan_model.dart';
import '../core/model/ruangan_model.dart';
import '../core/provider/barang_provider.dart';
import '../core/provider/pengecekan_provider.dart';
import '../core/provider/ruangan_provider.dart';

class FormScreen extends StatefulWidget {
  static const String routeName = '/Form-Screen';
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FormScreen> {
  int? roomId;
  String? _selectedRuang;
  String? _selectedKondisi;
  final List<String> _kondisiRuangan = ['Baik', 'Tidak'];
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as int?;
    if (args != null) {
      roomId = args;
      // Fetch data from provider
      context.read<BarangProvider>().fetchBarangByRoomId(roomId!);
      context.read<RuanganProvider>().fetchRuangan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Pengecekan Barang ${roomId ?? ''}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer3<BarangProvider, PengecekanBarangProvider,
            RuanganProvider>(
          builder: (context, barangProvider, pengecekanProvider,
              ruanganProvider, child) {
            // Pastikan data ruangan sudah tersedia
            if (ruanganProvider.ruanganList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Set _selectedRuang berdasarkan roomId jika belum diatur
            if (_selectedRuang == null && roomId != null) {
              final selectedRuangan = ruanganProvider.ruanganList.firstWhere(
                (ruangan) => ruangan.id == roomId,
                // orElse: () => null,
              );
              _selectedRuang = selectedRuangan.namaRuangan;
            }

            // Menghindari duplikat nilai pada DropdownButtonFormField
            final ruanganList = ruanganProvider.ruanganList;
            final uniqueRuanganList = <Ruangan>{};
            for (var ruangan in ruanganList) {
              uniqueRuanganList.add(ruangan);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Ruang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    value: _selectedRuang,
                    items: uniqueRuanganList.map((Ruangan ruangan) {
                      return DropdownMenuItem<String>(
                        value: ruangan.namaRuangan,
                        child: Text(ruangan.namaRuangan),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRuang = newValue;
                        final selectedRuangan =
                            ruanganProvider.ruanganList.firstWhere(
                          (ruangan) => ruangan.namaRuangan == newValue,
                          // orElse: () => null,
                        );
                        roomId = selectedRuangan.id;
                      });
                    },
                  ),
                  const SizedBox(height: 25.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Kondisi Ruangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    value: _selectedKondisi,
                    items: _kondisiRuangan.map((String ruang) {
                      return DropdownMenuItem<String>(
                        value: ruang,
                        child: Text(ruang),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedKondisi = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'List Barang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: barangProvider.barangByRoomList.length,
                    itemBuilder: (context, index) {
                      final barang = barangProvider.barangByRoomList[index];

                      return CheckboxListTile(
                        title: Text('Nama : ${barang.namaBarang}'),
                        subtitle: Text('Kode : ${barang.kodeBarang}'),
                        value: barang.isAvailable,
                        onChanged: (bool? value) {
                          setState(() {
                            barang.isAvailable = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    controller: _keteranganController,
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () async {
            final barangList = context.read<BarangProvider>().barangByRoomList;
            final pengecekanProvider = context.read<PengecekanBarangProvider>();

            // Ambil nama user dari form
            final namaUser = _namaController.text;
            final keterangan = _keteranganController.text;

            if (namaUser.isNotEmpty && keterangan.isNotEmpty) {
              for (var barang in barangList) {
                final pengecekan = PengecekanBarang(
                  namaBarang: barang.namaBarang,
                  ruanganId: roomId!,
                  namaUser: namaUser,
                  createdAt: DateTime.now().toIso8601String(),
                  tanggalCek: DateTime.now().toIso8601String(),
                  status: barang.isAvailable!
                      ? 'true'
                      : 'false', // status: 1 untuk tersedia, 0 untuk tidak tersedia
                  keterangan: keterangan,
                  kondisiRuangan: _selectedKondisi!,
                );
                await pengecekanProvider.addPengecekan(pengecekan);
              }

              // Iterasi melalui list barang dan simpan ke database
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data berhasil disimpan')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data gagal disimpan')),
              );
            }

            // Mungkin Anda ingin melakukan navigasi atau notifikasi setelah penyimpanan

            // Reset form atau navigasi ke halaman lain
            // Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
