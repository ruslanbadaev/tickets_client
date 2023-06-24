import 'package:intl/intl.dart';

class DateFormatter {
  static String formattedDateTime(DateTime dateTime, {String? pattern}) {
    return DateFormat(pattern ?? 'dd.MM.yyyy – kk:mm').format(dateTime);
  }
}
