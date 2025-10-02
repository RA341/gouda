// add more as needed
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:flutter/material.dart';

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
    "AudioBooks" =>
        Icon(
          Icons.headphones,
          color: Colors.green,
          size: iconsSize,
        ),
    "EBooks" =>
        Icon(
          Icons.book,
          color: Colors.blue,
          size: iconsSize,
        ),
    "Radio" =>
        Icon(
          Icons.radio,
          color: Colors.red,
          size: iconsSize,
        ),
    _ =>
        Icon(
          Icons.question_mark,
          color: Colors.blueGrey,
          size: iconsSize,
        ),
  };
}
