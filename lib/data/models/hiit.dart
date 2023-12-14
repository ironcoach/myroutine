// Default values for the timer
Hiit get defaultHiit => Hiit(
      reps: 2,
      workTime: const Duration(seconds: 40),
      repRest: const Duration(seconds: 20),
      sets: 1,
      setRest: const Duration(seconds: 45),
      delayTime: const Duration(seconds: 5),
    );

class Hiit {
  // Reps in a workout
  int reps;
  // Exercise time in each rep
  Duration workTime;
  // Rest time between each rep
  Duration repRest;
  // Sets in a workout
  int sets;
  // Rest time between each set
  Duration setRest;
  // Initial countdown before the workout
  Duration delayTime;

  Hiit({
    required this.reps,
    required this.workTime,
    required this.repRest,
    required this.sets,
    required this.setRest,
    required this.delayTime,
  });

  Duration getTotalTime() {
    //
    return (workTime + repRest) * reps;
    // return (workTime * reps * sets) +
    //     (repRest * sets * (reps - 1)) +
    //     (setRest * (sets - 1));
  }

  Hiit.fromJson(Map<String, dynamic> json)
      : reps = json['reps'],
        workTime = Duration(seconds: json['workTime']),
        repRest = Duration(seconds: json['repRest']),
        sets = json['sets'],
        setRest = Duration(seconds: json['setRest']),
        delayTime = Duration(seconds: json['delayTime']);

  Map<String, dynamic> toJson() => {
        'reps': reps,
        'workTime': workTime.inSeconds,
        'repRest': repRest.inSeconds,
        'sets': sets,
        'setRest': setRest.inSeconds,
        'delayTime': delayTime.inSeconds,
      };
}
