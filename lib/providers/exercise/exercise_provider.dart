import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';

final exerciseProvider =
    StateNotifierProvider<ExerciseNotifier, ExerciseState>((ref) {
  final repository = ref.watch(exerciseRepositoryProvider);

  return ExerciseNotifier(repository);
});
