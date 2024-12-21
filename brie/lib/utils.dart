extension StringExtension on String {
  String truncate([int maxLength = 10]) =>
      length > maxLength ? '${substring(0, maxLength)}...' : this;
}
