import 'dart:developer' as developer;

class Logger {
  static const String red = '\u001b[31m';
  static const String green = '\u001b[32m';
  static const String blue = '\u001b[34m';
  static const String cyan = '\u001b[36m';
  static const String magenta = '\u001b[35m';
  static const String yellow = '\u001b[33m';
  static const String grey = '\u001b[90m';
  static void log(String message, String color) {
    developer.log('$color$message');
  }
}
