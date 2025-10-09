import 'package:brie/gen/mam/v1/mam.connect.client.dart';
import 'package:brie/gen/mam/v1/mam.pb.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mamApiProvider = Provider<MamServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return MamServiceClient(channel);
});

final mamProfileProvider = FutureProvider<UserData>((ref) async {
  final mam = ref.watch(mamApiProvider);
  return mam.getProfile(Empty());
});
