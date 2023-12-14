//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/screens/screens.dart';
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
    //final taskState = ref.watch(taskProvider);
    //final exState = ref.watch(exerciseProvider);
    final routineState = ref.watch(routinesProvider);
    //final String myRecNum = ref.read(routinesProvider).routineID.toString();

    //final completedTasks = _completedTasks(taskState.tasks);
    //final inCompletedTasks = _inCompletedTasks(taskState.tasks);
    //print('exState length ${exState.exercises.length}');

    return Scaffold(
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
                    //DisplayWhiteText(text: ' Num of recs $myRecNum'),
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
                    DisplayListOfRoutines(
                      routines: routineState.routines,
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Image.asset(
                        'assets/images/push-up.png',
                        height: 200,
                      ),
                    ),
                    const Gap(0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateRoutineScreen(
                                    action: "add",
                                    title: "",
                                    note: "",
                                    id: 99999,
                                  )),
                        );

                        // context.pushNamed(
                        //   "createRoutine",
                        //   pathParameters: {
                        //     "action": "Add",
                        //     "title": "title",
                        //     "note": "note",
                        //     "id": "99999",
                        //   },
                        // );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add Routine'),
                      ),
                    ),
                    const Gap(20),
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

  // List<Task> _inCompletedTasks(List<Task> tasks) {
  //   final List<Task> filteredTasks = [];
  //   for (var task in tasks) {
  //     //print('Task Not Complete ${task.title} ${task.isCompleted}');
  //     if (!task.isCompleted) {
  //       filteredTasks.add(task);
  //     }
  //   }
  //   return filteredTasks;
  // }
}
