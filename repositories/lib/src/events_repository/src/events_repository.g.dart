// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _EventsRepository implements EventsRepository {
  _EventsRepository(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ModelListing<EventPreview>> getEvents(
      {search,
      startDateString,
      endDateString,
      categoryId,
      isOnline,
      isOpenDoor,
      limit = 25,
      sortingField,
      sortAscending = false,
      nextPageCursor,
      previousPageCursor}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'search': search,
      r'start_date': startDateString,
      r'end_date': endDateString,
      r'category_id': categoryId,
      r'is_online': isOnline,
      r'is_open_door': isOpenDoor,
      r'limit': limit,
      r'sort_field ': sortingField,
      r'sort_ascending ': sortAscending,
      r'next': nextPageCursor,
      r'previous': previousPageCursor
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ModelListing<EventPreview>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/event',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ModelListing<EventPreview>.fromJson(
      _result.data!,
      (json) => EventPreview.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<Event> createEvent({required event}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(event.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Event>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/event',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Event.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
