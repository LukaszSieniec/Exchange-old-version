import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmButton extends StatelessWidget {
  final String mode;

  const ConfirmButton(this.mode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return OutlinedButton(
        onPressed: () => mode == MyLabels.buyMode
            ? context
                .read<BuyCryptocurrencyBloc>()
                .add(const BuyCryptocurrencyConfirmed())
            : context
                .read<SellCryptocurrencyBloc>()
                .add(const SellCryptocurrencyConfirmed()),
        style: OutlinedButton.styleFrom(
            elevation: 4.0,
            shape: const StadiumBorder(),
            backgroundColor: const Color(MyColors.brighterBackground)),
        child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2.25,
                bottom: SizeConfig.blockSizeVertical * 2.25),
            child: SizedBox(
                width: double.infinity,
                child: Text(MyLabels.confirm,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2.80,
                        fontWeight: FontWeight.bold)))));
  }
}
