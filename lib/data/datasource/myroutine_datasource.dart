import 'package:flutter/material.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
//import 'package:myroutine/data/models/routines.dart';
import 'package:myroutine/utils/utils.dart';
//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      CREATE TABLE ${DBKeys.dbExercisesTable} (
        ${ExKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${ExKeys.routineID} INTEGER,
        ${ExKeys.title} TEXT,
        ${ExKeys.workTime} INTEGER,
        ${ExKeys.restTime} INTEGER,
        ${ExKeys.repType} INTEGER,
        ${ExKeys.repCount} INTEGER,
        ${ExKeys.orderNum} INTEGER,
        ${ExKeys.setCount} INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DBKeys.dbRoutineTable} (
        ${RoutineKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${RoutineKeys.title} TEXT,
        ${RoutineKeys.note} TEXT
      )
    ''');
  }

  Future<int> addExercise(Exercise exercise) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        DBKeys.dbExercisesTable,
        exercise.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> addRoutine(Routine routine, WidgetRef ref) async {
    final db = await database;
    return db.transaction((txn) async {
      var myReturn = await txn.insert(
        DBKeys.dbRoutineTable,
        routine.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      ref.read(routinesProvider).routineID = myReturn;
      return myReturn;
    });
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      DBKeys.dbExercisesTable,
      orderBy: "ordernum",
    );
    //print('Get all Exercises Map length ${maps.length}');
    return List.generate(
      maps.length,
      (index) {
        return Exercise.fromJson(maps[index]);
      },
    );
  }

  Future<List<Routine>> getAllRoutines() async {
    final db = await database;
    //print('Get all Exercises Datasource');
    final List<Map<String, dynamic>> maps = await db.query(
      DBKeys.dbRoutineTable,
      orderBy: "id",
    );
    //print('Get all Exercises Map length ${maps.length}');
    return List.generate(
      maps.length,
      (index) {
        return Routine.fromJson(maps[index]);
      },
    );
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbExercisesTable,
        exercise.toJson(),
        where: 'id = ?',
        whereArgs: [exercise.id],
      );
    });
  }

  Future<int> linkExercise(int routineID) async {
    final db = await database;

    int numRecs = await db.rawUpdate(
        'UPDATE ${DBKeys.dbExercisesTable} SET routineid = "$routineID" WHERE routineid >= 95000');
    //print("Number records modified $numRecs");

    return numRecs;
  }

  Future<int> updateRoutine(Routine routine) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbRoutineTable,
        routine.toJson(),
        where: 'id = ?',
        whereArgs: [routine.id],
      );
    });
  }

  Future<int> deleteExercise(int exID) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          DBKeys.dbExercisesTable,
          where: '${ExKeys.id} = ?',
          whereArgs: [exID],
        );
      },
    );
  }

  Future<int> deleteRoutine(Routine routine) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          DBKeys.dbRoutineTable,
          where: 'id = ?',
          whereArgs: [routine.id],
        );
      },
    );
  }
}
