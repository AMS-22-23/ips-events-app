import 'package:core_components/core_components.dart';
import 'package:meta_components/meta_components.dart';
import 'package:repositories/repositories.dart';
import 'package:repository_archive/repository_archive.dart';

@visibleForTesting
void setRepositoryCollectionMockHttpClient(Dio client) => Dio();

class RepositoryCollection {
  static final instance = RepositoryArchive.instance;

  Archiver init() {
    final httpClient = MetaCollection.instance.retrieve<Dio>() as Dio;
    instance.archive(
      Entry<PermissionsRepository>(
        builder: () => PermissionsRepository(),
      ),
    );

    return instance
      ..archive(
        Entry<AadAuthenticationRepository>(
          builder: () => AadAuthenticationRepository(),
        ),
      )
      ..archive(
        Entry<AuthenticationRepository>(
          builder: () => AuthenticationRepository(httpClient),
        ),
      )
      ..archive(
        Entry<GeolocationRepository>(
          builder: () => GeolocationRepository(),
        ),
      )
      ..archive(
        Entry<UserRepository>(
          builder: () => UserRepository(httpClient),
        ),
      )
      ..archive(
        Entry<EventsRepository>(
          builder: () => EventsRepository(httpClient),
        ),
      )
      ..archive(
        Entry<CategoriesRepository>(
          builder: () => CategoriesRepository(httpClient),
        ),
      )
      ..archive(
        Entry<EventAttendanceRepository>(
          builder: () => EventAttendanceRepository(httpClient),
        ),
      );
  }
}
