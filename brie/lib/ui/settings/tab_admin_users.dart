import 'dart:async';

import 'package:brie/clients/settings_api.dart';
import 'package:brie/clients/user_api.dart';
import 'package:brie/gen/user/v1/user.connect.client.dart';
import 'package:brie/gen/user/v1/user.pb.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension UserRef on WidgetRef {
  UsersNotifier users() {
    return read(usersProvider.notifier);
  }
}

final usersProvider = AsyncNotifierProvider<UsersNotifier, List<User>>(
  UsersNotifier.new,
);

class UsersNotifier extends AsyncNotifier<List<User>> {
  late final UserServiceClient user = ref.watch(userApiProvider);

  @override
  Future<List<User>> build() async => fetch();

  Future<List<User>> fetch() async {
    final us = await mustRunGrpcRequest(
      () => user.userList(ListUsersRequest()),
    );
    return us.users.toList();
  }

  Future<String?> add(User newUser) async {
    final (_, err) = await runGrpcRequest(
      () => user.userAdd(AddUserRequest(user: newUser)),
    );
    if (err.isNotEmpty) {
      return err;
    }
    state = await AsyncValue.guard(() async {
      return fetch();
    });

    return null;
  }

  Future<String?> edit(User newUser) async {
    final (_, err) = await runGrpcRequest(
      () => user.userEdit(UserEditRequest(editUser: newUser)),
    );
    if (err.isNotEmpty) {
      return err;
    }
    state = await AsyncValue.guard(() async {
      return fetch();
    });

    return null;
  }

  Future<String?> delete(User newUser) async {
    final (_, err) = await runGrpcRequest(
      () => user.userDelete(UserDeleteRequest(userId: newUser.userId)),
    );
    if (err.isNotEmpty) {
      return err;
    }
    state = await AsyncValue.guard(() async {
      return fetch();
    });

    return null;
  }
}

class TabUserManagement extends ConsumerWidget {
  const TabUserManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);

    return users.when(
      data: (data) => Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  label: const Text("Add"),
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => const UserDialog(),
                    );
                  },
                ),
                ElevatedButton.icon(
                  label: const Text("Refresh"),
                  icon: const Icon(Icons.refresh),
                  onPressed: () => ref.invalidate(usersProvider),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final user = data[index];
                  return ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.role.toString()),
                    trailing: IconButton(
                      onPressed: () async {
                        final err = await ref
                            .read(usersProvider.notifier)
                            .delete(user);
                        if (!context.mounted) return;
                        if (err != null) {
                          await showErrorDialog(
                            context,
                            "Unable to delete user",
                            err,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () async {
                      await showDialog<void>(
                        context: context,
                        builder: (context) => UserDialog(user: user),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      error: errorHandler,
      loading: LoadingSpinner.new,
    );
  }
}

class UserDialog extends HookConsumerWidget {
  const UserDialog({this.user, super.key});

  final User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController(text: user?.username);
    final passwordController = useTextEditingController();
    final roleController = useTextEditingController(
      text: user?.role.toString(),
    );
    final selectedRole = useState(Role.Mouse);

    final isUserNull = user == null;
    final text = "${isUserNull ? "Add" : "Edit"} User";

    return AlertDialog(
      title: Text(text),
      content: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          DropdownMenu(
            label: const Text("Role"),
            controller: roleController,
            onSelected: (value) {
              if (value == null) {
                return;
              }
              selectedRole.value = value;
            },
            initialSelection: user?.role ?? selectedRole.value,
            dropdownMenuEntries: Role.values
                .where((e) => e != Role.Unknown)
                .map((e) => DropdownMenuEntry(value: e, label: e.name))
                .toList(),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          label: const Text("Cancel"),
          icon: const Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton.icon(
          label: Text(text),
          icon: Icon(isUserNull ? Icons.add : Icons.edit),
          onPressed: () async {
            final modifiedUser = user ?? User()
              ..username = usernameController.text
              ..password = passwordController.text
              ..role = selectedRole.value;

            final err = isUserNull
                ? await ref.read(usersProvider.notifier).add(modifiedUser)
                : await ref.read(usersProvider.notifier).edit(modifiedUser);

            if (!context.mounted) return;
            if (err != null) {
              await showErrorDialog(
                context,
                "Unable to ${isUserNull ? "add" : "edit"} user",
                err,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
