import 'package:cek_barang/screen/tambahbarang.dart';
import 'package:cek_barang/screen/tambahruang.dart';
import 'package:flutter/material.dart';

class KelasDanBarang extends StatefulWidget {
  static const String routeName = '/kelas-dan-barang';
  const KelasDanBarang({super.key});

  @override
  State<KelasDanBarang> createState() => _KelasDanBarangState();
}

class _KelasDanBarangState extends State<KelasDanBarang> {
  //ini? iyaa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            //nah ini langsung column kan yaa kamu ke column dlu ctrl+ . pas coba
            children: [
              GestureDetector(
                onTap: () {
                  //ini judulnya ruang dan barang pindah ke kelas dan barang
                  Navigator.pushNamed(context, TambahBarangScreen.routeName);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Text(
                      'Barang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Aksi ketika kotak "Ruang" ditekan
                  Navigator.pushNamed(context,
                      TambahRuangScreen.routeName); // Route untuk Tambah Ruang
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Text(
                      'Ruang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
