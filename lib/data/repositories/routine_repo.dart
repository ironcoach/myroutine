import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/models/models.dart';

abstract class RoutineRepository {
  Future<void> addRoutine(Routine routine, WidgetRef ref);
  Future<void> updateRoutine(Routine routine);
  Future<void> deleteRoutine(Routine routine);
  Future<List<Routine>> getAllRoutines();
}
