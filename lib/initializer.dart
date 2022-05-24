import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/app/app.dart';
import 'package:repositories/repositories.dart';

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized(); //needed to init easy_localizations
  await LocalizationsSdk.initLocalization(); //init localizations
  RepositoryCollection().init(); //init repository collection

  final AuthenticationRepository authenticationRepository =
      RepositoryCollection.instance.retrieve<AuthenticationRepository>();

  return LocalizationsSdk.localizedApp(
    child: const App(),
  );
}
