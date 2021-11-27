import 'package:flutter/material.dart';

class ExperimentPage extends StatelessWidget {
  const ExperimentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Experiment'),
        ),
        body: SafeArea(child: Column()));
  }
}

Widget getContainer(Widget child, Color color) {
  return Container(
    color: color,
    child: child,
  );
}
