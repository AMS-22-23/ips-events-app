import 'package:core_components/core_components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ips_events_manager/app/app.dart';
import 'package:ips_events_manager/firebase_options.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized(); //needed to init easy_localizations
  await LocalizationsSdk.initLocalization(); //init localizations

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  RepositoryCollection().init(); //init repository collection

  return LocalizationsSdk.localizedApp(
    child: const App(),
  );
}
