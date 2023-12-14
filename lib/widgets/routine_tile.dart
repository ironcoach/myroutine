// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:myroutine/utils/utils.dart';

import '../data/models/models.dart';

class RoutineTile extends StatelessWidget {
  const RoutineTile({
    Key? key,
    required this.routine,
  }) : super(key: key);
  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routine.title,
                  style: style.titleLarge,
                ),
                Text(
                  routine.note,
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
