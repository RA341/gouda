import 'package:brie/gen/category/v1/category.pbgrpc.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final catProvider = Provider<CategoryServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authInterceptor = ref.watch(authInterceptorProvider);

  final catClient = CategoryServiceClient(
    channel,
    interceptors: [authInterceptor],
  );

  return catClient;
});
