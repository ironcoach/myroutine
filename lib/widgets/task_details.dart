// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:myroutine/data/data.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withOpacity(0.3),
            child: Icon(task.category.icon),
          ),
          const Gap(16),
          Text(
            task.title,
            style: style.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            task.time,
            style: style.titleMedium,
          ),
          const Gap(16),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Task to be completed on ${task.date}'),
                Icon(
                  color: task.category.color,
                  Icons.check_box,
                )
              ],
            ),
          ),
          const Gap(16),
          Divider(thickness: 1.5, color: task.category.color),
          const Gap(16),
          Text(task.note.isEmpty ? 'No notes for this task' : task.note),
          const Gap(16),
          Visibility(
            visible: task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Task was completed on ${task.date}'),
                Icon(
                  color: task.category.color,
                  Icons.check_box,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
