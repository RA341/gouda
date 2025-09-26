import 'package:brie/config.dart';
import 'package:brie/gen/auth/v1/auth.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiProvider = Provider<AuthServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = AuthServiceClient(channel);

  return client;
});

Future<void> logout(WidgetRef ref) async {
  final refresh = ref
      .watch(appSettingsProvider)
      .refreshToken;

  await ref.read(authApiProvider).logout(LogoutRequest(refresh: refresh));

  await ref.read(appSettingsProvider.notifier).clearTokens();
}

// class AuthApi {
//   AuthApi(this.apiClient);
//
//   final AuthServiceClient apiClient;
//
//   Future<void> login({
//     required String user,
//     required String pass,
//   }) async {
//     final token = await mustRunGrpcRequest(
//       () => apiClient.authenticate(
//         AuthRequest(
//           username: user,
//           password: pass,
//         ),
//       ),
//     );
//
//     await prefs.setString(prefsSessionKey, token.authToken);
//   }
//
//   Future<bool> testToken({required String token}) async {
//     if (token == '') {
//       return false;
//     }
//
//     try {
//       await mustRunGrpcRequest(
//         () => apiClient.test(
//           AuthResponse(authToken: token),
//         ),
//       );
//     } catch (e) {
//       logger.e('Incorrect token', error: e);
//       return false;
//     }
//
//     return true;
//   }
// }
