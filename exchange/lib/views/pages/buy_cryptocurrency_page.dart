import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/loading.dart';
import '../widgets/confirm_button.dart';
import '../widgets/keyboard/keyboard.dart';
import 'package:exchange/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyCryptocurrencyPage extends StatelessWidget {
  final String id;

  const BuyCryptocurrencyPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BuyCryptocurrencyBloc>().add(BuyCryptocurrencyLoaded(id));
    return BlocConsumer<BuyCryptocurrencyBloc, BuyCryptocurrencyState>(
        bloc: BlocProvider.of<BuyCryptocurrencyBloc>(context),
        listener: (context, state) {
          if (state.buyCryptocurrencyStatus ==
              BuyCryptocurrencyStatus.notEnoughFunds) {
            ScaffoldMessenger.of(context)
                .showSnackBar(PrimarySnackBar(title: Messages.notEnoughFunds));
          } else if (state.buyCryptocurrencyStatus ==
              BuyCryptocurrencyStatus.invalidAmount) {
            ScaffoldMessenger.of(context)
                .showSnackBar(PrimarySnackBar(title: Messages.invalidAmount));
          } else if (state.buyCryptocurrencyStatus ==
              BuyCryptocurrencyStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(PrimarySnackBar(
                title: '${Messages.bought} ${state.cryptocurrency?.name}'));
          }
        },
        builder: (context, state) {
          return BlocBuilder<BuyCryptocurrencyBloc, BuyCryptocurrencyState>(
              builder: (context, state) {
            if (state.buyCryptocurrencyStatus ==
                BuyCryptocurrencyStatus.loading) {
              return buildLoading();
            } else if (state.buyCryptocurrencyStatus ==
                BuyCryptocurrencyStatus.initial) {
              return _buildBuyCryptocurrencyBody(state, context);
            }
            return Container();
          });
        });
  }

  Widget _buildBuyCryptocurrencyBody(
      BuyCryptocurrencyState state, BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: SafeArea(
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Text(
                            '${MyLabels.balance}: ${state.accountBalance}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))))),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop())),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(height: 2.0, color: Colors.white),
              Text('${state.currentAmountMoney} \$',
                  style: const TextStyle(fontSize: 48.0, color: Colors.white)),
              Container(
                  margin: const EdgeInsets.only(
                      bottom: 16.0, left: 8.0, right: 8.0),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                          '${MyLabels.estimated} ${state.cryptocurrencyResponse?.symbol.toUpperCase()}: ',
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: Color(MyColors.colorText))),
                      Text('${state.estimatedAmountCryptocurrency}',
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ]),
                    const SizedBox(height: 16.0),
                    const Keyboard(MyLabels.buyMode),
                    const SizedBox(height: 32.0),
                    const ConfirmButton(MyLabels.buyMode)
                  ]))
            ]));
  }
}
