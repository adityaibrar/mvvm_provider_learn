import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Nama database
  static const _databaseName = 'cekBarang.db';
  static const _databaseVersion = 1;

  // Nama tabel
  static const tableRoom = 'ruangan';
  static const tableItem = 'barang';
  static const checkItem = 'pengecekan_barang';

  // Nama kolom yang akan digunakan
  static const columnId = 'id';
  static const columnRoomName = 'nama_ruangan';
  static const columnRoomLocation =
      'lokasi_ruangan'; // Mengubah nama kolom sesuai skema
  static const columnItemName = 'nama_barang';
  static const columnItemCode = 'kode';
  static const columnUserName = 'nama_user';
  static const columnRoomId = 'ruangan_id'; // ID ruangan
  static const columnCreatedAt = 'created_at';
  static const columnRoomCondition = 'kondisi';
  static const columnDateCheck = 'tanggal_cek';
  static const columnStatus = 'status';
  static const columnKeterangan = 'keterangan';

  // Singleton dan inisialisasi database
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Membuat tabel ruangan
    await db.execute('''
      CREATE TABLE $tableRoom (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnRoomName TEXT NOT NULL,
        $columnRoomLocation TEXT NOT NULL
      )
    ''');

    // Membuat tabel barang yang memiliki referensi ke ruangan (menggunakan ID ruangan)
    await db.execute('''
      CREATE TABLE $tableItem (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnItemName TEXT NOT NULL,
        $columnItemCode TEXT NOT NULL,
        $columnRoomId INTEGER NOT NULL,
        FOREIGN KEY ($columnRoomId) REFERENCES $tableRoom($columnId) ON DELETE CASCADE
      )
    ''');

    // Membuat tabel pengecekan_barang yang berisi catatan pengecekan barang
    await db.execute('''
      CREATE TABLE $checkItem (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnItemName TEXT NOT NULL,
        $columnRoomId INTEGER NOT NULL,
        $columnUserName TEXT NOT NULL,
        $columnCreatedAt TEXT NOT NULL,
        $columnDateCheck TEXT NOT NULL,
        $columnStatus TEXT NOT NULL,
        $columnKeterangan TEXT NOT NULL,
        $columnRoomCondition TEXT NOT NULL,
        FOREIGN KEY ($columnRoomId) REFERENCES $tableRoom($columnId),
        FOREIGN KEY ($columnItemName) REFERENCES $tableItem($columnItemName)
      )
    ''');
  }
}
