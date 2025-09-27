import 'package:brie/gen/user/v1/user.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userApiProvider = Provider<UserServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final client = UserServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return client;
});

final userInfoProvider = FutureProvider<User>((ref) async {
  final user = ref.watch(userApiProvider);
  final response = await user.getUserInfo(GetUserInfoRequest());

  return response.user;
});
