import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/home/cryptocurrency_item.dart';
import 'package:exchange/views/widgets/home/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return const TrendingItem();
              })),
      const Text(MyLabels.cryptocurrencies,
          style: TextStyle(
              color: Color(MyColors.colorText),
              fontWeight: FontWeight.bold,
              fontSize: 20.0)),
      Expanded(
          flex: 4,
          child: BlocBuilder<CryptocurrenciesBloc, CryptocurrenciesState>(
              builder: (context, state) {
            debugPrint('$state');

            if (state is CryptocurrenciesStateLoadInProgress) {
              return _buildLoading();
            } else if (state is CryptocurrenciesLoadSuccess) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CryptocurrencyItem();
                  });
            } else if (state is CryptocurrenciesLoadFailure) {
              return Container();
            }
            return Container();
          }))
    ]);
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
