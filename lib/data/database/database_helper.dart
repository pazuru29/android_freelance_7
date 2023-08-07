import 'dart:io';

import 'package:android_freelance_7/data/database/models/history_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'sport_matches.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE history (
    sport_type INTEGER NOT NULL,
    time_of_match INTEGER NOT NULL,
    score_team_1 INTEGER NOT NULL,
    score_team_2 INTEGER NOT NULL
    )''');
  }

  Future<List<HistoryModel>> getHistory() async {
    Database db = await instance.database;
    var history = await db.query('history');
    return history.map((e) => HistoryModel.fromMap(e)).toList();
  }

  //HistoryModel
  Future<int?> addHistory(HistoryModel historyModel) async {
    Database db = await instance.database;
    return await db.insert('history', historyModel.toMap());
  }

  Future<int?> deleteHistory() async {
    Database db = await instance.database;
    return db.delete('history');
  }
}
