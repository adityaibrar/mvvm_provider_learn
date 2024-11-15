import 'package:cek_barang/screen/class.dart';
import 'package:cek_barang/screen/formulir.dart';
import 'package:cek_barang/screen/kelasdanbarang.dart';
import 'package:cek_barang/screen/riwayat.dart';
import 'package:cek_barang/screen/tambahbarang.dart';
import 'package:cek_barang/screen/tambahruang.dart';

dynamic routes = {
  //baru ditambahin dsni class" nya
  KelasDanBarang.routeName: (context) => const KelasDanBarang(),
  TambahRuangScreen.routeName: (context) => const TambahRuangScreen(),
  TambahBarangScreen.routeName: (context) => const TambahBarangScreen(),
  ClassScreen.routeName: (context) => const ClassScreen(),
  FormScreen.routeName: (context) => const FormScreen(),
  RiwayatScreen.routeName: (context) => const RiwayatScreen(),
};
//cara nya gini 