import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as protocol;

Transport setupClientTransport(
  String? basePath,
  List<Interceptor> interceptors,
) {
  return protocol.Transport(
    baseUrl: basePath!,
    codec: const ProtoCodec(),
    httpClient: createHttpClient(),
    interceptors: interceptors,
  );
}
