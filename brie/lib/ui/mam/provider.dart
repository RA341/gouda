import 'dart:typed_data';

import 'package:brie/clients/mam_api.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The internal type is not exported by riverpod
// ignore: specify_nonobvious_property_types
final thumbnailProvider = FutureProvider.family<Uint8List, String>((
  ref,
  imageId,
) async {
  final mamApi = ref.watch(mamApiProvider);
  final res = await mamApi.getThumbnail(GetThumbnailRequest(id: imageId));
  return Uint8List.fromList(res.imageData);
});

// todo thumbnails move them to display only when user expands book info
// Consumer(
//   builder: (context, ref, child) {
//     final imageProvider = ref.watch(
//       thumbnailProvider(book.thumbnail),
//     );
//
//     return imageProvider.when(
//       data: (data) {
//         return Image.memory(
//           data,
//           scale: 10,
//         );
//       },
//       error: (error, stackTrace) {
//         logger.e("Error fetching thumbnail $error");
//         return const Icon(Icons.error);
//       },
//       loading: () {
//         return const CircularProgressIndicator();
//       },
//     );
//   },
// ),
