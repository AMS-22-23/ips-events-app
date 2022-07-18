import 'package:core_components/core_components.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void changeTab(NavigationTab tab) {
    IpsEventsAnalytics.recordAnalytic(
      eventName: 'navigation_tab_changed',
      parameters: {'tab': tab},
    );

    emit(NavigationState(tabIndex: tab.index));
  }
}

enum NavigationTab { events, history, other1, other2 }
