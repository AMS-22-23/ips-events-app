import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({
    required this.eventName,
    required this.date,
    required this.speakerName,
    required this.description,
    required this.vacancies,
    required this.filledVacancies,
    Key? key,
  }) : super(key: key);

  final String eventName;
  final DateTime date;
  final String speakerName;
  final String description;
  final int vacancies;
  final int filledVacancies;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes de Evento',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeft,
            color: lightBlack,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: EventsPadding(
            padding: EventsEdgeInsets.symmetric(
              horizontal: EventsSize.normal,
            ),
            child: Column(
              children: [
                EventPanel(
                  eventName: eventName,
                  date: date,
                  speakerName: speakerName,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
