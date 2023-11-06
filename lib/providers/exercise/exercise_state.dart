// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:myroutine/data/models/models.dart';

class ExerciseState extends Equatable {
  final List<Exercise> exercises;

  const ExerciseState(this.exercises);

  const ExerciseState.initial({
    this.exercises = const [],
  });

  ExerciseState copyWith({
    List<Exercise>? exercises,
  }) {
    return ExerciseState(
      exercises ?? this.exercises,
    );
  }

  @override
  List<Object> get props => [exercises];
}
