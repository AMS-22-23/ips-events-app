import 'package:core_components/core_components.dart';

class EventsAdminApp extends StatefulWidget {
  const EventsAdminApp({Key? key}) : super(key: key);

  @override
  State<EventsAdminApp> createState() => _EventsAdminAppState();
}

class _EventsAdminAppState extends State<EventsAdminApp>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Some Web app bar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: const [
          Center(
            child: Text(
              'some web app',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
