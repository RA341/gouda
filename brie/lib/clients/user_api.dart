import 'package:brie/clients/auth_api.dart';
import 'package:brie/clients/settings_api.dart';
import 'package:brie/gen/auth/v1/auth.pb.dart';
import 'package:brie/gen/user/v1/user.connect.client.dart';
import 'package:brie/gen/user/v1/user.pb.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiProvider = Provider<UserServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return UserServiceClient(channel);
});

final userInfoProvider = FutureProvider<User>((ref) async {
  final user = ref.watch(authApiProvider);
  final response = await mustRunGrpcRequest(
    () => user.userProfile(UserProfileRequest()),
  );
  return response.user;
});
