import 'package:myroutine/data/data.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final TaskDatasource _datasource;

  ExerciseRepositoryImpl(this._datasource);

  @override
  Future<void> addEx(Exercise exercise) async {
    try {
      await _datasource.addExercise(exercise);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteEx(int exID) async {
    try {
      await _datasource.deleteExercise(exID);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Exercise>> getAllExercises() async {
    //print('Get all Exercises repo implementation');
    try {
      return await _datasource.getAllExercises();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateEx(Exercise exercise) async {
    try {
      await _datasource.updateExercise(exercise);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> linkEx(int routineID) async {
    try {
      await _datasource.linkExercise(routineID);
    } catch (e) {
      throw '$e';
    }
  }
}
