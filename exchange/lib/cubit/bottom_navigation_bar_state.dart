import 'package:equatable/equatable.dart';

enum AppTab { home, wallet, transactions }

class AppTabState extends Equatable {
  final AppTab appTab;

  const AppTabState({this.appTab = AppTab.home});

  @override
  List<Object> get props => [appTab];
}
