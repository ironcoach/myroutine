// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:myroutine/data/models/models.dart';

class RoutineState extends Equatable {
  final List<Routine> routines;
  int routineID;

  RoutineState(this.routines, this.routineID);

  RoutineState.initial({
    this.routines = const [],
    this.routineID = 0,
  });

  RoutineState copyWith({
    List<Routine>? routines,
    int? routineID,
  }) {
    return RoutineState(
      routines ?? this.routines,
      routineID ?? this.routineID,
    );
  }

  @override
  List<Object> get props => [routines, routineID];
}
