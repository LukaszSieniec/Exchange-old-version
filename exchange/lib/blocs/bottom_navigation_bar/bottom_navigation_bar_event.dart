import 'package:equatable/equatable.dart';

enum AppTab { home, wallet, transactions }

abstract class BottomNavigationBarEvent extends Equatable {
  const BottomNavigationBarEvent();
}

class BottomNavigationBarUpdated extends BottomNavigationBarEvent {
  final AppTab tab;

  const BottomNavigationBarUpdated(this.tab);

  @override
  List<Object> get props => [tab];
}
