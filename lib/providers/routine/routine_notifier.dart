// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/data/data.dart';

class RoutineNotifier extends StateNotifier<RoutineState> {
  final RoutineRepository _repository;
  final ExerciseRepository _exerciseRepository;

  RoutineNotifier(this._repository, this._exerciseRepository)
      : super(RoutineState.initial()) {
    getRoutines();
  }

  Future<void> addRoutine(Routine routine, WidgetRef ref) async {
    try {
      await _repository.addRoutine(routine, ref);
      getRoutines();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateRoutine(Routine routine) async {
    try {
      await _repository.updateRoutine(routine);
      getRoutines();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteRoutine(Routine routine) async {
    try {
      final int? routineID = routine.id;
      await _exerciseRepository.deleteEx(routineID!);
      await _repository.deleteRoutine(routine);
      getRoutines();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getRoutines() async {
    //print('Get all Routines Notifier');
    try {
      final routines = await _repository.getAllRoutines();
      state = state.copyWith(routines: routines);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
