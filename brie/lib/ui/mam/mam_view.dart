import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/settings/settings_view.dart';
import 'package:brie/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const errMamNotSetupUser =
    "Administrator has not setup search functionality yet";
const errMamNotSetupAdmin = "MAM setup is not complete";

final isMamSetupProvider = FutureProvider.autoDispose<String>((ref) async {
  final (_, err) = await runGrpcRequest(
    () => ref.watch(mamApiProvider).isMamSetup(IsMamSetupRequest()),
  );
  if (err.isEmpty) {
    // mam is setup
    return "";
  }

  final isAdmin = await ref.watch(isAdminProvider.future);
  logger.w("Mam is not setup $err");

  return isAdmin ? errMamNotSetupAdmin : errMamNotSetupUser;
});

class MamView extends ConsumerWidget {
  const MamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setup = ref.watch(isMamSetupProvider);

    return setup.when(
      data: (status) =>
          status.isEmpty ? const MamCore() : MamNotSetup(status: status),
      error: (error, stackTrace) => Center(
        child: Text("Unable to check if mam is setup $mamApiProvider"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MamCore extends ConsumerWidget {
  const MamCore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                decoration: const BoxDecoration(
                  border: BoxBorder.fromBorderSide(
                    BorderSide(width: 2, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MamNotSetup extends ConsumerWidget {
  const MamNotSetup({required this.status, super.key});

  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            status,
            style: const TextStyle(fontSize: 20),
          ),
          if (status == errMamNotSetupAdmin)
            ElevatedButton(
              onPressed: () {
                ref.read(pageIndexProvider.notifier).switchPage(2);
                ref.read(settingsTabIndexProvider.notifier).set(1);
              },
              child: const Text(
                "Setup Now",
              ),
            ),
        ],
      ),
    );
  }
}
