import 'package:brie/config.dart';
import 'package:brie/grpc/grpc_channel_shared.dart';
import 'package:connectrpc/connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectTransportProvider = Provider<Transport>((ref) {
  final localConfig = ref.watch(appSettingsProvider);
  final basePath = localConfig.basePath;
  final sessionToken = localConfig.sessionToken;

  final Interceptor authentiation = <I extends Object, O extends Object>(next) {
    return (req) {
      req.headers.add('Authorization', sessionToken);
      return next(req);
    };
  };

  return setupClientTransport(basePath, [authentiation]);
});
