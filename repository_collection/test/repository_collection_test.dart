import 'package:core_components/core_components.dart';
import 'package:core_test_components/core_test_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repositories/repositories.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  final httpClient = MockHttpClient();
  setUp(() {
    setRepositoryCollectionMockHttpClient(httpClient);
    RepositoryCollection().init();
  });

  test('contains repositories instances', () {
    final sampleRepo = RepositoryCollection.instance
        .retrieve<GeolocationRepository>() as GeolocationRepository;
    expect(sampleRepo, isA<GeolocationRepository>());
  });
}
