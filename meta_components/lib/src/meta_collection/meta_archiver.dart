import 'package:core_components/core_components.dart';

class MetaArchive extends Archiver<dynamic> {
  factory MetaArchive() => _instance;

  MetaArchive._default();
  static final _instance = MetaArchive._default();
  static MetaArchive get instance => _instance;
}
