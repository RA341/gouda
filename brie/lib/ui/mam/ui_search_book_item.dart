import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/ui/mam/mam_search.dart';
import 'package:brie/ui/mam/provider.dart';
import 'package:brie/ui/mam/ui_narrator.dart';
import 'package:brie/ui/mam/ui_serach_book_action_buttons.dart';
import 'package:brie/ui/mam/ui_title_author.dart';
import 'package:brie/ui/mam/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(10),
        childrenPadding: const EdgeInsets.all(10),
        expandedAlignment: Alignment.centerLeft,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            MetadataView(book: book),
            SearchItemActionButtons(book: book),
          ],
        ),
        children: [DescriptionView(book: book)],
      ),
    );
  }
}

class MetadataView extends ConsumerWidget {
  const MetadataView({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaType = getMediaIcon(book);

    return Row(
      spacing: 10,
      children: [
        InkWell(
          onTap: () {
            final ca = getMediaCategory(book);
            if (ca == null) {
              return;
            }

            ref.updateQuery(
                  (query) => query..toggleCategory(ca),
            );
          },
          child: Column(
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
        ),
        Expanded(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndAuthorInfo(book: book),
              if (book.series.isNotEmpty)
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Series: "),
                      ...book.series.take(2).map((e) {
                        final seriesName = htmlQuickDecode(e.name);
                        final seriesNum = e.sequenceNumber;

                        return TextSpan(
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            decoration: TextDecoration.underline,
                          ),
                          text: '$seriesName #$seriesNum',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ref.updateQuery(
                                    (query) =>
                                query
                                  ..text = seriesName
                                  ..searchInFields.add(SearchInField.series),
                              );
                            },
                        );
                      }),
                    ],
                  ),
                ),
              if (book.narrator.isNotEmpty) SeriesAndNarratorInfo(book: book),
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
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionView extends ConsumerWidget {
  const DescriptionView({required this.book, super.key});

  final SearchBook book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
    );
  }
}
