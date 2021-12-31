import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/confirm_button.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard.dart';
import 'package:exchange/views/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellCryptocurrencyPage extends StatelessWidget {
  final String id;

  const SellCryptocurrencyPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SellCryptocurrencyBloc>(context)
        .add(SellCryptocurrencyLoaded(id));

    return BlocConsumer<SellCryptocurrencyBloc, SellCryptocurrencyState>(
        listener: (context, state) {
          if (state is SellCryptocurrencyNotEnoughCryptocurrency) {
            ScaffoldMessenger.of(context).showSnackBar(
                PrimarySnackBar(title: Messages.notEnoughCryptocurrency));
          }else if (state is SellCryptocurrencyInvalidAmount) {
            ScaffoldMessenger.of(context)
                .showSnackBar(PrimarySnackBar(title: Messages.invalidAmount));
          }
        },
        bloc: BlocProvider.of<SellCryptocurrencyBloc>(context),
        builder: (context, state) {
          if (state is SellCryptocurrencyLoadInProgress) {
            return Scaffold(
                backgroundColor: const Color(MyColors.background),
                body: _buildLoading());
          } else if (state is SellCryptocurrencyInitial) {
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
                                child: Text('Balance: ${state.accountBalance}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold))))),
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop())),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Divider(height: 2.0, color: Colors.white),
                      Text(
                          '${state.amountCryptocurrency} ${state.cryptocurrency.symbol.toUpperCase()}',
                          style: const TextStyle(
                              fontSize: 48.0, color: Colors.white)),
                      Container(
                          margin: const EdgeInsets.only(
                              bottom: 16.0, left: 8.0, right: 8.0),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Estimated \$: ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(MyColors.colorText))),
                                  Text('${state.estimatedAmount}',
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ]),
                            const SizedBox(height: 16.0),
                            const Keyboard(MyLabels.sellMode),
                            const SizedBox(height: 32.0),
                            const ConfirmButton(MyLabels.sellMode)
                          ]))
                    ]));
          }
          return Container();
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
