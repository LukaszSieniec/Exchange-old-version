import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:exchange/views/widgets/wallet/coins.dart';
import '../widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state.walletStatus == WalletStatus.loading) {
        return buildLoading();
      } else if (state.walletStatus == WalletStatus.success) {
        return _buildWalletBody(state.cryptocurrencies, state.accountBalance!);
      } else {
        return Container();
      }
    });
  }

  Widget _buildWalletBody(
      List<Cryptocurrency> cryptocurrencies, double accountBalance) {
    return Container(
        margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical * 1.15,
            left: SizeConfig.blockSizeHorizontal * 2.25,
            right: SizeConfig.blockSizeHorizontal * 2.25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(MyLabels.accountBalance,
              style: TextStyle(
                  color: const Color(MyColors.colorText),
                  fontSize: SizeConfig.blockSizeVertical * 2.25)),
          SizedBox(height: SizeConfig.blockSizeVertical * 0.55),
          Text('\$ $accountBalance',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.blockSizeVertical * 4.50,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: SizeConfig.blockSizeVertical * 3.35),
          Row(children: [
            Expanded(
                child: Divider(
                    height: SizeConfig.blockSizeVertical * 0.30,
                    color: Colors.white)),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4.45),
                child: Text(MyLabels.coins,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2.25))),
            Expanded(
                child: Divider(
                    height: SizeConfig.blockSizeVertical * 0.30,
                    color: Colors.white))
          ]),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.25),
          cryptocurrencies.isNotEmpty
              ? Coins(cryptocurrencies)
              : const Message(MyLabels.noCryptocurrencies)
        ]));
  }
}
