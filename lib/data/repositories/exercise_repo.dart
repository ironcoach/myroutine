import 'package:myroutine/data/models/models.dart';

abstract class ExerciseRepository {
  Future<void> addEx(Exercise exercise);
  Future<void> updateEx(Exercise exercise);
  Future<void> deleteEx(int exID);
  Future<void> linkEx(int routineID);
  Future<List<Exercise>> getAllExercises();
}
