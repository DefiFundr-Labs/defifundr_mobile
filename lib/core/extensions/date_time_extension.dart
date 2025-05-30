import 'package:intl/intl.dart' show DateFormat;

extension DateTimeExtension on DateTime {
  /// dd MMMM yyyy, j:m
  String toFormattedString1() {
    return DateFormat('dd MMMM yyyy, j:m').format(this);
  }

  /// dd MMM yyyy
  String toFormattedString2() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
