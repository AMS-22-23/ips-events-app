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
        Entry<AuthenticationRepository>(
          builder: () => AuthenticationRepository(),
        ),
      )
      ..archive(
        Entry<GeolocationRepository>(
          builder: () => GeolocationRepository(),
        ),
      );
  }
}
