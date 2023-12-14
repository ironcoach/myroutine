export 'extensions.dart';
export 'helpers.dart';
export 'db_keys.dart';
export 'task_keys.dart';
export 'routine_keys.dart';
export 'exercise_keys.dart';
export 'app_alerts.dart';

String formatTime(Duration duration) {
  // Special formatting in the case where the timer is >= 1 hour
  if (duration.inHours >= 1) {
    String hours = (duration.inHours).toString();
    String minutes = ((duration.inMinutes) - ((duration.inHours) * 60))
        .toString()
        .padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  } else {
    String minutes = (duration.inMinutes).toString();
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
