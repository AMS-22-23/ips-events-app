import 'package:core_components/core_components.dart';
import 'package:meta_components/meta_components.dart';
import 'package:meta_components/src/meta_collection/meta_archiver.dart';

class MetaCollection {
  static final instance = MetaArchive.instance;
  late PtBrandHttpCLient? _httpCLient;
  late GlobalKey<NavigatorState> _navigatorLey;

  Archiver initDev() {
    _initDependencies();
    return instance
      ..archive(
        Entry<AppCredentials>(
          builder: () => AppCredentials.development(),
        ),
      )
      ..archive(
        Entry<Dio>(
          builder: () => _httpCLient!.devDio,
        ),
      )
      ..archive(
        Entry<GlobalKey<NavigatorState>>(
          builder: () => _navigatorLey,
        ),
      )
      ..archive(
        Entry<AadConfig>(
          builder: () => AadConfig(navigatorKey: _navigatorLey),
        ),
      );
  }

  Archiver initIntegration() {
    _initDependencies();
    return instance
      ..archive(
        Entry<AppCredentials>(
          builder: () => AppCredentials.integration(),
        ),
      )
      ..archive(
        Entry<Dio>(
          builder: () => _httpCLient!.intDio,
        ),
      )
      ..archive(
        Entry<GlobalKey<NavigatorState>>(
          builder: () => _navigatorLey,
        ),
      )
      ..archive(
        Entry<AadConfig>(
          builder: () => AadConfig(navigatorKey: _navigatorLey),
        ),
      );
  }

  void _initDependencies() {
    instance.archive(
      Entry<FlutterSecureStorage>(
        builder: () => const FlutterSecureStorage(),
      ),
    );
    _httpCLient = PtBrandHttpCLient();
    _navigatorLey = GlobalKey<NavigatorState>();
  }
}
