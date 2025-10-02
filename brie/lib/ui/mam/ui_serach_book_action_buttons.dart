import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart' show SearchBook;
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/ui/mam/ui_category_builder.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchItemActionButtons extends HookConsumerWidget {
  const SearchItemActionButtons({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSending = useState(false);
    final category = useState("");

    return Wrap(
      spacing: 5,
      children: [
        CategoryDropDown(category: category),
        ElevatedButton.icon(
          label: isSending.value
              ? const Text("Sending")
              : const Text("Download"),
          icon: const Icon(Icons.download),
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xff8f36ff),
          ),
          onPressed: isSending.value
              ? null
              : () async {
            isSending.value = true;

            final (result, err) = await runGrpcRequest(
                  () =>
                  ref
                      .read(mediaRequestApiProvider)
                      .addMedia(
                    AddMediaRequest(
                      media: buildMedia(book, category.value),
                    ),
                  ),
            );
            if (err.isNotEmpty) {
              if (!context.mounted) return;

              await showErrorDialog(
                context,
                "Unable to send media",
                err,
              );
            }

            isSending.value = false;
          },
        ),
        ElevatedButton.icon(
          label: isSending.value
              ? const Text("Sending")
              : const Text("Wedge Download"),
          icon: const Icon(FontAwesomeIcons.cheese),
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xffe19103),
          ),
          onPressed: isSending.value
              ? null
              : () async {
            isSending.value = true;

            final (result, err) = await runGrpcRequest(
                  () =>
                  ref
                      .read(mediaRequestApiProvider)
                      .addMediaWithFreeleech(
                    AddMediaRequest(
                      media: buildMedia(book, category.value),
                    ),
                  ),
            );
            if (err.isNotEmpty) {
              if (!context.mounted) return;

              await showErrorDialog(
                context,
                "Unable to send media",
                err,
              );
            }

            isSending.value = false;
          },
        ),
      ],
    );
  }

  Media buildMedia(SearchBook book, String category) {
    final media = Media(
      book: book.title,
      author: book.author.firstOrNull?.name,
      category: category,
      fileLink: book.torrentLink,
      mamBookId: Int64(book.mamId),
    );

    final series = book.series.firstOrNull;
    if (series != null) {
      media
        ..series = series.name
        ..seriesNumber = int.parse(series.sequenceNumber);
    }

    return media;
  }
}
