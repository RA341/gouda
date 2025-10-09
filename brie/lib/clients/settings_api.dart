import 'dart:async';

import 'package:brie/gen/settings/v1/settings.connect.client.dart';
import 'package:brie/grpc/api.dart';
import 'package:brie/utils.dart';
import 'package:connectrpc/connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsApiProvider = Provider<SettingsServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return SettingsServiceClient(channel);
});

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
  } on ConnectException catch (e) {
    logger.e('Grpc error, $e');
    return (null, e.message ?? 'Empty error details in grpc error');
  } catch (e) {
    logger.e('Failed to run GRPC request\nUnknown error: $e');
    return (null, 'Unknown Error: $e');
  }
}
