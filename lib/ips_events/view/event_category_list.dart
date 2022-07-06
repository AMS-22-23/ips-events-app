import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EventCategoryList extends StatelessWidget {
  const EventCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.only(
        top: EventsSize.large,
        bottom: EventsSize.large,
        left: EventsSize.normal,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _EventCategoryItem(
            isSelected: true,
            categoryLabel: 'Tecnologia',
            icon: MdiIcons.laptop,
          ),
          SizedBox(
            width: 10,
          ),
          _EventCategoryItem(
            isSelected: false,
            categoryLabel: 'Saúde',
            icon: MdiIcons.medicalBag,
          ),
          SizedBox(
            width: 10,
          ),
          _EventCategoryItem(
            isSelected: false,
            categoryLabel: 'Tecnologia',
            icon: MdiIcons.accountCowboyHat,
          ),
          SizedBox(
            width: 10,
          ),
          _EventCategoryItem(
            isSelected: false,
            categoryLabel: 'Tecnologia',
            icon: MdiIcons.accountCowboyHat,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class _EventCategoryItem extends StatelessWidget {
  const _EventCategoryItem({
    required this.isSelected,
    required this.categoryLabel,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final String categoryLabel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
      child: Container(
        height: 40,
        color: isSelected ? darkGrey : Colors.white,
        child: EventsPadding(
          padding: EventsEdgeInsets.all(EventsSize.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: isSelected ? lightBlack : lightGrey,
                padding: EventsEdgeInsets.all(EventsSize.small),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : darkGrey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                categoryLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : darkGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
