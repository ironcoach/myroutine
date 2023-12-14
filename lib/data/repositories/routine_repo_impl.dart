import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/data/data.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final TaskDatasource _datasource;

  RoutineRepositoryImpl(this._datasource);

  @override
  Future<void> addRoutine(Routine routine, WidgetRef ref) async {
    try {
      await _datasource.addRoutine(routine, ref);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteRoutine(Routine routine) async {
    try {
      await _datasource.deleteRoutine(routine);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Routine>> getAllRoutines() async {
    //print('Get all Routines repo implementation');
    try {
      return await _datasource.getAllRoutines();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateRoutine(Routine routine) async {
    try {
      await _datasource.updateRoutine(routine);
    } catch (e) {
      throw '$e';
    }
  }
}
