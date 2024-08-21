import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formattedDate() {
    return DateFormat('d MMM, yyyy').format(this);
  }
}
extension DateTimeCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}