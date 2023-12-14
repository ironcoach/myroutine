// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:myroutine/utils/utils.dart';

class Exercise {
  final int? id;
  final int? routineID;
  final String? title;
  final String? repType;
  final int? workTime;
  final int? restTime;
  final int? repCount;
  final int? orderNum;
  final int? setCount;

  const Exercise({
    this.id,
    this.routineID,
    this.title,
    this.repType,
    this.workTime,
    this.restTime,
    this.repCount,
    this.orderNum,
    this.setCount,
  });

  // @override
  // List<Object> get props {
  //   return [
  //     routineID,
  //     title,
  //     repType,
  //     repCount,
  //     worktime,
  //     resttime,
  //     orderNum,
  //     setCount,
  //   ];
  // }

  Exercise copyWith({
    int? id,
    int? routineID,
    String? title,
    String? repType,
    int? worktime,
    int? resttime,
    int? repCount,
    int? orderNum,
    int? setCount,
  }) {
    return Exercise(
      id: id ?? this.id,
      routineID: routineID ?? this.routineID,
      title: title ?? this.title,
      repType: repType ?? this.repType,
      workTime: workTime ?? this.workTime,
      restTime: restTime ?? this.restTime,
      repCount: repCount ?? this.repCount,
      orderNum: orderNum ?? this.orderNum,
      setCount: setCount ?? this.setCount,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      ExKeys.id: id,
      ExKeys.routineID: routineID,
      ExKeys.title: title,
      ExKeys.repType: repType,
      ExKeys.repCount: repCount,
      ExKeys.workTime: workTime,
      ExKeys.restTime: restTime,
      ExKeys.orderNum: orderNum,
      ExKeys.setCount: setCount,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> map) {
    return Exercise(
      id: map[ExKeys.id] as int,
      routineID: map[ExKeys.routineID] as int,
      title: map[ExKeys.title] as String,
      repType: map[ExKeys.repType] as String,
      repCount: map[ExKeys.repCount] as int,
      workTime: map[ExKeys.workTime] as int,
      restTime: map[ExKeys.restTime] as int,
      orderNum: map[ExKeys.orderNum] as int,
      setCount: map[ExKeys.setCount] as int,
    );
  }
}
