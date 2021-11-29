import 'package:exchange/blocs/bottom_navigation_bar/bottom_navigation_bar_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarBloc extends Bloc<BottomNavigationBarEvent, AppTab> {
  BottomNavigationBarBloc() : super(AppTab.home) {
    on<BottomNavigationBarUpdated>(_updated);
  }

  void _updated(BottomNavigationBarUpdated event, Emitter<AppTab> emit) {
    if (event is BottomNavigationBarUpdated) {
      emit(event.tab);
    }
  }
}
