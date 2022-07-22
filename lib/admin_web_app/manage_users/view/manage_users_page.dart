import 'package:core_components/core_components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ips_events_manager/admin_web_app/manage_users/cubit/user_management_cubit.dart';
import 'package:ips_events_manager/settings_nav/cubit/user_profile_cubit.dart';
import 'package:ips_events_manager/theme/theme.dart';
import 'package:repositories/repositories.dart';

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<UserProfileCubit>().state;

    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        if (state is UserManagementLoadUsersSuccess) {
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Role'))
                    ],
                    rows: List<DataRow>.generate(state.users.length, (index) {
                      final user = state.users.elementAt(index);
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
                              user.id,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.name,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          DataCell(
                            DropdownButton<String>(
                              value: user.role.name,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: !_shouldChangeRole(context)
                                  ? null
                                  : (String? newRole) {
                                      if (newRole != null) {
                                        BlocProvider.of<UserManagementCubit>(
                                          context,
                                        ).updateUserRole(
                                          userId: (profileState
                                                  as UserProfileLoadSuccess)
                                              .userProfile
                                              .id,
                                          role: UserRole.values.firstWhere(
                                            (role) =>
                                                role.name.toLowerCase() ==
                                                newRole.toLowerCase(),
                                          ),
                                        );
                                      }
                                    },
                              items: UserRole.values
                                  .map<DropdownMenuItem<String>>(
                                      (UserRole role) {
                                return DropdownMenuItem<String>(
                                  value: role.name,
                                  child: Text(role.name),
                                );
                              }).toList(),
                            ),
                          ),
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

  bool _shouldChangeRole(BuildContext context) {
    final profileState = context.read<UserProfileCubit>().state;
    if (profileState is! UserProfileLoadSuccess) return false;
    return profileState.userProfile.role == UserRole.admin;
  }
}
