import 'package:myroutine/data/data.dart';
import 'package:myroutine/utils/utils.dart';
//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();

  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDb();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}myroutine.db';

    //final dbPath = await getDatabasesPath();
    //final path = join(dbPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBKeys.dbTable} (
        ${TaskKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TaskKeys.title} TEXT,
        ${TaskKeys.note} TEXT,
        ${TaskKeys.date} TEXT,
        ${TaskKeys.time} TEXT,
        ${TaskKeys.category} TEXT,
        ${TaskKeys.isCompleted} INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE ExTable (
        ${ExKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExKeys.title} TEXT
      )
    ''');
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        DBKeys.dbTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> addExercise(Exercise exercise) async {
    final db = await database;
    print('add exercise Datasource');
    return db.transaction((txn) async {
      return await txn.insert(
        'ExTable',
        exercise.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      DBKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(
      maps.length,
      (index) {
        return Task.fromJson(maps[index]);
      },
    );
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await database;
    //print('Get all Exercises Datasource');
    final List<Map<String, dynamic>> maps = await db.query(
      'ExTable',
      orderBy: "id",
    );
    print('Get all Exercises Map length ${maps.length}');
    return List.generate(
      maps.length,
      (index) {
        return Exercise.fromJson(maps[index]);
      },
    );
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable,
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    });
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        'ExTable',
        exercise.toJson(),
        where: 'id = ?',
        whereArgs: [exercise.id],
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          DBKeys.dbTable,
          where: 'id = ?',
          whereArgs: [task.id],
        );
      },
    );
  }

  Future<int> deleteExercise(Exercise exercise) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          'ExTable',
          where: 'id = ?',
          whereArgs: [exercise.id],
        );
      },
    );
  }
}
