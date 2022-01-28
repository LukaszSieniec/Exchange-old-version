import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/views/widgets/loading.dart';
import 'package:exchange/views/widgets/wallet/coins.dart';
import '../widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(MyLabels.accountBalance,
              style:
                  TextStyle(color: Color(MyColors.colorText), fontSize: 16.0)),
          const SizedBox(height: 4.0),
          Text('\$ $accountBalance',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24.0),
          Row(children: [
            const Expanded(child: Divider(height: 2, color: Colors.white)),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(MyLabels.coins,
                    style: TextStyle(color: Colors.white, fontSize: 16.0))),
            const Expanded(child: Divider(height: 2, color: Colors.white))
          ]),
          const SizedBox(height: 16.0),
          cryptocurrencies.isNotEmpty
              ? Coins(cryptocurrencies)
              : const Message(MyLabels.noCryptocurrencies)
        ]));
  }
}
