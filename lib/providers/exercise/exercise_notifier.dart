// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/data/data.dart';

class ExerciseNotifier extends StateNotifier<ExerciseState> {
  final ExerciseRepository _repository;

  ExerciseNotifier(this._repository) : super(const ExerciseState.initial()) {
    getExercises();
  }

  Future<void> createEx(Exercise exercise) async {
    try {
      await _repository.addEx(exercise);
      getExercises();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateEx(Exercise exercise) async {
    try {
      await _repository.updateEx(exercise);
      getExercises();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Exercise exercise) async {
    try {
      await _repository.deleteEx(exercise);
      getExercises();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getExercises() async {
    print('Get all Exercises Notifier');
    try {
      final exercises = await _repository.getAllExercises();
      state = state.copyWith(exercises: exercises);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
