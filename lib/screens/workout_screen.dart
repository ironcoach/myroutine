import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:wakelock/wakelock.dart';

import 'package:myroutine/data/data.dart';

import 'package:myroutine/utils/utils.dart';

// All the possible states of the timer
String workoutStage(WorkoutState step) {
  switch (step) {
    case WorkoutState.starting:
      return "Delay";
    case WorkoutState.exercising:
      return "Interval";
    case WorkoutState.repResting:
      return "Rest";
    case WorkoutState.setResting:
      return "Set Rest";
    case WorkoutState.finished:
      return "Complete";
    default:
      return "";
  }
}

class WorkoutScreen extends StatefulWidget {
  final Hiit hiit;
  final List<Exercise> exercises;

  const WorkoutScreen({
    super.key,
    required this.hiit,
    required this.exercises,
  });

  @override
  State<StatefulWidget> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late Workout _workout;
  int round = 1;
  late List<Exercise> exercises;

  // Initialize the state of the workout
  @override
  initState() {
    debugPrint('Starting from workout initState');
    super.initState();
    // The following line will enable the Android and iOS wakelock.
    debugPrint('Pre wakelock from workout initState');
    Wakelock.enable();
    exercises = widget.exercises;

    widget.hiit.delayTime = Duration(seconds: 5);
    widget.hiit.workTime = Duration(seconds: 5);
    widget.hiit.repRest = Duration(seconds: 5);
    widget.hiit.setRest = Duration(seconds: 5);

    _workout = Workout(widget.hiit, _onWorkoutChanged);
    debugPrint('pre Starting from workout initState');

    _start();
  }

  // Callback for when the workout state changes
  _onWorkoutChanged() {
    this.setState(() {});
  }

  // Dispose of the state of the workout
  @override
  dispose() {
    _workout.dispose();
    // The following line will disable the Android and iOS wakelock.
    Wakelock.disable();
    super.dispose();
  }

  // Start the workout
  _start() {
    debugPrint('Starting from workout Start');
    _workout.start();
  }

  // Pause the workout
  _pause() {
    _workout.pause();
  }

  // Workout screen user interface
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    round = _workout.rep;

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
            // Background of the screen
            decoration: _getDecoration(theme),
            padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).size.height * 0.08,
                20,
                MediaQuery.of(context).size.height * 0.08),
            child: Column(
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                // This row contains the name of the stage of the workout
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      workoutStage(_workout.step),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                          fontFamily: "Raleway",
                          color: Colors.white70),
                    ),
                    // Text(
                    //   exercises[round].title,
                    //   style: TextStyle(
                    //       fontSize: MediaQuery.of(context).size.width * 0.1,
                    //       fontFamily: "Raleway",
                    //       color: Colors.white70),
                    // ),
                  ],
                ),
                // Divider
                Divider(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.white),

                // Time remaining
                Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: CircularPercentIndicator(
                      percent: _workout.percentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animateFromLastPercent: true,
                      radius: MediaQuery.of(context).size.height * 0.2,
                      lineWidth: MediaQuery.of(context).size.height * 0.02,
                      progressColor:
                          _workout.isActive ? Colors.white : Colors.white70,
                      backgroundColor: Colors.black12,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(formatTime(_workout.timeRemaining),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fontFamily: "Open Sans",
                                  fontWeight: FontWeight.w500)),
                          //SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                          Text("Time Elapsed",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center),
                          Text(formatTime(_workout.totalTimeElapsed),
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.1),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )),

                // Divider
                Divider(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.white),

                Text('Round: ${round}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: MediaQuery.of(context).size.width * 0.1),
                    textAlign: TextAlign.center),
                // Text('Round: ${round}'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Expanded(child: _buttonBar())
              ],
            ))
      ],
    ));
  }

  // Change the background of the screen depending on the workout state
  _backgroundColour(ThemeData theme) {
    switch (_workout.step) {
      case WorkoutState.exercising:
        return Colors.lightGreen;
      case WorkoutState.repResting:
        return Colors.blueAccent;
      case WorkoutState.setResting:
        return Colors.pink;
      default:
        return theme.colorScheme.background;
    }
  }

  // Sets the background color(s) of the screen
  _getDecoration(ThemeData theme) {
    // When the workout step is initial, starting, or finished fill the background
    // with a gradient
    if (_workout.step == WorkoutState.initial ||
        _workout.step == WorkoutState.starting ||
        _workout.step == WorkoutState.finished) {
      return const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Colors.purple, Colors.indigo],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight));
      // Otherwise, the colour of the background should be a solid colour
    } else {
      return BoxDecoration(color: _backgroundColour(theme));
    }
  }

  // Start/Pause button bar
  Widget _buttonBar() {
    // On finished, show a button to go back to main screen
    if (_workout.step == WorkoutState.finished) {
      return IconButton(
          padding: EdgeInsets.all(15),
          iconSize: MediaQuery.of(context).size.height * 0.12,
          // When pressed, pop the current screen
          onPressed: () => Navigator.pop(context),
          // Icon on the button
          icon: Icon(Icons.home, color: Colors.white70));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.12,
              // When pressed, dispose the workout and pop the current screen
              onPressed: () => {
                    _workout.dispose(),
                    Navigator.pop(context),
                  },
              // Icon on the button
              icon: Icon(Icons.cancel, color: Colors.white70)),
          IconButton(
              iconSize: MediaQuery.of(context).size.height * 0.12,
              onPressed: _workout.isActive ? _pause : _start,
              // Icon on the button depends on if the workout is active or not
              icon: Icon(
                  _workout.isActive
                      ?
                      // If active pause icon, if inactive play icon
                      Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.white70))
        ],
      );
    }
  }
}
