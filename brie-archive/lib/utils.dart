import 'package:logger/logger.dart';

extension StringExtension on String {
  String truncate([int maxLength = 10]) =>
      length > maxLength ? '${substring(0, maxLength)}...' : this;
}

var logger = Logger(
  printer: PrettyPrinter(
    // Number of method calls to be displayed
    methodCount: 2,
    // Number of method calls if stacktrace is provided
    errorMethodCount: 8,
    // Width of the output
    lineLength: 120,
    colors: true,
    printEmojis: true,
    // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
