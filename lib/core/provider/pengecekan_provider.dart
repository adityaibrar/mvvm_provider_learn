import 'package:flutter/material.dart';
import '../model/pengecekan_model.dart';
import '../repositories/pengecekan_repository.dart';

class PengecekanBarangProvider extends ChangeNotifier {
  final PengecekanBarangRepository _pengecekanRepository =
      PengecekanBarangRepository();
  List<PengecekanBarang> _pengecekanList = [];

  List<PengecekanBarang> get pengecekanList => _pengecekanList;

  PengecekanBarangProvider() {
    fetchPengecekan();
  }

  Future<void> fetchPengecekan() async {
    try {
      _pengecekanList = await _pengecekanRepository.getAllPengecekan();
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error fetching pengecekan: $e");
    }
  }

  Future<void> addPengecekan(PengecekanBarang pengecekan) async {
    try {
      await _pengecekanRepository.insertPengecekan(pengecekan);
      await fetchPengecekan(); // Refresh list after addition
    } catch (e) {
      // Handle error
      print("Error adding pengecekan: $e");
    }
  }

  Future<void> updatePengecekan(PengecekanBarang pengecekan) async {
    try {
      await _pengecekanRepository.updatePengecekan(pengecekan);
      await fetchPengecekan(); // Refresh list after update
    } catch (e) {
      // Handle error
      print("Error updating pengecekan: $e");
    }
  }

  Future<void> deletePengecekan(int id) async {
    try {
      await _pengecekanRepository.deletePengecekan(id);
      await fetchPengecekan(); // Refresh list after deletion
    } catch (e) {
      // Handle error
      print("Error deleting pengecekan: $e");
    }
  }
}
