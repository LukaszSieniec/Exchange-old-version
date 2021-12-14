import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class BuyCryptocurrency extends StatelessWidget {
  const BuyCryptocurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MyColors.background),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: const Text('\$ 378.12',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)))),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
        body: SafeArea(
            child: Column(
                children: const [Divider(height: 2.0, color: Colors.white)])));
  }
}
