// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class DisplayListOfExercises extends ConsumerWidget {
  const DisplayListOfExercises({
    Key? key,
    required this.exercises,
  }) : super(key: key);

  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    // final height =
    //     isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyExerciseMessage =
        exercises.isEmpty ? 'No Exercises' : 'There are no tasks';

    return CommonContainer(
      height: deviceSize.height * 0.25,
      child: exercises.isEmpty
          ? Center(
              child: Text(
                emptyExerciseMessage,
                style: context.textTheme.titleLarge,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: exercises.length,
              itemBuilder: (ctx, index) {
                final exercise = exercises[index];
                return InkWell(
                  onTap: () {},
                  // onTap: () async {
                  //   await showModalBottomSheet(
                  //       context: context,
                  //       builder: (ctx) {
                  //         return TaskDetails(task: task);
                  //       });
                  // },
                  child: ExerciseTile(
                    exercise: exercise,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                );
              },
            ),
    );
  }
}
