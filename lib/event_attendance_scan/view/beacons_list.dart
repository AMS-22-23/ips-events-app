import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/event_attendance_scan/cubit/event_attendance_scan_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/widgets.dart';

class BeaconsList extends StatelessWidget {
  const BeaconsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.symmetric(
        horizontal: EventsSize.normal,
      ),
      child: BlocBuilder<EventAttendanceScanCubit, EventAttendanceScanState>(
        builder: (context, state) {
          if (state is EventAttendanceScanInitializing) {
            return Center(
              child: SpinKitCubeGrid(
                color: lightBlack,
              ),
            );
          }

          if (state is! EventAttendanceScanMonitoring) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(state),
                  const SizedBox(height: 20),
                  _buildText(state),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildIcon(EventAttendanceScanState state) {
    switch (state.runtimeType) {
      case EventAttendanceScanBluetoothOff:
        return const Icon(
          MdiIcons.bluetoothOff,
          size: 200,
        );
      case EventAttendanceScanLocationOff:
        return const Icon(
          MdiIcons.mapMarkerOff,
          size: 200,
        );
      default:
        return const Icon(
          MdiIcons.cellphoneNfcOff,
          color: Colors.red,
          size: 200,
        );
    }
  }

  Widget _buildText(EventAttendanceScanState state) {
    switch (state.runtimeType) {
      case EventAttendanceScanBluetoothOff:
        return IpsEventsText.iconLabel(
          'Necessário ativar o Bluetooth para utilizar esta funcionalidade.',
        );
      case EventAttendanceScanLocationOff:
        return IpsEventsText.iconLabel(
          'Necessário ativar a Localização para utilizar esta funcionalidade.',
        );
      case EventAttendanceScanNoPermission:
        return IpsEventsText.iconLabel(
          'O  dispositivo não tem as permissões necessárias para utilizar esta funcionalidade.',
        );
      case EventAttendanceScanError:
        return IpsEventsText.iconLabel(
          'Ocorreu um erro, por favor tente novamente.',
        );
      default:
        return IpsEventsText.iconLabel(
          'Funcionalidade não inicializada.',
        );
    }
  }
}
