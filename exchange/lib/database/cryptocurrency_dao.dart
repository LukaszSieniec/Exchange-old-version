class CryptocurrenciesDao {
  //Cryptocurrencies Table
  static const String cryptocurrenciesTableName = 'cryptocurrencies';
  static const String cryptocurrencyId = 'id';
  static const String cryptocurrencySymbol = 'symbol';
  static const String cryptocurrencyName = 'name';
  static const String cryptocurrencyAmount = 'amount';
  static const String cryptocurrencyImage = 'image';

  //Transactions Table
  static const String transactionsTableName = 'transactions';
  static const String transactionId = 'id';
  static const String transactionCryptocurrencySymbol = 'cryptocurrency_symbol';
  static const String transactionCryptocurrencyName = 'cryptocurrency_name';
  static const String transactionType = 'type';
  static const String transactionAmount = 'amount';

  static String get createCryptocurrenciesTableQuery =>
      "CREATE TABLE IF NOT EXISTS $cryptocurrenciesTableName($cryptocurrencyId TEXT PRIMARY KEY,"
      " $cryptocurrencySymbol TEXT,"
      " $cryptocurrencyName TEXT,"
      " $cryptocurrencyAmount REAL,"
      " $cryptocurrencyImage TEXT)";

  static String get createTransactionsTableQuery =>
      "CREATE TABLE IF NOT EXISTS $transactionsTableName($transactionId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      " $transactionCryptocurrencySymbol TEXT,"
      " $transactionCryptocurrencyName TEXT,"
      " $transactionType TEXT,"
      " $transactionAmount REAL)";
}
