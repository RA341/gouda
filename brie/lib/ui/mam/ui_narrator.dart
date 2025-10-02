import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:flutter/material.dart';

class SeriesAndNarratorInfo extends StatelessWidget {
  const SeriesAndNarratorInfo({
    required this.book,
    this.maxNarratorsToShow = 2,
    super.key,
  });

  final int maxNarratorsToShow;
  final SearchBook book;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        Text.rich(
          TextSpan(
            style: const TextStyle(fontStyle: FontStyle.italic),
            children: [
              const TextSpan(
                text: "Narrators: ",
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: book.narrator
                    .take(maxNarratorsToShow)
                    .map((e) => e.name)
                    .join(", ")
                    .trim(),
                style: const TextStyle(fontSize: 16),
              ),
              if (book.author.length > maxNarratorsToShow)
                TextSpan(
                  text:
                      " and ${book.narrator.length - maxNarratorsToShow} more",
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
