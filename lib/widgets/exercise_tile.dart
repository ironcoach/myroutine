// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

import '../data/models/models.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.exercise,
  }) : super(key: key);
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    //final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    //final double backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    // final textDecoration =
    //     task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;
    // final fontWeight = task.isCompleted ? FontWeight.normal : FontWeight.bold;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: style.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
