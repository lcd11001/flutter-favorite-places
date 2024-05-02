import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

const String _kDatabaseName = 'places.db';
const String _kTable = 'places';

class SqliteHelper {
  // create singleton instance
  factory SqliteHelper() => _instance;
  static final SqliteHelper _instance = SqliteHelper._();

  late final Database _db;
  bool _isInitialized = false;

  // private constructor
  SqliteHelper._() {
    _init().then((db) {
      _db = db;
      _isInitialized = true;
    });
  }

  // destructor
  void dispose() {
    _db.close();
  }

  Future<void> _waitForInit() async {
    await Future.doWhile(() async {
      if (!_isInitialized) {
        await Future.delayed(const Duration(milliseconds: 100));
        return true;
      }
      return false;
    });
  }

  Future<Database> _init() async {
    final dbPath = await sqlite.getDatabasesPath();
    return await sqlite.openDatabase(
      path.join(dbPath, _kDatabaseName),
      onCreate: (db, version) {
        // should be same as the one in lib/models/place.dart
        return db.execute(
          '''CREATE TABLE $_kTable(
                id TEXT PRIMARY KEY, 
                title TEXT, 
                address TEXT, 
                imageUrl TEXT, 
                latitude REAL, 
                longitude REAL
          )''',
        );
      },
      version: 1,
    );
  }

  Future<int> insert(Map<String, dynamic> data) async {
    await _waitForInit();
    return await _db.insert(
      _kTable,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    await _waitForInit();
    return await _db.query(_kTable);
  }

  Future<int> delete(String id) async {
    await _waitForInit();
    return await _db.delete(
      _kTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
