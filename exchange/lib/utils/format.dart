import 'package:intl/intl.dart';

String getShortNumber(num? number) {
  if (number != null) {
    NumberFormat shortFormat = NumberFormat.compact(locale: "en_US");
    return shortFormat.format(number);
  } else {
    return 'N/A';
  }
}

String formatDate(String date) {
  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
}
