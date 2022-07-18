import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_attendance/cubit/event_attendance_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/texts/ips_events_texts.dart';

class EventAttendancePage extends StatelessWidget {
  const EventAttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(LocaleKeys.attendanceBeacon),
          style: const TextStyle(
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
      body: BlocBuilder<EventAttendanceCubit, EventAttendanceState>(
        builder: (context, state) {
          if (state is EventAttendanceInitializing) {
            return Center(
              child: SpinKitCubeGrid(
                color: lightBlack,
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(state),
                const SizedBox(height: 20),
                ..._buildText(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(EventAttendanceState state) {
    switch (state.runtimeType) {
      case EventAttendanceAdvertising:
        return const Icon(
          MdiIcons.cellphoneNfc,
          color: Colors.green,
          size: 200,
        );
      case EventAttendanceBluetoothOff:
        return const Icon(
          MdiIcons.bluetoothOff,
          size: 200,
        );
      case EventAttendanceLocationOff:
        return const Icon(
          MdiIcons.mapMarkerOff,
          size: 200,
        );
      default:
        return const Icon(
          MdiIcons.cellphoneNfcOff,
          size: 200,
        );
    }
  }

  List<Widget> _buildText(EventAttendanceState state) {
    if (state is EventAttendanceAdvertising) {
      return [
        IpsEventsText.iconLabel(
          t(LocaleKeys.beaconScreenInfo),
        ),
        const SizedBox(height: 20),
        Text(
          'UUID: ${state.uuid}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ];
    }

    switch (state.runtimeType) {
      case EventAttendanceBluetoothOff:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.needActivateBluetooth),
          )
        ];
      case EventAttendanceLocationOff:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.needLocalizationPermission),
          )
        ];
      case EventAttendanceNoPermission:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.noPermissionsForAttendance),
          )
        ];
      case EventAttendanceNotSupported:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.noBeaconSupport),
          )
        ];
      case EventAttendanceError:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.errorOcurred),
          )
        ];
      default:
        return [
          IpsEventsText.iconLabel(
            t(LocaleKeys.functionalityNotInitialized),
          )
        ];
    }
  }
}
