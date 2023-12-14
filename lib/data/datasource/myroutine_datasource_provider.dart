import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});

// final exerciseDatasourceProvider = Provider<TaskDatasource>((ref) {
//   return TaskDatasource();
// });

// final routineDatasourceProvider = Provider<TaskDatasource>((ref) {
//   return TaskDatasource();
// });
