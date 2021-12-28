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
  static const String transactionCryptocurrencyId = 'cryptocurrency_id';
  static const String transactionCryptocurrencySymbol = 'cryptocurrency_symbol';
  static const String transactionCryptocurrencyName = 'cryptocurrency_name';
  static const String transactionType = 'type';
  static const String transactionDate = 'date';
  static const String transactionCryptocurrencyImage = 'image';
  static const String transactionAmount = 'amount';
  static const String transactionCryptocurrencyPrice = 'cryptocurrency_price';

  static String get createCryptocurrenciesTableQuery =>
      "CREATE TABLE IF NOT EXISTS $cryptocurrenciesTableName($cryptocurrencyId TEXT PRIMARY KEY,"
      " $cryptocurrencySymbol TEXT,"
      " $cryptocurrencyName TEXT,"
      " $cryptocurrencyAmount REAL,"
      " $cryptocurrencyImage TEXT)";

  static String get createTransactionsTableQuery =>
      "CREATE TABLE IF NOT EXISTS $transactionsTableName($transactionId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      " $transactionCryptocurrencyId TEXT,"
      " $transactionCryptocurrencySymbol TEXT,"
      " $transactionCryptocurrencyName TEXT,"
      " $transactionType TEXT,"
      " $transactionDate TEXT,"
      " $transactionCryptocurrencyImage TEXT,"
      " $transactionAmount REAL,"
      " $transactionCryptocurrencyPrice REAL)";
}
