import 'dart:async';

import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/ips_events/cubit/event_category_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:ips_events_manager/widgets/events_padding/events_padding.dart';
import 'package:ndialog/ndialog.dart';
import 'package:repositories/repositories.dart';

class ManageCategoriesPage extends StatelessWidget {
  const ManageCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCategoryCubit, EventCategoryState>(
      builder: (context, state) {
        if (state is EventCategoryLoadSuccess) {
          return Column(
            children: [
              EventsPadding(
                padding: EventsEdgeInsets.all(EventsSize.large),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: !_shouldAddCategory(context)
                        ? null
                        : () async {
                            await _showCreateDialog(
                              context,
                              BlocProvider.of<EventCategoryCubit>(context),
                            );
                          },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Create Category'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(MdiIcons.plusBox)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Icon(MdiIcons.delete))
                    ],
                    rows: List<DataRow>.generate(state.categories.length,
                        (index) {
                      final category = state.categories.elementAt(index);
                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          // All rows will have the same selected color.
                          if (states.contains(MaterialState.selected)) {
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.08);
                          }
                          // Even rows will have a grey color.
                          if (index.isEven) {
                            return Colors.grey.withOpacity(0.3);
                          }
                          return null; // Use default value for other states and odd rows.
                        }),
                        cells: [
                          DataCell(
                            Text(
                              category.id!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          DataCell(
                            Text(
                              category.name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          DataCell(
                            ElevatedButton(
                              onPressed: !_shouldAddCategory(context)
                                  ? null
                                  : () {
                                      BlocProvider.of<EventCategoryCubit>(
                                        context,
                                      ).deleteCategory(category.id!);
                                    },
                              child: const Icon(
                                MdiIcons.deleteAlert,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          );
        }

        return Center(
          child: SpinKitCubeGrid(
            color: lightBlack,
          ),
        );
      },
    );
  }

  Future<void> _showCreateDialog(
    BuildContext context,
    EventCategoryCubit eventCategoryCubit,
  ) async {
    final categoryController = TextEditingController();
    final newCategory = await NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const Text('Criar Categoria'),
      content: TextFormField(
        controller: categoryController,
        decoration: const InputDecoration(
          icon: Icon(MdiIcons.commentMultiple),
          labelText: 'Categoria',
        ),
      ),
      actions: <Widget>[
        EventsPadding(
          padding: EventsEdgeInsets.all(EventsSize.normal),
          child: ElevatedButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context, null);
            },
          ),
        ),
        EventsPadding(
          padding: EventsEdgeInsets.all(EventsSize.normal),
          child: ElevatedButton(
            child: const Text('Criar'),
            onPressed: () {
              Navigator.pop(context, categoryController.text);
            },
          ),
        ),
      ],
    ).show<String?>(context);

    if (newCategory != null && newCategory.isNotEmpty) {
      unawaited(eventCategoryCubit.createCategory(newCategory));
    }
  }

  bool _shouldAddCategory(BuildContext context) {
    final profileState = context.read<UserProfileCubit>().state;
    if (profileState is! UserProfileLoadSuccess) return false;
    return profileState.userProfile.role == UserRole.admin;
  }
}
