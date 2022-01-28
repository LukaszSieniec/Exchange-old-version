import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/blocs/market_chart/market_chart_bloc.dart';
import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/views/widgets/detail/buy_button.dart';
import 'package:exchange/views/widgets/detail/cryptocurrency_summary.dart';
import 'package:exchange/views/widgets/detail/time_button.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'buy_cryptocurrency_page.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MarketChartBloc>().add(MarketChartFetched(id));
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        body: SafeArea(
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: BlocBuilder<CryptocurrenciesBloc, CryptocurrenciesState>(
                    builder: (context, state) {
                  final CryptocurrencyResponse cryptocurrency = state
                      .cryptocurrencies
                      .firstWhere((element) => element.id == id);
                  return Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.network(cryptocurrency.image, height: 40.0),
                            const SizedBox(width: 6.0),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cryptocurrency.symbol.toUpperCase(),
                                      style: const TextStyle(
                                          color: Color(MyColors.colorText),
                                          fontSize: 18.0)),
                                  Text(cryptocurrency.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold))
                                ])
                          ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    '${cryptocurrency.priceChangePercentage24h}',
                                    style: TextStyle(
                                        color: _getColor(cryptocurrency
                                            .priceChangePercentage24h),
                                        fontSize: 18.0)),
                                Text('\$${cryptocurrency.currentPrice}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold))
                              ])
                        ]),
                    Expanded(
                        flex: 3,
                        child: Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.white10, width: 1),
                                    borderRadius: BorderRadius.circular(16.0)),
                                elevation: 2,
                                color: const Color(MyColors.brighterBackground),
                                child: Column(children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: BlocBuilder<MarketChartBloc,
                                                  MarketChartState>(
                                              builder: (context, state) {
                                            if (state.marketChartStatus ==
                                                MarketChartStatus.loading) {
                                              return buildLoading();
                                            } else if (state
                                                    .marketChartStatus ==
                                                MarketChartStatus.success) {
                                              return SfSparkAreaChart.custom(
                                                  borderColor: Colors.green,
                                                  color: const Color(
                                                      MyColors.background),
                                                  dataCount: state
                                                      .marketChartData
                                                      ?.prices
                                                      .length,
                                                  xValueMapper: (index) => state
                                                      .marketChartData
                                                      ?.prices[index][0],
                                                  yValueMapper: (index) => state
                                                      .marketChartData
                                                      ?.prices[index][1],
                                                  axisLineWidth: 0);
                                            } else if (state
                                                    .marketChartStatus ==
                                                MarketChartStatus.failure) {}
                                            return Container();
                                          }))),
                                  DefaultTabController(
                                      length: 6,
                                      initialIndex: 0,
                                      child: TabBar(
                                          indicator:
                                              const UnderlineTabIndicator(
                                                  borderSide: BorderSide(
                                                      width: 3.0,
                                                      color: Color(
                                                          MyColors.orange)),
                                                  insets: EdgeInsets.symmetric(
                                                      horizontal: 16.0)),
                                          onTap: (index) => context
                                              .read<MarketChartBloc>()
                                              .add(MarketChartUpdated(
                                                  cryptocurrency.id, index)),
                                          tabs: const [
                                            TimeButton(MyLabels.day),
                                            TimeButton(MyLabels.week),
                                            TimeButton(MyLabels.month),
                                            TimeButton(MyLabels.threeMonths),
                                            TimeButton(MyLabels.sixMonths),
                                            TimeButton(MyLabels.year)
                                          ]))
                                ])))),
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: CryptocurrencySummary(cryptocurrency),
                        )),
                    BuyButton(cryptocurrency),
                    const SizedBox(height: 8.0)
                  ]);
                }))));
  }

  Color _getColor(num value) => value > 0 ? Colors.green : Colors.red;
}
