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
  // GoRoute(
  //   name: "createEx",
  //   path: RouteLocation.createExercise,
  //   parentNavigatorKey: navigationKey,
  //   builder: (context, state) => CreateExerciseScreen(
  //     routineID: state.pathParameters["routineid"]!,
  //   ),
  // ),
  // GoRoute(
  //   name: "createRoutine",
  //   path: RouteLocation.createRoutine,
  //   parentNavigatorKey: navigationKey,
  //   builder: (context, state) => CreateRoutineScreen(
  //       action: state.pathParameters["action"]!,
  //       title: state.pathParameters["title"]!,
  //       note: state.pathParameters["note"]!,
  //       id: state.pathParameters["id"]!),
  // ),
];
