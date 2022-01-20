import 'package:exchange/blocs/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_event.dart';
import 'package:exchange/database/cryptocurrency_database.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:exchange/services/cryptocurrency_service.dart';
import 'package:exchange/views/pages/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'blocs/transactions/transactions_bloc.dart';
import 'database/account_balance.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await AccountBalance.init();
  print('Example!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavigationBarBloc()),
          BlocProvider(
              create: (context) => CryptocurrenciesBloc(
                  CryptocurrencyRepository(
                      CryptocurrencyService(), CryptocurrencyDatabase.get))
                ..add(CryptocurrenciesFetched())),
          BlocProvider(
              create: (context) => MarketChartBloc(CryptocurrencyRepository(
                  CryptocurrencyService(), CryptocurrencyDatabase.get))),
          BlocProvider(
              create: (context) => BuyCryptocurrencyBloc(
                  BlocProvider.of<CryptocurrenciesBloc>(context),
                  CryptocurrencyRepository(
                      CryptocurrencyService(), CryptocurrencyDatabase.get))),
          BlocProvider(
              create: (context) => WalletBloc(
                  CryptocurrencyRepository(
                      CryptocurrencyService(), CryptocurrencyDatabase.get),
                  BlocProvider.of<BuyCryptocurrencyBloc>(context))
                ..add(WalletLoaded())),
          BlocProvider(
              create: (context) => SellCryptocurrencyBloc(
                  CryptocurrencyRepository(
                      CryptocurrencyService(), CryptocurrencyDatabase.get),
                  BlocProvider.of<WalletBloc>(context))),
          BlocProvider(
              create: (context) => TransactionsBloc(CryptocurrencyRepository(
                  CryptocurrencyService(), CryptocurrencyDatabase.get)))
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const BasicPage()));
  }
}
