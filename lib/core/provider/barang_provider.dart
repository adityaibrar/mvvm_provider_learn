import 'package:flutter/material.dart';

import '../model/barang_model.dart';
import '../repositories/barang_repository.dart';

class BarangProvider extends ChangeNotifier {
  final BarangRepository _barangRepository = BarangRepository();
  List<Barang> _barangList = [];
  List<Barang> _barangByRoomList =
      []; // Daftar untuk menyimpan barang berdasarkan room ID

  List<Barang> get barangList => _barangList;
  List<Barang> get barangByRoomList =>
      _barangByRoomList; // Getter untuk barangByRoomList

  BarangProvider() {
    fetchBarang();
  }

  Future<void> fetchBarang() async {
    _barangList = await _barangRepository.getAllBarang();
    notifyListeners();
  }

  Future<void> addBarang(Barang barang) async {
    await _barangRepository.insertBarang(barang);
    fetchBarang();
  }

  // Future<void> updateBarang(Barang barang) async {
  //   await _barangRepository.updateBarang(barang);
  //   fetchBarang();
  // }

  Future<void> deleteBarang(int id) async {
    await _barangRepository.deleteBarang(id);
    fetchBarang();
  }

  // Fungsi untuk melihat barang berdasarkan ID ruangan
  Future<void> fetchBarangByRoomId(int roomId) async {
    _barangByRoomList = await _barangRepository.getBarangByRoomId(roomId);
    notifyListeners();
  }
}
