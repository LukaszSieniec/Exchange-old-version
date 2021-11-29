import 'package:exchange/blocs/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:exchange/blocs/bottom_navigation_bar/bottom_navigation_bar_event.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/pages/transactions_page.dart';
import 'package:exchange/views/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, AppTab>(
        builder: (context, state) {
      return Scaffold(
          backgroundColor: const Color(MyColors.background),
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32.0),
                      topLeft: Radius.circular(32.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white, spreadRadius: 1, blurRadius: 4)
                  ]),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  child: BottomNavigationBar(
                      currentIndex: state.index,
                      onTap: (index) =>
                          BlocProvider.of<BottomNavigationBarBloc>(context).add(
                              BottomNavigationBarUpdated(AppTab.values[index])),
                      unselectedItemColor: Colors.grey[400],
                      selectedItemColor: Colors.white,
                      backgroundColor: const Color(MyColors.background),
                      elevation: 8,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: MyLabels.home),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.attach_money),
                            label: MyLabels.wallet),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.history),
                            label: MyLabels.transactions)
                      ]))),
          body: SafeArea(
              child: Container(
                  margin: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0, bottom: 12.0),
                  child: _buildBody(state))));
    });
  }

  Widget _buildBody(AppTab state) {
    switch (state) {
      case AppTab.home:
        return const HomePage();
      case AppTab.wallet:
        return const WalletPage();
      case AppTab.transactions:
        return const TransactionsPage();
      default:
        return Container();
    }
  }
}
