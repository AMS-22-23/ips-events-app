import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:ips_events_manager/widgets/texts/ips_events_texts.dart';

class DarkIconTextButton extends StatelessWidget {
  const DarkIconTextButton({
    required this.icon,
    required this.text,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 5,
        child: Container(
          color: darkBlack,
          padding: EventsEdgeInsets.all(EventsSize.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              IpsEventsText.lightBodyRegular(text),
            ],
          ),
        ),
      ),
    );
  }
}
