import 'package:connectrpc/connect.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc_web.dart' as protocol;
import 'package:connectrpc/web.dart';
import 'package:web/web.dart';

String getWindowUrl() {
  return window.location.toString();
}

Transport setupClientTransport(
  String? basePath,
  List<Interceptor> interceptors,
) {
  var base = basePath;
  base ??= getWindowUrl();

  return protocol.Transport(
    baseUrl: base,
    codec: const ProtoCodec(),
    statusParser: const StatusParser(),
    httpClient: createHttpClient(),
    interceptors: interceptors,
  );
}
