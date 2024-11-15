import 'package:cek_barang/core/provider/ruangan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/model/pengecekan_model.dart';
import '../core/provider/pengecekan_provider.dart';

class RiwayatScreen extends StatefulWidget {
  static const String routeName = '/riwayat-screen';
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PengecekanBarangProvider>().fetchPengecekan();
    context.read<RuanganProvider>().fetchRuangan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pengecekan Barang'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportToPDF,
          ),
        ],
      ),
      body: Consumer2<PengecekanBarangProvider, RuanganProvider>(
        builder: (context, pengecekanBarangProvider, ruanganProvider, child) {
          final pengecekanList = pengecekanBarangProvider.pengecekanList;
          final groupedData = _groupByRoomAndDate(pengecekanList);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: groupedData.entries.map((roomEntry) {
                final roomId = roomEntry.key;
                final roomName =
                    ruanganProvider.getRuanganById(int.parse(roomId));
                final dateData = roomEntry.value;

                return ExpansionTile(
                  title: Text('Ruang: $roomName'),
                  children: dateData.entries.map((dateEntry) {
                    final date = dateEntry.key;
                    final pengecekanList = dateEntry.value;

                    // Tampilkan keterangan sekali di level grup waktu
                    final firstPengecekan = pengecekanList.first;

                    return ListTile(
                      title: Text('Tanggal: $date'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama user: ${firstPengecekan.namaUser}'),
                          Text('Keterangan: ${firstPengecekan.keterangan}'),
                          const SizedBox(height: 8),
                          ...pengecekanList.map((cek) {
                            final createdAt = DateTime.parse(cek.createdAt);

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama Barang: ${cek.namaBarang}'),
                                  Row(
                                    children: [
                                      const Text('Status: '),
                                      Icon(
                                        cek.status == 'true'
                                            ? Icons.check_circle
                                            : Icons
                                                .cancel, // Ikon ceklist hijau atau silang merah
                                        color: cek.status == 'true'
                                            ? Colors.green
                                            : Colors
                                                .red, // Warna ikon berdasarkan status
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Waktu: ${DateFormat('HH:mm').format(createdAt)}',
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Map<String, Map<String, List<PengecekanBarang>>> _groupByRoomAndDate(
      List<PengecekanBarang> list) {
    final groupedData = <String, Map<String, List<PengecekanBarang>>>{};

    final dateFormat = DateFormat('yyyy-MM-dd'); // Format tanggal

    for (var pengecekan in list) {
      final date = dateFormat.format(DateTime.parse(pengecekan.createdAt.split(
          ' ')[0])); // Assuming createdAt is in "yyyy-MM-dd HH:mm:ss" format
      final room = pengecekan.ruanganId.toString();

      if (!groupedData.containsKey(room)) {
        groupedData[room] = {};
      }

      if (!groupedData[room]!.containsKey(date)) {
        groupedData[room]![date] = [];
      }

      groupedData[room]![date]!.add(pengecekan);
    }

    return groupedData;
  }

  void exportToPDF() {
    // Tambahkan kode untuk ekspor ke PDF di sini
  }
}
