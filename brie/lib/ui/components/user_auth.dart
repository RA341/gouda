import 'package:brie/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAuth extends ConsumerWidget {
  const UserAuth({
    required this.username,
    required this.password,
    this.showLinuxPermissions = false,
    this.linuxGID,
    this.linuxUID,
    super.key,
  }) : assert(
          (showLinuxPermissions && linuxGID != null && linuxUID != null),
          'Pass linux uid and gid inputs',
        );

  final bool showLinuxPermissions;
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController? linuxGID;
  final TextEditingController? linuxUID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 800,
      height: showLinuxPermissions ? 370 : 200,
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blue],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2),
          Text(
            'User Settings',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: 700,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 4),
            ),
          ),
          SizedBox(
            width: 250,
            child: createUpdateButtons2(
              'Username',
              username,
              autofillHints: [AutofillHints.username],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: createUpdateButtons2(
              'Password',
              password,
              autofillHints: [AutofillHints.password],
            ),
          ),
          if (showLinuxPermissions)
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: createUpdateButtons2('Linux UID', linuxUID!),
            ),
          if (showLinuxPermissions)
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: createUpdateButtons2('Linux GID', linuxGID!),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
