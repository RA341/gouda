import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:flutter/material.dart';

class TitleAndAuthorInfo extends StatelessWidget {
  const TitleAndAuthorInfo({
    required this.book,
    this.maxAuthorsToShow = 2,
    super.key,
  });

  final SearchBook book;
  final int maxAuthorsToShow;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " By ",
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: book.author
                    .take(maxAuthorsToShow)
                    .map((e) => e.name)
                    .join(", ")
                    .trim(),
                style: const TextStyle(fontSize: 16),
              ),
              if (book.author.length > maxAuthorsToShow)
                TextSpan(
                  text: " and ${book.author.length - maxAuthorsToShow} more",
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
