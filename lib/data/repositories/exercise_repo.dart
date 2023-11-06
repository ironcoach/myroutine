import 'package:myroutine/data/models/models.dart';

abstract class ExerciseRepository {
  Future<void> addEx(Exercise exercise);
  Future<void> updateEx(Exercise exercise);
  Future<void> deleteEx(Exercise exercise);
  Future<List<Exercise>> getAllExercises();
}
