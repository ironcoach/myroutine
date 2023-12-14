import 'package:flutter/material.dart';

@immutable
class RouteLocation {
  const RouteLocation._();

  static String get home => '/home';
  static String get createExercise => '/createExercise/:routineid';
  static String get createRoutine => '/createRoutine/:action/:title/:note/:id';
}
