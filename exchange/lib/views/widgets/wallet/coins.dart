import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/pages/sell_cryptocurrency_page.dart';
import 'package:flutter/material.dart';

class Coins extends StatelessWidget {
  final List<Cryptocurrency> cryptocurrencies;

  const Coins(this.cryptocurrencies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: cryptocurrencies.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SellCryptocurrencyPage(cryptocurrencies[index]))),
                  child: Card(
                      elevation: 4,
                      color: const Color(MyColors.brighterBackground),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3.35,
                              top: SizeConfig.blockSizeVertical * 1.70,
                              right: SizeConfig.blockSizeHorizontal * 3.35,
                              bottom: SizeConfig.blockSizeVertical * 1.70),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            SizeConfig.blockSizeVertical * 2.25,
                                        backgroundImage: NetworkImage(
                                            cryptocurrencies[index].image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  2.25),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                cryptocurrencies[index]
                                                    .symbol
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.80)),
                                            Text(cryptocurrencies[index].name,
                                                style: TextStyle(
                                                    color: const Color(
                                                        MyColors.colorText),
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.25))
                                          ])
                                    ]),
                                Text('${cryptocurrencies[index].amount}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.blockSizeVertical *
                                            2.80))
                              ]))));
            }));
  }
}
