import 'package:intl/intl.dart';

String getShortNumber(num number) {
  NumberFormat shortFormat = NumberFormat.compact(locale: "en_US");
  return shortFormat.format(number);
}
