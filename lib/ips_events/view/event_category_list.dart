import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/utils/show_snackbars.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';

class EventCategoryList extends StatelessWidget {
  const EventCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EventsPadding(
      padding: EventsEdgeInsets.only(
        top: EventsSize.large,
        bottom: EventsSize.large,
        left: EventsSize.normal,
        right: EventsSize.normal,
      ),
      child: BlocConsumer<EventCategoryCubit, EventCategoryState>(
        listener: (context, state) {
          if (state is EventCategoryLoadError) {
            EventsSnackBars.showErrorSnackbar(
              context: context,
              message: t(LocaleKeys.errorCategories),
            );
          }
        },
        builder: (context, state) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            separatorBuilder: (_, index) => const SizedBox(
              width: 10,
            ),
            itemBuilder: (_, index) {
              final category = state.categories.elementAt(index);
              return EventsPadding(
                padding: EventsEdgeInsets.only(
                  top: EventsSize.xSmall,
                  bottom: EventsSize.xSmall,
                  left: index == 0 ? EventsSize.xxSmall : EventsSize.none,
                  right: index == state.categories.length - 1
                      ? EventsSize.xxSmall
                      : EventsSize.none,
                ),
                child: _EventCategoryItem(
                  isSelected: index == state.currentIndex,
                  categoryLabel: category.name,
                  onTap: () => BlocProvider.of<EventCategoryCubit>(context)
                      .selectCategory(category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _EventCategoryItem extends StatelessWidget {
  const _EventCategoryItem({
    required this.isSelected,
    required this.categoryLabel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final String categoryLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? darkBlack : Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(2, 2), // shadow direction: bottom right
            )
          ],
        ),
        child: EventsPadding(
          padding: EventsEdgeInsets.all(EventsSize.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryLabel,
                style: TextStyle(
                  color: isSelected ? Colors.white : darkBlack,
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
