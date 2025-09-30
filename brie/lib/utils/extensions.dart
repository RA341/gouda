extension StringExtension on String {
  /// if string is empty return null else return value
  String? get orNull => isEmpty ? null : this;
}
