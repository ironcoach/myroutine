import 'package:equatable/equatable.dart';
import 'package:myroutine/utils/utils.dart';

class Exercise extends Equatable {
  final int? id;
  final String title;

  const Exercise({
    this.id,
    required this.title,
  });

  @override
  List<Object> get props {
    return [
      title,
    ];
  }

  Exercise copyWith({
    int? id,
    String? title,
  }) {
    return Exercise(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ExKeys.id: id,
      ExKeys.title: title,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> map) {
    return Exercise(
      id: map[ExKeys.id] != null ? map['id'] as int : null,
      title: map[ExKeys.title] as String,
    );
  }
}
