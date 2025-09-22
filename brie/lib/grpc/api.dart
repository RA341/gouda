import 'package:brie/config.dart';
import 'package:brie/grpc/grpc_native.dart'
    if (dart.library.html) 'package:brie/grpc/grpc_web.dart';
import 'package:brie/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

const prefsAuthorizationKey = 'AuthToken';
const prefsBaseUrl = 'BaseUrl';

final apiTokenProvider = Provider<String>((ref) {
  return prefs.getString(prefsAuthorizationKey) ?? '';
});

Future<void> updateBasepath(WidgetRef ref, String baseurl) async {
  await prefs.setString(prefsBaseUrl, baseurl);
  ref.invalidate(basePathProvider);
}

final basePathProvider = Provider<String>((ref) {
  // setup for future feature to modify base path from within the client
  var basePath = prefs.getString(prefsBaseUrl) ?? '';

  // final finalPath = basePath ?? devUrl;

  basePath = basePath.endsWith('/')
      ? basePath.substring(0, basePath.length - 1)
      : basePath;

  logger.i('Base path is: $basePath');

  return basePath;
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
  AuthInterceptor(this.authToken);

  final String authToken;

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
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final metadata = Map<String, String>.from(options.metadata);
    metadata['Authorization'] = authToken;

    final newOptions = options.mergedWith(
      CallOptions(metadata: metadata),
    );

    return invoker(method, request, newOptions);
  }
}
