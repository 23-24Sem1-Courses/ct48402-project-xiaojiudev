import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8, 
        lineLength: 200, 
        printEmojis: true, 
        printTime: false 
        ),
  );

  static void info(dynamic message) {
    logger.i(message);
  }

  static void debug(dynamic message) {
    logger.d(message);
  }

  static void warning(dynamic message) {
    logger.w(message);
  }

  static void error(dynamic message) {
    logger.e(message);
  }

  static void wtf(dynamic message) {
    logger.wtf(message);
  }
}
