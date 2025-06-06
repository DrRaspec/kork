extension StringExtension on String {
  String firstCapitalize() {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
}