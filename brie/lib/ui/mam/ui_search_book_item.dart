import 'package:brie/clients/history_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/gen/media_requests/v1/media_requests.pb.dart';
import 'package:brie/ui/mam/ui_narrator.dart';
import 'package:brie/ui/mam/ui_title_author.dart';
import 'package:brie/ui/shared/error_dialog.dart';
import 'package:brie/utils.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchBookItem extends ConsumerWidget {
  const SearchBookItem({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBookItemMobile(book: book);
  }
}

class SearchBookItemMobile extends HookConsumerWidget {
  const SearchBookItemMobile({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaType = getMediaIcon(book);

    final isSending = useState(false);
    logger.i(book.torrentLink);

    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(10),
        childrenPadding: const EdgeInsets.all(10),
        expandedAlignment: Alignment.centerLeft,
        title: Row(
          spacing: 10,
          children: [
            Column(
              spacing: 9,
              children: [
                mediaType,
                SizedBox(
                  width: 48,
                  child: Text(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
                    book.mediaCategory.endsWith("s")
                        ? book.mediaCategory.substring(
                            0,
                            book.mediaCategory.length - 1,
                          )
                        : book.mediaCategory,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleAndAuthorInfo(book: book),
                  Text(
                    "Series: ${book.series.take(2).map(
                      (e) => '${htmlQuickDecode(e.name)} #${e.sequenceNumber}',
                    ).join(", ")}",
                  ),
                  if (book.narrator.isNotEmpty)
                    SeriesAndNarratorInfo(book: book),
                  Text(book.tags),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        DateTime.parse(
                          book.dateAddedIso,
                        ).toString().split(' ')[0],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      // todo make this button have icons
                      ElevatedButton(
                        onPressed: isSending.value
                            ? null
                            : () async {
                                isSending.value = true;

                                final (result, err) = await runGrpcRequest(
                                  () => ref
                                      .read(mediaRequestApiProvider)
                                      .addMedia(
                                        AddMediaRequest(
                                          media: buildMedia(book),
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
                        child: isSending.value
                            ? const CircularProgressIndicator()
                            : const Text("Download"),
                      ),
                      ElevatedButton(
                        onPressed: isSending.value
                            ? null
                            : () async {
                                isSending.value = true;

                                final (result, err) = await runGrpcRequest(
                                  () => ref
                                      .read(mediaRequestApiProvider)
                                      .addMediaWithFreeleech(
                                        AddMediaRequest(
                                          media: buildMedia(book),
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
                        child: isSending.value
                            ? const CircularProgressIndicator()
                            : const Text("Wedge Download"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          // Additional info shown when expanded
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 8),
              if (book.description.isNotEmpty) ...[
                const Row(
                  children: [
                    Icon(Icons.description, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Html(data: book.description),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

Media buildMedia(SearchBook book) {
  return Media(
    // author: book.author.first.name,
    book: book.title,
    // todo
    // category: book,
    fileLink: book.torrentLink,
    mamBookId: Int64(book.mamId),
    // series: book.series.first.name,
  );
}

// add more as needed
String htmlQuickDecode(String text) {
  return text
      .replaceAll('&amp;', '&')
      .replaceAll("&lt;", "<")
      .replaceAll("&gt;", ">")
      .replaceAll("&quot;", '"')
      .replaceAll("&#039;", "'")
      .replaceAll('&nbsp;', ' ');
}

Icon getMediaIcon(SearchBook book, {double iconsSize = 40.0}) {
  return switch (book.mediaCategory) {
    "AudioBooks" => Icon(
      Icons.headphones,
      color: Colors.green,
      size: iconsSize,
    ),
    "EBooks" => Icon(
      Icons.book,
      color: Colors.blue,
      size: iconsSize,
    ),
    "Radio" => Icon(
      Icons.radio,
      color: Colors.red,
      size: iconsSize,
    ),
    _ => Icon(
      Icons.question_mark,
      color: Colors.blueGrey,
      size: iconsSize,
    ),
  };
}
