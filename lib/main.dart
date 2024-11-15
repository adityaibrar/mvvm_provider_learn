import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/routes.dart';
import 'core/provider/barang_provider.dart';
import 'core/provider/pengecekan_provider.dart';
import 'core/provider/ruangan_provider.dart';
import 'screen/dashboard.dart';

void main() {
  runApp(const MyApp());
}
//coba run

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RuanganProvider()),
        ChangeNotifierProvider(create: (_) => BarangProvider()),
        ChangeNotifierProvider(create: (_) => PengecekanBarangProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: routes,
        // dihome ini masukkan nama kelas buat tampilan yg awal seperti tadi dashboard
        home: const DashboardScreen(),
        //kalu mau ketampilan lain sekalian buat tombol kek tadi
        //nah kan merah yaa coba curson nya taruh di dashboardscreen nya hbstu ctrl + .
        //itu buar import file dashboard.dart yang dipake buat tampilannya
        // kalo mau buat database di hp itu donload packages dlu namanya sqflite sama download buat state management
        //buat mempermudah penyimpanan dari tampilan ke data base, donlot di kotak itu?
        //di pub dev
        //cara downloadnya ada 2 ada yg lewat pubspec.yaml sama ada 1 lebih simple kalo di pubspec gini cara simplenya gini coba ctrl + shift + p
        //otomatis ada di pubspec
        //coba download packages yg provider, judulnya provider? iya
        //gitu cara download packages di flutter
        //ini tulisannya mau dihapus ga? iyaai tapi  paham kamu kan ? aku aja yg hpusoa,lah ndak semua soalnya oalah
      ),
    );
  }
}
//hbstu di main.dart daftar kan nama variabel yang menampul kelas" tadi
