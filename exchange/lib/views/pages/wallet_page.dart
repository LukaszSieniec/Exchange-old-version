import 'package:exchange/blocs/wallet/wallet_bloc.dart';
import 'package:exchange/blocs/wallet/wallet_event.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/views/widgets/wallet/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WalletBloc>(context).add(WalletLoaded());

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      if (state is WalletLoadInProgress) {
        return _buildLoading();
      } else if (state is WalletLoadSuccess) {
        return _buildBody(state.cryptocurrencies);
      } else if (state is WalletLoadFailure) {}
      return Container();
    });
  }

  Widget _buildBody(List<Cryptocurrency> cryptocurrencies) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text('Account balance',
              style:
                  TextStyle(color: Color(MyColors.colorText), fontSize: 16.0)),
          const SizedBox(height: 4.0),
          const Text('\$ 378.12',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24.0),
          Row(children: [
            const Expanded(child: Divider(height: 2, color: Colors.white)),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text('Your Coins',
                    style: TextStyle(color: Colors.white, fontSize: 16.0))),
            const Expanded(child: Divider(height: 2, color: Colors.white))
          ]),
          const SizedBox(height: 16.0),
          cryptocurrencies.isNotEmpty
              ? Coins(cryptocurrencies)
              : _buildMessage()
        ]));
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildMessage() {
    return const Expanded(
        child: Center(
            child: Text('You don\'t have cryptocurrencies',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0))));
  }
}
