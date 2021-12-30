import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/sell_cryptocurrency/sell_cryptocurrency_event.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/views/widgets/buy_cryptocurrency/keyboard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Keyboard extends StatelessWidget {
  final String mode;

  const Keyboard(this.mode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: MyLabels.keyboardLabels.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.0,
            crossAxisCount: 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0),
        itemBuilder: (context, index) => KeyboardButton(
            MyLabels.keyboardLabels[index],
            onPressed: (label) => mode == MyLabels.buyMode
                ? BlocProvider.of<BuyCryptocurrenciesBloc>(context)
                    .add(AmountBuyCryptocurrencyUpdated(label))
                : BlocProvider.of<SellCryptocurrencyBloc>(context)
                    .add(AmountSellCryptocurrencyUpdated(label))));
  }
}
