import 'package:core_components/core_components.dart';
import 'package:ips_events_manager/main_nav/cubit/navigation_cubit.dart';

class IpsEventsPages extends StatefulWidget {
  const IpsEventsPages({Key? key}) : super(key: key);

  @override
  State<IpsEventsPages> createState() => _IpsEventsPagesState();
}

class _IpsEventsPagesState extends State<IpsEventsPages> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listenWhen: (previous, current) => current.tabIndex != previous.tabIndex,
      listener: (context, state) {
        _pageController.jumpToPage(state.tabIndex);
      },
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(
            child: Text('1'),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          )
        ],
      ),
    );
  }
}
