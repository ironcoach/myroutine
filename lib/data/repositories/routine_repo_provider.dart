import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';

final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return RoutineRepositoryImpl(datasource);
});
