import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/app/app.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized(); //needed to init easy_localizations
  await LocalizationsSdk.initLocalization(); //init localizations
  RepositoryCollection().init(); //init repository collection

  return LocalizationsSdk.localizedApp(
    child: const App(),
  );
}
