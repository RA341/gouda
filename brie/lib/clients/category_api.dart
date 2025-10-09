import 'package:brie/gen/category/v1/category.connect.client.dart';
import 'package:brie/grpc/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryApiProvider = Provider<CategoryServiceClient>((ref) {
  final channel = ref.watch(connectTransportProvider);
  return CategoryServiceClient(channel);
});
