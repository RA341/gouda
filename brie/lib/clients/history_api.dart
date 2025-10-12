import 'package:brie/gen/media_requests/v1/media_requests.connect.client.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaRequestApiProvider = Provider<MediaRequestServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return MediaRequestServiceClient(channel);
});
