import 'package:logger/logger.dart';

class Log {
  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  static d(String message) {
    logger.d("${DateTime.now().toString()}\n$message");
  }

  static i(String message) {
    logger.i("${DateTime.now().toString()}\n$message");
  }

  static e(String message, StackTrace stackTrace) {
    logger.e("${DateTime.now().toString()}\n$message", null, stackTrace);
  }

  static w(String message) {
    logger.w("${DateTime.now().toString()}\n$message");
  }
}
