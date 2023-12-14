import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';

final routinesProvider =
    StateNotifierProvider<RoutineNotifier, RoutineState>((ref) {
  final repository = ref.watch(routineRepositoryProvider);
  final exrepository = ref.watch(exerciseRepositoryProvider);
  return RoutineNotifier(repository, exrepository);
});
