import 'package:exchange/database/cryptocurrency_dao.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/models/transaction.dart' as cryptocurrency;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CryptocurrencyDatabase {
  static final CryptocurrencyDatabase _instance =
      CryptocurrencyDatabase._internal();

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
        .execute(CryptocurrenciesDao.createCryptocurrenciesTableQuery);
    await database.execute(CryptocurrenciesDao.createTransactionsTableQuery);
  }

  Future<void> close() async {
    final Database database = await _instance.database;

    database.close();
  }

  Future<void> createCryptocurrency(Cryptocurrency cryptocurrency) async {
    final database = await _instance.database;
    database.insert(
        CryptocurrenciesDao.cryptocurrenciesTableName, cryptocurrency.toJson());
  }

  Future<Cryptocurrency> readCryptocurrency(String id) async {
    final database = await _instance.database;

    final List<Map<String, dynamic>> maps = await database.query(
        CryptocurrenciesDao.cryptocurrenciesTableName,
        where: '${CryptocurrenciesDao.cryptocurrencyId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Cryptocurrency.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<void> updateCryptocurrency(Cryptocurrency cryptocurrency) async {
    final database = await _instance.database;

    database.update(
      CryptocurrenciesDao.cryptocurrenciesTableName,
      cryptocurrency.toJson(),
      where: '${CryptocurrenciesDao.cryptocurrencyId} = ?',
      whereArgs: [cryptocurrency.id],
    );
  }

  Future<void> deleteCryptocurrency(String id) async {
    final database = await _instance.database;

    database.delete(
      CryptocurrenciesDao.cryptocurrenciesTableName,
      where: '${CryptocurrenciesDao.cryptocurrencyId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Cryptocurrency>> readAllCryptocurrencies() async {
    final database = await _instance.database;

    final List<Map<String, dynamic>> maps =
        await database.query(CryptocurrenciesDao.cryptocurrenciesTableName);

    return maps.map((json) => Cryptocurrency.fromJson(json)).toList();
  }

  //Transactions
  Future<void> createTransactions(
      cryptocurrency.Transaction transaction) async {
    final database = await _instance.database;

    database.insert(
        CryptocurrenciesDao.transactionsTableName, transaction.toJson());
  }

  Future<cryptocurrency.Transaction> readTransactions(int id) async {
    final database = await _instance.database;

    final List<Map<String, dynamic>> maps = await database.query(
        CryptocurrenciesDao.transactionsTableName,
        where: '${CryptocurrenciesDao.transactionId} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return cryptocurrency.Transaction.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<void> updateTransactions(
      cryptocurrency.Transaction transaction) async {
    final database = await _instance.database;

    database.update(
      CryptocurrenciesDao.transactionsTableName,
      transaction.toJson(),
      where: '${CryptocurrenciesDao.transactionId} = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> deleteTransactions(String id) async {
    final database = await _instance.database;

    database.delete(
      CryptocurrenciesDao.transactionsTableName,
      where: '${CryptocurrenciesDao.transactionId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<cryptocurrency.Transaction>> readAllTransactions() async {
    final database = await _instance.database;

    final List<Map<String, dynamic>> maps =
        await database.query(CryptocurrenciesDao.transactionsTableName);

    return maps
        .map((json) => cryptocurrency.Transaction.fromJson(json))
        .toList();
  }
}
