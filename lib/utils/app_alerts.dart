import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/utils/utils.dart';

import '../data/data.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.surface,
          )),
      backgroundColor: context.colorScheme.primary,
    ));
  }

  static Future<void> showDeleteExercise(
      BuildContext context, WidgetRef ref, int routineID) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('No'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref
            .read(exerciseProvider.notifier)
            .deleteEx(routineID)
            .then((value) {
          displaySnackBar(
            context,
            'Exercise Deleted',
          );
          context.pop();
        });
      },
      child: const Text('YES'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text('Are you sure you want to delete?'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) {
        return alert;
      },
    );
  }

  static Future<void> showDeleteRoutine(
      BuildContext context, WidgetRef ref, Routine routine) async {
    Widget cancelButton = TextButton(
      onPressed: () => context.pop(),
      child: const Text('No'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref
            .read(routinesProvider.notifier)
            .deleteRoutine(routine)
            .then((value) {
          displaySnackBar(
            context,
            'Routine Deleted',
          );
          context.pop();
        });
      },
      child: const Text('YES'),
    );
    AlertDialog alert = AlertDialog(
      title: const Text('Are you sure you want to delete?'),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (ctx) {
        return alert;
      },
    );
  }
}
