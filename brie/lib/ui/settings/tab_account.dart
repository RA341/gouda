import 'package:brie/clients/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabAccount extends ConsumerWidget {
  const TabAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("KHello Username: ${userInfo.value?.username ?? "No username"}"),
        Text("Your Role: ${userInfo.value?.role ?? "No role loaded"}"),
      ],
    );
  }
}
