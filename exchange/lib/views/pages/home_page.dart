import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/home/cryptocurrency_item.dart';
import 'package:exchange/views/widgets/home/trending_item.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptocurrenciesBloc, CryptocurrenciesState>(
        builder: (context, state) {
      if (state is CryptocurrenciesLoadInProgress) {
        return buildLoading();
      } else if (state is CryptocurrenciesLoadSuccess) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(MyLabels.trending,
              style: TextStyle(
                  color: Color(MyColors.colorText),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          Expanded(
              flex: 3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.trending.length,
                  itemBuilder: (context, index) {
                    return TrendingItem(state.trending[index]);
                  })),
          const Text(MyLabels.cryptocurrencies,
              style: TextStyle(
                  color: Color(MyColors.colorText),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0)),
          Expanded(
              flex: 4,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.cryptocurrencies.length,
                  itemBuilder: (context, index) {
                    return CryptocurrencyItem(state.cryptocurrencies[index]);
                  }))
        ]);
      } else if (state is CryptocurrenciesLoadFailure) {
        return Container();
      }
      return Container();
    });
  }
}
