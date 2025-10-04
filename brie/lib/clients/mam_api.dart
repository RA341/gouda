import 'package:brie/gen/mam/v1/mam.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final mamApiProvider = Provider<MamServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final client = MamServiceClient(
    channel,
    interceptors: [authInterceptor],
    options: CallOptions(timeout: const Duration(seconds: 5)),
  );
  return client;
});

final mamProfileProvider = FutureProvider<UserData>((ref) async {
  final mam = ref.watch(mamApiProvider);
  return mam.getProfile(Empty());
});
