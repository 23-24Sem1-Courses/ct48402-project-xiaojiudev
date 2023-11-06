class TimeUtils {
  static String formatTime(int seconds) {
    if (seconds < 60) {
      return '$seconds second${seconds != 1 ? 's' : ''}';
    } else if (seconds < 3600) {
      int minutes = seconds ~/ 60;
      return '$minutes minute${minutes != 1 ? 's' : ''}';
    } else {
      int hours = seconds ~/ 3600;
      int remainingSeconds = seconds % 3600;
      if (remainingSeconds == 0) {
        return '$hours hour${hours != 1 ? 's' : ''}';
      } else {
        int minutes = remainingSeconds ~/ 60;
        return '$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}';
      }
    }
  }
}
