import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmButton extends StatelessWidget {
  final String mode;

  const ConfirmButton(this.mode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => mode == MyLabels.buyMode
            ? BlocProvider.of<BuyCryptocurrencyBloc>(context)
                .add(const BuyCryptocurrencyConfirmed())
            : BlocProvider.of<SellCryptocurrencyBloc>(context)
                .add(const SellCryptocurrencyConfirmed()),
        style: OutlinedButton.styleFrom(
            elevation: 4.0,
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: const Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: SizedBox(
                width: double.infinity,
                child: Text('Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))));
  }
}
