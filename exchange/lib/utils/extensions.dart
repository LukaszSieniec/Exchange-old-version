import 'package:exchange/constants/my_constants.dart';

extension NumberAppend on String {
  String appendNumber(String value) {
    switch (value) {
      case MyLabels.backspace:
        return length > 1 ? substring(0, length - 1) : MyLabels.zero;
      case MyLabels.dot:
        return contains(MyLabels.dot) ? this : this + MyLabels.dot;
      default:
        if (contains('.') && length - indexOf('.') >= 3) {
          return this;
        } else {
          return this == MyLabels.zero ? value : this + value;
        }
    }
  }
}
