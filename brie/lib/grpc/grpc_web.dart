import 'package:grpc/grpc_web.dart';

typedef Channel = GrpcWebClientChannel;

Channel setupClientChannel(String basePath) {
  return GrpcWebClientChannel.xhr(Uri.parse(basePath));
}