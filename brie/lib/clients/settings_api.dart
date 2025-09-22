import 'dart:async';

import 'package:brie/gen/settings/v1/settings.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:brie/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final settingsApiProvider = Provider<SettingsApi>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final client = SettingsServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return SettingsApi(client);
});

class SettingsApi {
  final SettingsServiceClient apiClient;

  SettingsApi(this.apiClient);

  Future<void> update(Settings config) async {
    mustRunGrpcRequest(() => apiClient.updateSettings(config));
  }

  Future<Settings> list() async =>
      mustRunGrpcRequest(() => apiClient.listSettings(ListSettingsResponse()));

  Future<List<String>> listClients() async {
    return (await mustRunGrpcRequest(
      () => apiClient.listSupportedClients(
        ListSupportedClientsRequest(),
      ),
    )).clients;
  }

  Future<GetMetadataResponse> getMetadata() =>
      mustRunGrpcRequest(() => apiClient.getMetadata(GetMetadataRequest()));

  Future<String> testClient(TorrentClient client) async {
    final (_, error) = await runGrpcRequest<TestTorrentResponse>(
      () => apiClient.testClient(client),
    );
    return error;
  }
}

/// throws if error occurs
Future<T> mustRunGrpcRequest<T>(Future<T> Function() request) async {
  final (val, err) = await runGrpcRequest<T>(request);
  if (err.isNotEmpty) throw err;

  return val! as T;
}

/// returns error as string
Future<(T?, String)> runGrpcRequest<T>(Future<T> Function() request) async {
  try {
    final res = await request();
    return (res, '');
  } on GrpcError catch (e) {
    logger.e('Grpc error, $e');
    return (null, e.message ?? 'Empty error details in grpc error');
  } catch (e) {
    logger.e('Failed to run GRPC request\nUnknown error: $e');
    return (null, 'Unknown Error: $e');
  }
}
