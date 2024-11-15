import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/pengecekan_model.dart';

class PengecekanBarangRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertPengecekan(PengecekanBarang pengecekan) async {
    Database db = await _databaseHelper.database;
    return await db.insert(DatabaseHelper.checkItem, pengecekan.toMap());
  }

  Future<List<PengecekanBarang>> getAllPengecekan() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(DatabaseHelper.checkItem);
    return result.map((map) => PengecekanBarang.fromMap(map)).toList();
  }

  Future<PengecekanBarang?> getPengecekanById(int id) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.checkItem,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return PengecekanBarang.fromMap(result.first);
    }
    return null;
  }

  Future<int> updatePengecekan(PengecekanBarang pengecekan) async {
    Database db = await _databaseHelper.database;
    return await db.update(
      DatabaseHelper.checkItem,
      pengecekan.toMap(),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [pengecekan.id],
    );
  }

  Future<int> deletePengecekan(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete(
      DatabaseHelper.checkItem,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }
}
