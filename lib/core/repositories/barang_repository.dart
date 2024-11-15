import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../model/barang_model.dart';

class BarangRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertBarang(Barang barang) async {
    Database db = await _databaseHelper.database;
    return await db.insert(DatabaseHelper.tableItem, barang.toMap());
  }

  Future<List<Barang>> getAllBarang() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result =
        await db.query(DatabaseHelper.tableItem);
    return result.map((map) => Barang.fromMap(map)).toList();
  }

  Future<Barang?> getBarangById(int id) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.tableItem,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Barang.fromMap(result.first);
    }
    return null;
  }

  // Future<int> updateBarang(Barang barang) async {
  //   Database db = await _databaseHelper.database;
  //   return await db.update(
  //     DatabaseHelper.tableItem,
  //     barang.toMap(),
  //     where: '${DatabaseHelper.columnId} = ?',
  //     whereArgs: [barang.id],
  //   );
  // }

  Future<int> deleteBarang(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete(
      DatabaseHelper.tableItem,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Barang>> getBarangByRoomId(int roomId) async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      DatabaseHelper.tableItem,
      where: '${DatabaseHelper.columnRoomId} = ?',
      whereArgs: [roomId],
    );
    print(result.map((map) => Barang.fromMap(map)).toList());
    return result.map((map) => Barang.fromMap(map)).toList();
  }
}
