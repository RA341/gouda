import 'package:brie/clients/mam_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/layout/layout_page.dart';
import 'package:brie/ui/mam/ui_search_book_item.dart';
import 'package:brie/ui/settings/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const errMamNotSetupUser =
    "Administrator has not setup search functionality yet";
const errMamNotSetupAdmin = "MAM setup is not complete";

final FutureProvider<String> isMamSetupProvider =
    FutureProvider.autoDispose<String>((ref) async {
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

class MamCore extends HookConsumerWidget {
  const MamCore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(mamBooksSearchProvider);
    final sController = useTextEditingController(
      text: kDebugMode ? "Guide to the galaxy" : "",
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          TextField(
            controller: sController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onSubmitted: (value) async {
              await ref.read(mamBooksSearchProvider.notifier).searchNew(value);
            },
          ),
          Expanded(
            child: searchProvider.when(
              data: (data) => Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  child: data.isEmpty
                      ? const Center(
                          child: Text("No results found"),
                        )
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              SearchBookItem(book: data[index]),
                        ),
                ),
              ),
              error: (error, stackTrace) =>
                  ErrorDisplay(message: error.toString()),
              loading: LoadingSpinner.new,
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
