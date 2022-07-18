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
        title: const Text(
          'Beacon de Presenças',
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
          'Mantenha este ecrã ativo para permitir os participantes registarem presenças.',
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
            'Necessário ativar o Bluetooth para utilizar esta funcionalidade.',
          )
        ];
      case EventAttendanceLocationOff:
        return [
          IpsEventsText.iconLabel(
            'Necessário ativar a Localização para utilizar esta funcionalidade.',
          )
        ];
      case EventAttendanceNoPermission:
        return [
          IpsEventsText.iconLabel(
            'O  dispositivo não tem as permissões necessárias para utilizar esta funcionalidade.',
          )
        ];
      case EventAttendanceNotSupported:
        return [
          IpsEventsText.iconLabel(
            'O seu dispositivo não suporta esta funcionalidade. Necessário pelo menos Android 5.0 e um dispositivo que suporte BLE.',
          )
        ];
      case EventAttendanceError:
        return [
          IpsEventsText.iconLabel(
            'Ocorreu um erro, por favor tente novamente.',
          )
        ];
      default:
        return [
          IpsEventsText.iconLabel(
            'Funcionalidade não inicializada.',
          )
        ];
    }
  }
}
