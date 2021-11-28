import 'package:exchange/constants/my_constants.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(MyColors.background),
            body: Container(
                margin: const EdgeInsets.only(
                    top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Total balance',
                        style: TextStyle(
                            color: Color(MyColors.colorText), fontSize: 16.0),
                      ),
                      SizedBox(height: 4.0),
                      Text('\$378.12',
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.0)),
                      SizedBox(height: 16.0),
                      Divider(color: Colors.white, height: 2.0),
                      SizedBox(height: 16.0),
                      Text(
                        'Your Coins',
                        style: TextStyle(
                            color: Color(MyColors.colorText), fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                    ]))));
  }
}
