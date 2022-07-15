import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/events_repository/src/models/event.dart';
import 'package:repositories/src/events_repository/src/models/event_preview.dart';
import 'package:repositories/src/models/model_listing.dart';

part 'events_repository.g.dart';

@RestApi()
abstract class EventsRepository {
  factory EventsRepository(Dio dio, {String baseUrl}) = _EventsRepository;

  @GET('/event')
  Future<ModelListing<EventPreview>> getEvents({
    @Query('search') String? search,
    @Query('start_date') String? startDateString,
    @Query('end_date') String? endDateString,
    @Query('category_id') String? categoryId,
    @Query('is_online') bool? isOnline,
    @Query('is_open_door') bool? isOpenDoor,
    @Query('limit') int limit = 25,
    @Query('sort_field ') String? sortingField,
    @Query('sort_ascending ') bool? sortAscending = false,
    @Query('next') String? nextPageCursor,
    @Query('previous') String? previousPageCursor,
  });

  @POST('/event')
  Future<Event> createEvent({
    @Body() required Event event,
  });
}
