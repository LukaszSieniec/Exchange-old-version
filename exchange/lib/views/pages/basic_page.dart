import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/cubit/bottom_navigation_bar_cubit.dart';
import 'package:exchange/cubit/bottom_navigation_bar_state.dart';
import 'package:exchange/utils/size_config.dart';
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
    SizeConfig.init(context);
    final AppTab selectedTab =
        context.select((AppTabCubit cubit) => cubit.state.appTab);
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(SizeConfig.blockSizeVertical * 4.50), topLeft: Radius.circular(SizeConfig.blockSizeVertical * 4.50)),
                boxShadow: const [
                  BoxShadow(color: Colors.white, spreadRadius: 1, blurRadius: 4)
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(SizeConfig.blockSizeVertical * 4.50),
                    topRight:
                        Radius.circular(SizeConfig.blockSizeVertical * 4.50)),
                child: BottomNavigationBar(
                    currentIndex: selectedTab.index,
                    onTap: (index) => context
                        .read<AppTabCubit>()
                        .setAppTab(AppTab.values[index]),
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
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2.25,
                    left: SizeConfig.blockSizeHorizontal * 3.35,
                    right: SizeConfig.blockSizeHorizontal * 3.35,
                    bottom: SizeConfig.blockSizeVertical * 2.25),
                child: IndexedStack(index: selectedTab.index, children: const [HomePage(), WalletPage(), TransactionsPage()]))));
  }
}
