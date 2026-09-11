import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeTab(int index) {
    if (index < 0 || index >= state.items.length) {
      return;
    }

    emit(state.copyWith(selectedIndex: index));
  }
}
