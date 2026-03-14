import 'package:logger/logger.dart';

extension StringExtension on String {
  String truncate([int maxLength = 10]) =>
      length > maxLength ? '${substring(0, maxLength)}...' : this;
}

Logger logger = Logger(
  printer: PrettyPrinter(
    // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
