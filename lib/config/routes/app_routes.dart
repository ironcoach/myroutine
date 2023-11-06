import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/screens/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createExercise,
    parentNavigatorKey: navigationKey,
    builder: CreateExerciseScreen.builder,
  ),
];
