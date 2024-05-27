 import 'package:intl/intl.dart';

String fecha(String datetimeString) {
    DateTime datetime = DateTime.parse(datetimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(datetime);
    return formattedDate;
  }