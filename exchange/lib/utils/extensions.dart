import 'package:exchange/constants/my_constants.dart';

extension NumberAppend on String {
  String appendAmountMoney(String value) {
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

  String appendAmountCryptocurrency(String value) {
    switch (value) {
      case MyLabels.backspace:
        return length > 1 ? substring(0, length - 1) : MyLabels.zero;
      case MyLabels.dot:
        return contains(MyLabels.dot) ? this : this + MyLabels.dot;
      default:
        return this == MyLabels.zero ? value : this + value;
    }
  }
}

extension Precision on double {
  double setAmountCryptocurrencyPrecision() {
    if (toString().contains('.') &&
        toString().length - toString().indexOf('.') >= 5) {
      return double.parse(toStringAsPrecision(4));
    } else {
      return this;
    }
  }

  double setAmountMoneyPrecision() {
    if (toString().contains('.')) {
      final int index = toString().indexOf('.');
      final int precision;

      if (index == 1 && toString()[0] == '0') {
        precision = index + 1;
      } else {
        precision = index + 2;
      }
      return double.parse(toStringAsPrecision(precision));
    } else {
      return this;
    }
  }
}
