import 'package:cek_barang/screen/formulir.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/provider/ruangan_provider.dart';

class ClassScreen extends StatefulWidget {
  static const String routeName = '/class-screen';
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    final ruanganProvider = Provider.of<RuanganProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Ruangan'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: ruanganProvider.ruanganList.map((ruangan) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    FormScreen.routeName,
                    arguments: ruangan.id, // Pass ruang name as argument
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      ruangan.namaRuangan,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
