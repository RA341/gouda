import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/ui/home/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeBookItem extends HookConsumerWidget {
  const HomeBookItem({required this.media, super.key});

  final Media media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleting = useState(false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(media.book),
            Text(media.status),

            Text(media.series),
            Text(media.seriesNumber.toString()),
            Text(media.category),
            // Text(media.fileLink),
            ElevatedButton.icon(
              onPressed: isDeleting.value
                  ? null
                  : () async {
                      isDeleting.value = true;

                      final (_, err) = await runGrpcRequest(
                        () => ref
                            .read(mediaRequestApiProvider)
                            .delete(
                              DeleteRequest(
                                requestId: media.iD,
                              ),
                            ),
                      );

                      if (err.isNotEmpty) {
                        if (!context.mounted) return;
                        await showErrorDialog(
                          context,
                          "Error while deleting",
                          err,
                        );
                      }

                      ref.invalidate(bookHistoryProvider);
                      isDeleting.value = false;
                    },
              label: isDeleting.value
                  ? const Text("Deleting")
                  : const Text("Delete"),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
