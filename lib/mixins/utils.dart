import 'package:intl/intl.dart';

mixin Utils {
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
  }

  void endLoading() {
    isLoading = false;
  }

  String formatDate(DateTime? date, {bool? fullDate}) {
    if (date == null) {
      return 'Empty date';
    }
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
    if (DateTime.now().day == date.day) {
      formattedDate = DateFormat('Today HH:mm').format(date);
    }
    if (DateTime.now().year == date.year) {
      formattedDate = DateFormat('dd MMM HH:mm').format(date);
    }

    return formattedDate;
  }

  DateTime? readebleDateToDateTime(String date, {bool? fullDate}) {
    DateTime? formattedDate = DateTime.tryParse(date);
    return formattedDate;
  }
}
