import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/attendances_repository/src/models/event_attendance.dart';

part 'attendances_repository.g.dart';

@RestApi()
abstract class EventAttendanceRepository {
  factory EventAttendanceRepository(Dio dio, {String baseUrl}) =
      _EventAttendanceRepository;

  @POST('/event/{eventId}/attendee')
  Future<void> addAttendee({
    @Path('eventId') required String eventId,
  });

  @GET('/event/{eventId}/attendee')
  Future<List<EventAttendance>> getEventAttendees({
    @Path('eventId') required String eventId,
  });
}
