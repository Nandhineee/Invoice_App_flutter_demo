import 'package:intl/intl.dart';

class DateTimeConverter{
  static DateTime parseDate(String dateString) {
    DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    DateTime dateTime = dateFormat.parse(dateString);

    return dateTime;
  }
}