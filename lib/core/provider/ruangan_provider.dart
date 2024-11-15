import 'package:flutter/material.dart';

import '../model/ruangan_model.dart';
import '../repositories/ruangan_repository.dart';

class RuanganProvider with ChangeNotifier {
  final RuanganRepository _ruanganRepository = RuanganRepository();

  List<Ruangan> _ruanganList = [];
  List<Ruangan> get ruanganList => _ruanganList;
  

  Future<void> fetchRuangan() async {
    _ruanganList = await _ruanganRepository.getAllRuangan();
    notifyListeners();
  }
   String getRuanganById(int ruanganId) {
    try {
      final ruangan = _ruanganList.firstWhere((r) => r.id == ruanganId);
      return ruangan.namaRuangan;  // Return the room name
    } catch (e) {
      return 'Ruangan Tidak Ditemukan'; // Return a default message if not found
    }
  }

  Future<void> addRuangan(Ruangan ruangan) async {
    await _ruanganRepository.insertRuangan(ruangan);
    fetchRuangan(); // Refresh the list
  }

  Future<void> updateRuangan(Ruangan ruangan) async {
    await _ruanganRepository.updateRuangan(ruangan);
    fetchRuangan(); // Refresh the list
  }

  Future<void> deleteRuangan(int id) async {
    await _ruanganRepository.deleteRuangan(id);
    fetchRuangan(); // Refresh the list
  }
}
