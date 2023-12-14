import 'package:equatable/equatable.dart';
import 'package:myroutine/utils/utils.dart';

class Routine extends Equatable {
  final int? id;
  final String title;
  final String note;

  const Routine({
    this.id,
    required this.title,
    required this.note,
  });

  @override
  List<Object> get props {
    return [
      title,
      note,
    ];
  }

  Routine copyWith({
    int? id,
    String? title,
    String? note,
  }) {
    return Routine(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      RoutineKeys.id: id,
      RoutineKeys.title: title,
      RoutineKeys.note: note,
    };
  }

  factory Routine.fromJson(Map<String, dynamic> map) {
    return Routine(
      id: map[RoutineKeys.id] != null ? map['id'] as int : null,
      title: map[RoutineKeys.title] as String,
      note: map[RoutineKeys.note] as String,
    );
  }
}
