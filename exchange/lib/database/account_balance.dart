import 'package:shared_preferences/shared_preferences.dart';

class AccountBalance {
  static late final SharedPreferences _sharedPreferences;

  static const String _accountBalance = "Account Balance";

  AccountBalance._internal();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveAccountBalance(final double accountBalance) async {
    _sharedPreferences.setDouble(_accountBalance, accountBalance);
  }

  static Future<double> readAccountBalance() async =>
      _sharedPreferences.getDouble(_accountBalance) ?? 1000.0;
}
