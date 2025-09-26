import 'package:brie/config.dart';
import 'package:brie/grpc/grpc_native.dart'
if (dart.library.html) 'package:brie/grpc/grpc_web.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final grpcChannelProvider = Provider<Channel>((ref) {
  final localConfig = ref.watch(appSettingsProvider);
  final channel = setupClientChannel(localConfig.basePath);

  return channel;
});

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  // final token = ref.watch(apiTokenProvider);
  return AuthInterceptor('');
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
