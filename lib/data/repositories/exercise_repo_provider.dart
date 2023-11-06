import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return ExerciseRepositoryImpl(datasource);
});
