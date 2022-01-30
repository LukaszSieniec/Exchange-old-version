import 'package:shared_preferences/shared_preferences.dart';

class AccountBalance {
  static late final SharedPreferences _sharedPreferences;

  static const String _accountBalance = "Account Balance";

  AccountBalance._internal();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveAccountBalance(double accountBalance) async =>
      await _sharedPreferences.setDouble(_accountBalance, accountBalance);

  static double readAccountBalance() =>
      _sharedPreferences.getDouble(_accountBalance) ?? 1000.0;
}
