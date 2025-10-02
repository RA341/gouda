import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/ui/home/provider.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: media.book,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const TextSpan(
                    text: " By ",
                    style: TextStyle(fontSize: 13),
                  ),
                  TextSpan(
                    text: media.author,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),

            if (media.series.isNotEmpty)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: media.series,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const TextSpan(
                      text: " ",
                      style: TextStyle(fontSize: 13),
                    ),
                    TextSpan(
                      text: media.seriesNumber.toString(),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),

            Chip(
              label: Text(media.status),
              backgroundColor: switch (media.status) {
                "completed" => Colors.green[800],
                "error" => Colors.red[800],
                "downloading" => Colors.blue[800],
                _ => Colors.grey[800],
              },
            ),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: getMamLink(media.mamBookId.toString()).toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await launchUrl(getMamLink(media.mamBookId.toString()));
                      },
                  ),
                ],
              ),
            ),

            Text(media.category),

            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                // dark red
                backgroundColor: const Color(0xffb60606),
              ),
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

Uri getMamLink(String bookId) {
  return Uri.parse("https://www.myanonamouse.net/t/$bookId");
}
