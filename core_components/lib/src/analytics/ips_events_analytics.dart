import 'package:firebase_analytics/firebase_analytics.dart';

class IpsEventsAnalytics {
  static void recordAnalytic({
    required String eventName,
    Map<String, Object?>? parameters,
  }) {
    FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
