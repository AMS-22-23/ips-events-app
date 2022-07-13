import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/colors.dart';

class IpsEventsText extends StatelessWidget {
  const IpsEventsText._({
    required this.text,
    this.fontSize,
    required this.color,
    this.fontWeight,
    Key? key,
  }) : super(key: key);

  factory IpsEventsText.title(String text) {
    return IpsEventsText._(
      text: text,
      fontSize: 20,
      color: darkBlack,
      fontWeight: FontWeight.w500,
    );
  }

  factory IpsEventsText.title2(String text) {
    return IpsEventsText._(
      text: text,
      fontSize: 16,
      color: darkBlack,
      fontWeight: FontWeight.w500,
    );
  }

  factory IpsEventsText.lightTitle(String text) {
    return IpsEventsText._(
      text: text,
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
  }

  factory IpsEventsText.lightTitle2(String text) {
    return IpsEventsText._(
      text: text,
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
  }

  factory IpsEventsText.subTitle(String text) {
    return IpsEventsText._(
      text: text,
      fontSize: 12,
      color: darkGrey,
      fontWeight: FontWeight.w600,
    );
  }

  factory IpsEventsText.darkBody(String text) {
    return IpsEventsText._(
      text: text,
      color: darkBlack,
      fontWeight: FontWeight.w600,
    );
  }

  factory IpsEventsText.greyBody(String text) {
    return IpsEventsText._(
      text: text,
      color: darkGrey,
      fontWeight: FontWeight.w400,
    );
  }

  factory IpsEventsText.lightBodyRegular(String text) {
    return IpsEventsText._(
      text: text,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
  }

  final double? fontSize;
  final String text;
  final Color color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
