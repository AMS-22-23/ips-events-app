import 'package:core_components/core_components.dart';

class RepositoryArchive extends Archiver<dynamic> {
  factory RepositoryArchive() => _instance;

  RepositoryArchive._default();
  static final _instance = RepositoryArchive._default();
  static RepositoryArchive get instance => _instance;
}
