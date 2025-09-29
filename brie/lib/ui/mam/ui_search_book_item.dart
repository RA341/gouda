import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/mam/ui_narrator.dart';
import 'package:brie/ui/mam/ui_title_author.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBookItem extends ConsumerWidget {
  const SearchBookItem({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBookItemMobile(book: book);
  }
}

class SearchBookItemMobile extends ConsumerWidget {
  const SearchBookItemMobile({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaType = getMediaIcon(book);

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
                        child: const Text("Download"),
                        onPressed: () {},
                      ),
                      ElevatedButton(
                        child: const Text("Wedge Download"),
                        onPressed: () {},
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
