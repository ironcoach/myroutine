//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

//import '../data/models/tasks.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final exState = ref.watch(exerciseProvider);
    //final completedTasks = _completedTasks(taskState.tasks);
    final inCompletedTasks = _inCompletedTasks(taskState.tasks);
    print('exState length ${exState.exercises.length}');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.30,
                width: deviceSize.width,
                color: colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: 'Oct 26, 2023',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    Gap(10),
                    DisplayWhiteText(
                      text: 'My Routines',
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: inCompletedTasks,
                    ),
                    const Gap(10),
                    Text(
                      'Steps',
                      style: context.textTheme.headlineMedium,
                    ),
                    const Gap(10),
                    DisplayListOfExercises(
                      exercises: exState.exercises,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add Task'),
                      ),
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () =>
                          context.push(RouteLocation.createExercise),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add Exercise'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // List<Task> _completedTasks(List<Task> tasks) {
  //   final List<Task> filteredTasks = [];
  //   for (var task in tasks) {
  //     //print('Task Complete ${task.title} ${task.isCompleted}');
  //     if (task.isCompleted) {
  //       filteredTasks.add(task);
  //     }
  //   }
  //   return filteredTasks;
  // }

  List<Task> _inCompletedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      //print('Task Not Complete ${task.title} ${task.isCompleted}');
      if (!task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
