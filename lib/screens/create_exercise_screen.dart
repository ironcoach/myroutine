import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class CreateExerciseScreen extends ConsumerStatefulWidget {
  static CreateExerciseScreen builder(
          BuildContext context, GoRouterState state) =>
      const CreateExerciseScreen();
  const CreateExerciseScreen({super.key});

  @override
  ConsumerState<CreateExerciseScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateExerciseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Exercise'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Exercise Title',
                hintText: 'Exercise Title',
                controller: _titleController,
              ),
              const Gap(15),
              ElevatedButton(
                onPressed: _createExercise,
                child: const DisplayWhiteText(text: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createExercise() async {
    final title = _titleController.text.trim();

    if (title.isNotEmpty) {
      final exercise = Exercise(
        title: title,
      );

      await ref
          .read(exerciseProvider.notifier)
          .createEx(exercise)
          .then((value) {
        AppAlerts.displaySnackBar(context, 'Exercise Created Successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackBar(context, 'Exercise Title Cannont be Empty');
    }
  }
}
