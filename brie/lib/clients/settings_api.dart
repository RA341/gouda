import 'package:brie/gen/settings/v1/settings.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    await apiClient.updateSettings(config);
  }

  Future<Settings> list() async =>
      await apiClient.listSettings(ListSettingsResponse());

  Future<List<String>> listClients() async =>
      (await apiClient.listSupportedClients(ListSupportedClientsRequest()))
          .clients;

  Future<GetMetadataResponse> getMetadata() =>
      apiClient.getMetadata(GetMetadataRequest());
}
