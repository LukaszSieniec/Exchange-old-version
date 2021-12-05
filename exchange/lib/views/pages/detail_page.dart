import 'package:exchange/blocs/market_chart/market_chart_bloc.dart';
import 'package:exchange/blocs/market_chart/market_chart_event.dart';
import 'package:exchange/blocs/market_chart/market_chart_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/views/widgets/detail/cryptocurrency_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DetailPage extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  const DetailPage(this.cryptocurrency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MarketChartBloc>(context)
        .add(MarketChartLoaded(cryptocurrency.id));

    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        body: SafeArea(
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(children: [
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
                        Column(children: [
                          Text('${cryptocurrency.priceChangePercentage24h}',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 18.0)),
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
                                          if (state
                                              is MarketChartStateLoadInProgress) {
                                            return _buildLoading();
                                          } else if (state
                                              is MarketChartLoadSuccess) {
                                            return SfSparkAreaChart.custom(
                                                borderColor: Colors.green,
                                                color: const Color(
                                                    MyColors.background),
                                                dataCount: state.marketChartData
                                                    .prices.length,
                                                xValueMapper: (index) => state
                                                    .marketChartData
                                                    .prices[index][0],
                                                yValueMapper: (index) => state
                                                    .marketChartData
                                                    .prices[index][1],
                                                axisLineWidth: 0);
                                          } else if (state
                                              is MarketChartLoadFailure) {}
                                          return Container();
                                        }))),
                                DefaultTabController(
                                    length: 6,
                                    initialIndex: 0,
                                    child: TabBar(
                                        indicator: const UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                                width: 3.0,
                                                color: Color(MyColors.orange)),
                                            insets: EdgeInsets.symmetric(
                                                horizontal: 16.0)),
                                        onTap: (index) =>
                                            BlocProvider.of<MarketChartBloc>(
                                                    context)
                                                .add(MarketChartUpdated(
                                                    cryptocurrency.id, index)),
                                        tabs: [
                                          _buildTimeButton(MyLabels.day),
                                          _buildTimeButton(MyLabels.week),
                                          _buildTimeButton(MyLabels.month),
                                          _buildTimeButton(
                                              MyLabels.threeMonths),
                                          _buildTimeButton(MyLabels.sixMonths),
                                          _buildTimeButton(MyLabels.year)
                                        ]))
                              ])))),
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: CryptocurrencySummary(cryptocurrency),
                      )),
                  _buildBuyButton(),
                  const SizedBox(height: 8.0)
                ]))));
  }

  Widget _buildBuyButton() {
    return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: Colors.green),
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: Text('BUY ${cryptocurrency.name.toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            )));
  }

  Widget _buildTimeButton(String text) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}