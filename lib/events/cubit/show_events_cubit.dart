import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_events_state.dart';

class ShowEventsCubit extends Cubit<ShowEventsState> {
  ShowEventsCubit() : super(ShowEventsInitial());
}
