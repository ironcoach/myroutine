import 'package:flutter/material.dart';
import 'package:myroutine/data/data.dart';

class RepScreen extends StatefulWidget {
  Exercise exercise;

  RepScreen({super.key, required this.exercise});

  @override
  State<RepScreen> createState() => _RepScreenState();
}

class _RepScreenState extends State<RepScreen> {
// Workout screen user interface
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
            // Background of the screen
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.purple, Colors.indigo],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight)),
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
                      "Repetitions",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.1,
                        fontFamily: "Raleway",
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ),
                // Divider
                Divider(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.white),
                Text(
                  "Perform...",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontFamily: "Raleway",
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                Text(
                  "${widget.exercise.title}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontFamily: "Raleway",
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
                // Divider
                Divider(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.white),

                Column(
                  children: [
                    Text('Reps: ${widget.exercise.repCount}',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: MediaQuery.of(context).size.width * 0.1),
                        textAlign: TextAlign.center),
                    Text('Set: ${widget.exercise.setCount}',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: MediaQuery.of(context).size.width * 0.1),
                        textAlign: TextAlign.center),
                  ],
                ),
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
    return Colors.pink;
  }

  // Start/Pause button bar
  Widget _buttonBar() {
    // On finished, show a button to go back to main screen

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            iconSize: MediaQuery.of(context).size.height * 0.12,
            // When pressed, dispose the workout and pop the current screen
            onPressed: () => {
                  Navigator.pop(context),
                },
            // Icon on the button
            icon: Icon(Icons.cancel, color: Colors.white70)),
        IconButton(
            iconSize: MediaQuery.of(context).size.height * 0.12,
            onPressed: () {
              Navigator.pop(context);
            },
            // Icon on the button depends on if the workout is active or not
            icon: Icon(Icons.play_circle_filled, color: Colors.white70))
      ],
    );
  }
}
