import 'package:brie/gen/user/v1/user.connect.client.dart';
import 'package:brie/gen/user/v1/user.pb.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiProvider = Provider<UserServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return UserServiceClient(channel);
});

final userInfoProvider = FutureProvider<User>((ref) async {
  final user = ref.watch(userApiProvider);
  final response = await user.getUserInfo(GetUserInfoRequest());

  return response.user;
});
