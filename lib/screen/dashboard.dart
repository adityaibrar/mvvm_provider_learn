import 'package:cek_barang/screen/class.dart';
import 'package:cek_barang/screen/kelasdanbarang.dart';
import 'package:cek_barang/screen/riwayat.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  //ini judulnya ruang dan barang pindah ke kelas dan barang
                  Navigator.pushNamed(context, KelasDanBarang.routeName);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Text(
                      'Ruangan dan Barang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //ini judulnya ruang dan barang pindah ke kelas dan barang
                  Navigator.pushNamed(context, ClassScreen.routeName);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Text(
                      'Kelas',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //ini judulnya ruang dan barang pindah ke kelas dan barang
                  Navigator.pushNamed(context, RiwayatScreen.routeName);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: const Center(
                    child: Text(
                      'Riwayat',
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
