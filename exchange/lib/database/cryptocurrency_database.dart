import 'package:exchange/database/cryptocurrency_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CryptocurrencyDatabase {
  static final CryptocurrencyDatabase _instance =
      CryptocurrencyDatabase._internal();

  final CryptocurrenciesDao _cryptocurrenciesDao = CryptocurrenciesDao();

  static Database? _database;

  CryptocurrencyDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, 'cryptocurrencies.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database
        .execute(_cryptocurrenciesDao.createCryptocurrenciesTableQuery);
    await database.execute(_cryptocurrenciesDao.createTransactionsTableQuery);
  }

  Future<void> close() async {
    final Database database = await _instance.database;

    database.close();
  }

  //Cryptocurrencies
  Future<void> createCryptocurrency() async {}

  Future<void> readCryptocurrency() async {}

  Future<void> updateCryptocurrency() async {}

  Future<void> deleteCryptocurrency() async {}

  Future<void> readAllCryptocurrencies() async {}

  //Transactions
  Future<void> createTransactions() async {}

  Future<void> readTransactions() async {}

  Future<void> updateTransactions() async {}

  Future<void> deleteTransactions() async {}

  Future<void> readAllTransactions() async {}
}
