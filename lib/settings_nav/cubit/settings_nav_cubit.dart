import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_nav_state.dart';

class SettingsNavCubit extends Cubit<SettingsNavState> {
  SettingsNavCubit() : super(SettingsNavInitial());
}
