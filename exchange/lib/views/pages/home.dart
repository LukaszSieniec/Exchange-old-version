import 'package:exchange/constants/colors.dart';
import 'package:exchange/views/widgets/home/coin_item.dart';
import 'package:exchange/views/widgets/home/trending_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    topLeft: Radius.circular(32.0)),
                boxShadow: [
                  BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 4)
                ]),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                child: BottomNavigationBar(
                    unselectedItemColor: Colors.grey[400],
                    selectedItemColor: Colors.white,
                    backgroundColor: const Color(MyColors.background),
                    elevation: 8,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.attach_money), label: 'Wallet'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.history), label: 'Transactions'),
                    ]))),
        body: SafeArea(
            top: true,
            child: Container(
                margin: const EdgeInsets.only(
                    top: 16.0, left: 12.0, right: 12.0, bottom: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Trending',
                          style: TextStyle(
                              color: Color(MyColors.homeColorText),
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
                      const Text('Cryptocurrencies',
                          style: TextStyle(
                              color: Color(MyColors.homeColorText),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                      Expanded(
                          flex: 4,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return const CoinItem();
                              }))
                    ]))));
  }
}
