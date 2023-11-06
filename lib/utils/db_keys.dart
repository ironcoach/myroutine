import 'package:flutter/material.dart';
import 'package:myroutine/utils/task_keys.dart';

@immutable
class DBKeys {
  const DBKeys._();
  static const String dbName = 'tasks.db';
  static const String dbTable = 'tasks';
  static const String idColumn = TaskKeys.id;
  static const String titleColumn = TaskKeys.id;
  static const String categoryColumn = TaskKeys.category;
  static const String dateColumn = TaskKeys.date;
  static const String timeColumn = TaskKeys.time;
  static const String noteColumn = TaskKeys.note;
  static const String isCompletedColumn = TaskKeys.isCompleted;
}
