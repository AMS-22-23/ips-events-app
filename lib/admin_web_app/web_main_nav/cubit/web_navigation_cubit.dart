import 'package:core_components/core_components.dart';

part 'web_navigation_state.dart';

class WebNavigationCubit extends Cubit<WebNavigationState> {
  WebNavigationCubit() : super(const WebNavigationState());

  void changeTab(NavigationTab tab) {
    IpsEventsAnalytics.recordAnalytic(
      eventName: 'web_navigation_tab_changed',
      parameters: {'tab': tab},
    );

    emit(WebNavigationState(tabIndex: tab.index));
  }
}

enum NavigationTab { users, categories }
