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
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(children: [
                  const Text('Welcome to Dinero!',
                      style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  Expanded(
                      flex: 2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return const TrendingItem();
                          })),
                  Expanded(
                      flex: 3,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const CoinItem();
                          }))
                ]))));
  }
}
