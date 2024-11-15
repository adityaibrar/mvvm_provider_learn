import '../database/database_helper.dart';
import '../model/ruangan_model.dart';

class RuanganRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertRuangan(Ruangan ruangan) async {
    final db = await _databaseHelper.database;
    return await db.insert(DatabaseHelper.tableRoom, ruangan.toMap());
  }

  Future<List<Ruangan>> getAllRuangan() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(DatabaseHelper.tableRoom);
    return List.generate(maps.length, (i) {
      return Ruangan.fromMap(maps[i]);
    });
  }

  Future<int> updateRuangan(Ruangan ruangan) async {
    final db = await _databaseHelper.database;
    return await db.update(
      DatabaseHelper.tableRoom,
      ruangan.toMap(),
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [ruangan.id],
    );
  }

  Future<int> deleteRuangan(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      DatabaseHelper.tableRoom,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
    );
  }
}
