import 'package:brie/gen/media_requests/v1/media_requests.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mediaRequestApiProvider = Provider<MediaRequestServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final media = MediaRequestServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return media;
});
