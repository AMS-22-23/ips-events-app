import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void changeTab(NavigationTab tab) {
    emit(NavigationState(tabIndex: tab.index));
  }
}

enum NavigationTab { events, history, other1, other2 }
