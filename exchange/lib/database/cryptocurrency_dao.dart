class CryptocurrenciesDao {
  //Cryptocurrencies Table
  static const String cryptocurrenciesTableName = 'cryptocurrencies';
  static const String cryptocurrencySymbol = 'symbol';
  static const String cryptocurrencyName = 'name';
  static const String cryptocurrencyAmount = 'amount';

  //Transactions Table
  static const String transactionsTableName = 'transactions';
  static const String transactionId = 'id';
  static const String transactionCryptocurrencySymbol = 'symbol';
  static const String transactionCryptocurrencyName = 'name';
  static const String transactionType = 'type';
  static const String transactionAmount = 'amount';

  String get createCryptocurrenciesTableQuery =>
      "CREATE TABLE IF NOT EXISTS $cryptocurrenciesTableName($cryptocurrencySymbol TEXT PRIMARY KEY,"
      " $cryptocurrencyName TEXT,"
      " $cryptocurrencyAmount REAL)";

  String get createTransactionsTableQuery =>
      "CREATE TABLE IF NOT EXISTS $transactionsTableName($transactionId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      " $transactionCryptocurrencySymbol TEXT,"
      " $transactionCryptocurrencyName TEXT,"
      " $transactionType TEXT,"
      " $transactionAmount REAL)";
}
