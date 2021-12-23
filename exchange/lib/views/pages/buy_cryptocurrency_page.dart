import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/models/cryptocurrency_response.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/confirm_button.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard.dart';
import 'package:exchange/views/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyCryptocurrencyPage extends StatelessWidget {
  final CryptocurrencyResponse cryptocurrency;

  const BuyCryptocurrencyPage(this.cryptocurrency, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: BlocProvider.of<BuyCryptocurrenciesBloc>(context),
        listener: (context, state) {
          if (state is BuyCryptocurrenciesLoadFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(PrimarySnackBar(title: Messages.notEnoughFunds));
          }
        },
        builder: (context, state) {
          return BlocBuilder<BuyCryptocurrenciesBloc, BuyCryptocurrenciesState>(
              builder: (context, state) {
            if (state is BuyCryptocurrenciesLoadInProgress) {
              return _buildLoading();
            } else if (state is BuyCryptocurrenciesInitial) {
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
                                      'Balance: ${state.accountBalance}',
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
                        Text('${state.amount} \$',
                            style: const TextStyle(
                                fontSize: 48.0, color: Colors.white)),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: 16.0, left: 8.0, right: 8.0),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Estimated ${cryptocurrency.symbol.toUpperCase()}: ',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Color(MyColors.colorText))),
                                    Text('${state.estimatedQuantity}',
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ]),
                              const SizedBox(height: 16.0),
                              const Keyboard(),
                              const SizedBox(height: 32.0),
                              const ConfirmButton()
                            ]))
                      ]));
            }
            return Container();
          });
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
