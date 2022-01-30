import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_bloc.dart';
import 'package:exchange/blocs/cryptocurrencies/cryptocurrencies_state.dart';
import 'package:exchange/blocs/market_chart/market_chart_bloc.dart';
import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/widgets/detail/buy_button.dart';
import 'package:exchange/views/widgets/detail/cryptocurrency_summary.dart';
import 'package:exchange/views/widgets/detail/time_button.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    context.read<MarketChartBloc>().add(MarketChartFetched(id));
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 1.15,
                    left: SizeConfig.blockSizeHorizontal * 2.25,
                    right: SizeConfig.blockSizeHorizontal * 2.25,
                    bottom: SizeConfig.blockSizeVertical * 1.15),
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
                            Image.network(cryptocurrency.image,
                                height: SizeConfig.blockSizeVertical * 5.60),
                            SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 1.65),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cryptocurrency.symbol.toUpperCase(),
                                      style: TextStyle(
                                          color:
                                              const Color(MyColors.colorText),
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.50)),
                                  Text(cryptocurrency.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  3.95,
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
                                        fontSize: SizeConfig.blockSizeVertical *
                                            2.50)),
                                Text('\$${cryptocurrency.currentPrice}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 3.95,
                                        fontWeight: FontWeight.bold))
                              ])
                        ]),
                    Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2.25),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.white10, width: 1),
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.blockSizeVertical * 2.25)),
                                elevation: 2,
                                color: const Color(MyColors.brighterBackground),
                                child: Column(children: [
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockSizeVertical *
                                                      1.15),
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
                                          indicator: UnderlineTabIndicator(
                                              borderSide: const BorderSide(
                                                  width: 3.0,
                                                  color:
                                                      Color(MyColors.orange)),
                                              insets: EdgeInsets.symmetric(
                                                  horizontal: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4.45)),
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
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2.25,
                              bottom: SizeConfig.blockSizeVertical * 2.25),
                          child: CryptocurrencySummary(cryptocurrency),
                        )),
                    BuyButton(cryptocurrency),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.15)
                  ]);
                }))));
  }

  Color _getColor(num value) => value > 0 ? Colors.green : Colors.red;
}
