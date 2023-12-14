import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
//import 'package:intl/intl.dart';

import 'package:myroutine/config/routes/routes.dart';
import 'package:myroutine/data/data.dart';
import 'package:myroutine/providers/providers.dart';
import 'package:myroutine/utils/utils.dart';
import 'package:myroutine/widgets/widgets.dart';

class CreateExerciseScreen extends ConsumerStatefulWidget {
  final String action;
  //int? id;
  Exercise? exercise;
  // final String title;
  // final int routineID;
  // final String repType;
  // final int repCount;
  // final int workTime;
  // final int restTime;
  // final int orderNum;
  // final int setCount;

  CreateExerciseScreen({
    required this.action,
    this.exercise,
    // this.id,
    // required this.title,
    // required this.routineID,
    // required this.repType,
    // required this.repCount,
    // required this.workTime,
    // required this.restTime,
    // required this.orderNum,
    // required this.setCount,
    super.key,
  });

  @override
  ConsumerState<CreateExerciseScreen> createState() =>
      _CreateExerciseScreenState();
}

List<String> exerciseType = ['Timer', 'Repetitions'];

class _CreateExerciseScreenState extends ConsumerState<CreateExerciseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _worktimeController = TextEditingController();
  final TextEditingController _resttimeController = TextEditingController();
  final TextEditingController _repController = TextEditingController();
  final TextEditingController _setCountController = TextEditingController();
  int? _currentExerciseType = 1;

  late Exercise exercise;

  @override
  void initState() {
    if (widget.exercise == null) {
      print('No Exercise record passed');
      const ex = Exercise(
        routineID: 99999,
        title: "",
        repType: "",
        workTime: 0,
        restTime: 0,
        repCount: 0,
        orderNum: 0,
        setCount: 1,
      );

      exercise = ex;
    } else {
      exercise = widget.exercise!;
    }

    if (widget.action == "Add") {
      //print("Add");

      //_titleController.text = exercise.title!;
      // _repController.text = "0";
      // _resttimeController.text = "0";
      // _worktimeController.text = "0";
      // _setCountController.text = "0";
    } else {
      //print("Edit");

      _titleController.text = exercise.title!;
      _repController.text = exercise.repCount.toString();
      _resttimeController.text = exercise.restTime.toString();
      _worktimeController.text = exercise.workTime.toString();
      _setCountController.text = exercise.setCount.toString();
      _currentExerciseType = exercise.repType == 'Timer' ? 1 : 2;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _worktimeController.dispose();
    _resttimeController.dispose();
    _repController.dispose();
    _setCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('RoutineID ${exercise.routineID}');

    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Exercise'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Exercise Title',
                hintText: 'Exercise Title',
                controller: _titleController,
              ),
              const Gap(10),
              Text(
                'Exercise Type',
                style: context.textTheme.titleLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 1,
                    groupValue: _currentExerciseType,
                    onChanged: (value) {
                      setState(() {
                        _currentExerciseType = value;
                      });
                    },
                  ),
                  const Text('Timer'),
                  const Gap(10),
                  Radio(
                    value: 2,
                    groupValue: _currentExerciseType,
                    onChanged: (value) {
                      setState(() {
                        _currentExerciseType = value;
                      });
                    },
                  ),
                  const Text('Reps'),
                ],
              ),
              const Gap(10),
              Visibility(
                visible: _currentExerciseType == 1,
                child: Column(
                  children: [
                    CommonTextField(
                      title: 'Enter Time Duration in Seconds',
                      hintText: 'Duration',
                      controller: _worktimeController,
                    ),
                    const Gap(10),
                    CommonTextField(
                      title: 'Enter Rest Interval in Seconds',
                      hintText: 'Rest Interval',
                      controller: _resttimeController,
                    ),
                    const Gap(10),
                    CommonTextField(
                      title: 'Enter Number of Reps',
                      hintText: 'Repetitions',
                      controller: _repController,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
              Visibility(
                visible: _currentExerciseType == 2,
                child: Column(
                  children: [
                    CommonTextField(
                      title: 'Enter Number of Reps',
                      hintText: 'Repetitions',
                      controller: _repController,
                    ),
                    const Gap(10),
                    CommonTextField(
                      title: 'Enter Number of Sets',
                      hintText: 'Sets',
                      controller: _setCountController,
                    ),
                  ],
                ),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () => _createExercise(exercise.routineID!),
                child: const DisplayWhiteText(text: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createExercise(int routineID) async {
    final title = _titleController.text.trim();
    final int repCount;
    final int worktime;
    final int resttime;
    final int setcount;

    if (_repController.text.isEmpty) {
      _repController.text = "1";
      repCount = 1;
    } else {
      repCount = int.parse(_repController.text);
    }
    if (_worktimeController.text.isEmpty) {
      _worktimeController.text = "1";
      worktime = 1;
    } else {
      worktime = int.parse(_worktimeController.text);
    }
    if (_resttimeController.text.isEmpty) {
      _resttimeController.text = "1";
      resttime = 1;
    } else {
      resttime = int.parse(_resttimeController.text);
    }

    if (_setCountController.text.isEmpty) {
      _setCountController.text = "1";
      setcount = 1;
    } else {
      setcount = int.parse(_setCountController.text);
    }

    if (routineID == 99999 && exercise.id == null) {
      if (title.isNotEmpty) {
        final exercise = Exercise(
          routineID: routineID,
          title: title,
          repType: _currentExerciseType == 1 ? 'Timer' : 'Rep',
          repCount: repCount,
          workTime: worktime,
          restTime: resttime,
          orderNum: 0,
          setCount: setcount,
        );

        await ref
            .read(exerciseProvider.notifier)
            .createEx(exercise)
            .then((value) {
          AppAlerts.displaySnackBar(context, 'Exercise Created Successfully');
          //context.pop();
          Navigator.pop(context);
        });
      }
    } else if (exercise.id != null) {
      final exercise = Exercise(
        routineID: routineID,
        title: title,
        repType: _currentExerciseType == 1 ? 'Timer' : 'Rep',
        repCount: repCount,
        workTime: worktime,
        restTime: resttime,
        orderNum: 0,
        setCount: setcount,
        id: this.exercise.id,
      );
      await ref
          .read(exerciseProvider.notifier)
          .updateEx(exercise)
          .then((value) {
        AppAlerts.displaySnackBar(context, 'Exercise Updated Successfully');
        //final myRecID = ref.read(routinesProvider).routineID;
        //_updateExRecords(myRecID);
        //context.pop();
        Navigator.pop(context);
      });
    } else {
      if (title.isNotEmpty) {
        final exercise = Exercise(
          routineID: routineID,
          title: title,
          repType: _currentExerciseType == 1 ? 'Timer' : 'Rep',
          repCount: repCount,
          workTime: worktime,
          restTime: resttime,
          orderNum: 0,
          setCount: setcount,
        );

        await ref
            .read(exerciseProvider.notifier)
            .createEx(exercise)
            .then((value) {
          AppAlerts.displaySnackBar(context, 'Exercise Created Successfully');
          //context.pop();
          Navigator.pop(context);
        });
      }
    }
  }
}
