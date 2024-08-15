import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formattedDate() {
    return DateFormat('d MMM, yyyy').format(this);
  }
}
