import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
//import 'package:intl/intl.dart';
import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/screens/screens.dart';
import 'package:myroutine/screens/timer_screen.dart';
import 'package:myroutine/screens/workout_screen.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class CreateRoutineScreen extends ConsumerStatefulWidget {
  final String action;
  final String title;
  final String note;
  final int id;

  const CreateRoutineScreen({
    super.key,
    required this.action,
    required this.title,
    required this.note,
    required this.id,
  });

  @override
  ConsumerState<CreateRoutineScreen> createState() =>
      _CreateRoutineScreenState();
}

class _CreateRoutineScreenState extends ConsumerState<CreateRoutineScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  //bool isFirst = true;
  String? myTitle;
  String? myNote;

  //late Hiit _hiit;

  @override
  void initState() {
    //myTitle = widget.title;
    //myNote = widget.note;

    if (widget.action == "Add") {
      //print("Add");
      _titleController.text = "";
      _noteController.text = "";
    } else {
      //print("Edit");

      _titleController.text = widget.title;
      _noteController.text = widget.note;
    }
    //_hiit = defaultHiit;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exState = ref.watch(exerciseProvider);
    final routineState = ref.watch(routinesProvider);

    //final String myAction = widget.action;
    int routineID = widget.id;

    final exercises = _filteredExercises(exState.exercises, routineID);

    //print("Action: $myAction\nTitle:$myTitle \nNote:$myNote");

    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(text: '${widget.action} Routine '),
        actions: [
          IconButton(
            onPressed: () {
              _addExercise();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Title',
                hintText: 'Routine Title',
                controller: _titleController,
              ),
              const Gap(15),
              CommonTextField(
                title: 'Note',
                maxLines: 4,
                hintText: 'Routine Note',
                controller: _noteController,
              ),
              Text(
                'Steps',
                style: context.textTheme.headlineMedium,
              ),
              const Gap(10),
              DisplayListOfExercises(
                // exercises: exState.exercises,
                exercises: exercises,
              ),
              const Gap(15),
              ElevatedButton(
                onPressed: () => _createRoutine(routineID),
                child: const DisplayWhiteText(text: 'Save'),
              ),
              const Gap(15),
              Visibility(
                visible: exercises.isNotEmpty,
                child: ElevatedButton(
                  onPressed: () {
                    processExercise(exercises);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => TimerScreen(
                    //       hiit: _hiit,
                    //       exercises: exercises,
                    //     ),
                    //   ),
                    // );
                  },
                  child: const DisplayWhiteText(text: 'Begin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addExercise() {
    final exercise = Exercise(
      routineID: widget.id,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateExerciseScreen(
          action: "Add",
          exercise: exercise,
        ),
      ),
    );
  }

  void processExercise(List<Exercise> exercises) async {
    for (var exercise in exercises) {
      print('Exercise: ${exercise.title} Type: ${exercise.repType}');

      if (exercise.repType == "Timer") {
        final Hiit hiit = Hiit(
          reps: exercise.repCount!,
          workTime: Duration(seconds: exercise.workTime!),
          repRest: Duration(seconds: exercise.restTime!),
          sets: 1,
          setRest: const Duration(seconds: 5),
          delayTime: const Duration(seconds: 2),
        );

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimerScreen(
              hiit: hiit,
              title: exercise.title!,
            ),
          ),
        );
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepScreen(
              exercise: exercise,
            ),
          ),
        );
      }
    }
  }

  void _createRoutine(int routineID) async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();

    final routine = Routine(
      title: title,
      note: note,
      id: routineID,
    );

    if (routineID >= 95000) {
      final routine = Routine(
        title: title,
        note: note,
      );
      if (title.isNotEmpty) {
        await ref
            .read(routinesProvider.notifier)
            .addRoutine(routine, ref)
            .then((value) {
          AppAlerts.displaySnackBar(context, 'Routine Created Successfully');
          final myRecID = ref.read(routinesProvider).routineID;
          _updateExRecords(myRecID);
          //context.pop();
          Navigator.pop(context);
        });
      } else {
        AppAlerts.displaySnackBar(context, 'Routine Title Cannont be Empty');
      }
    } else {
      await ref
          .read(routinesProvider.notifier)
          .updateRoutine(routine)
          .then((value) {
        AppAlerts.displaySnackBar(context, 'Routine Updated Successfully');
        //final myRecID = ref.read(routinesProvider).routineID;
        //_updateExRecords(myRecID);
        //context.pop();
        Navigator.pop(context);
      });
    }
  }

  void _updateExRecords(int routineID) async {
    await ref.read(exerciseProvider.notifier).linkEx(routineID);
  }
}

List<Exercise> _filteredExercises(List<Exercise> exercises, int id) {
  final List<Exercise> filteredList = [];
  for (var exercise in exercises) {
    //print('Task Complete ${task.title} ${task.isCompleted}');
    if (exercise.routineID == id) {
      filteredList.add(exercise);
    }
  }
  return filteredList;
}
