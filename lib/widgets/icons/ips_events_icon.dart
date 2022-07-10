import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/theme.dart';

class DarkIcon extends Icon {
  DarkIcon(IconData? icon, {double? size, Key? key})
      : super(
          icon,
          color: darkBlack,
          size: size,
          key: key,
        );
}
