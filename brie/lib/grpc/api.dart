import 'package:brie/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:universal_html/html.dart' as html;

import 'grpc_native.dart' if (dart.library.html) 'grpc_web.dart';

final apiTokenProvider = Provider<String>((ref) {
  return prefs.getString('apikey') ?? '';
});

final basePathProvider = Provider<String>((ref) {
  // setup for future feature to modify base path from within the client
  final basePath = prefs.getString('basePath');

  final finalPath = basePath ??
      (kDebugMode
          ? ('http://localhost:9862')
          : html.window.location.toString());

  print('Base path is: $finalPath');

  return finalPath.endsWith('/')
      ? finalPath.substring(0, finalPath.length - 1)
      : finalPath;
});

final grpcChannelProvider = Provider<Channel>((ref) {
  final apiBasePath = ref.watch(basePathProvider);
  final channel = setupClientChannel(apiBasePath);

  return channel;
});

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  final token = ref.watch(apiTokenProvider);
  return AuthInterceptor(token);
});

class AuthInterceptor implements ClientInterceptor {
  final String authToken;

  AuthInterceptor(this.authToken);

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    final metadata = Map<String, String>.from(options.metadata);
    metadata['Authorization'] = authToken;

    final newOptions = options.mergedWith(
      CallOptions(metadata: metadata),
    );

    return invoker(method, request, newOptions);
  }
}
