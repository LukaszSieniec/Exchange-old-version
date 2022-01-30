import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_bloc.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_event.dart';
import 'package:exchange/blocs/buy_cryptocurrency/buy_cryptocurrency_state.dart';
import 'package:exchange/constants/my_constants.dart';
import 'package:exchange/utils/size_config.dart';
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
    SizeConfig.init(context);
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
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 2.25),
                        child: Text(
                            '${MyLabels.balance}: ${state.accountBalance}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeVertical * 2.80,
                                fontWeight: FontWeight.bold))))),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop())),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(
                  height: SizeConfig.blockSizeVertical * 0.30,
                  color: Colors.white),
              Text('${state.currentAmountMoney} \$',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 6.75,
                      color: Colors.white)),
              Container(
                  margin: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical * 2.25,
                      left: SizeConfig.blockSizeHorizontal * 2.25,
                      right: SizeConfig.blockSizeHorizontal * 2.25),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                          '${MyLabels.estimated} ${state.cryptocurrencyResponse?.symbol.toUpperCase()}: ',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2.25,
                              color: const Color(MyColors.colorText))),
                      Text('${state.estimatedAmountCryptocurrency}',
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 2.80,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ]),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2.25),
                    const Keyboard(MyLabels.buyMode),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4.50),
                    const ConfirmButton(MyLabels.buyMode)
                  ]))
            ]));
  }
}
