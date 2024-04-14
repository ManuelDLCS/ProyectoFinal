import 'package:sqflite/sqflite.dart';
import 'volunteer.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
Future<void> _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE volunteers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fullName TEXT NOT NULL,
      identification TEXT NOT NULL,
      contactInfo TEXT NOT NULL,
      address TEXT NOT NULL,
      educationLevel TEXT NOT NULL,
      availability TEXT NOT NULL,
      healthStatus TEXT NOT NULL,
      motivation TEXT NOT NULL
    )
  ''');
}

Future<List<Volunteer>> getVolunteers() async {
  final db = await instance.database;
  final volunteers = await db.query('volunteers', orderBy: 'fullName ASC');
  return volunteers.map((json) => Volunteer.fromJson(json)).toList();
}

Future<void> insertVolunteer(Volunteer volunteer) async {
  final db = await instance.database;
  await db.insert(
    'volunteers',
    volunteer.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
}