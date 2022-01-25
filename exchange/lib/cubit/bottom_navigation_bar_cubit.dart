import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_bar_state.dart';

class AppTabCubit extends Cubit<AppTabState> {
  AppTabCubit() : super(const AppTabState());

  void setAppTab(AppTab tab) => emit(AppTabState(appTab: tab));
}
