//
//  Generated code. Do not modify.
//  source: media_requests/v1/media_requests.proto
//

import "package:connectrpc/connect.dart" as connect;
import "media_requests.pb.dart" as media_requestsv1media_requests;
import "media_requests.connect.spec.dart" as specs;

extension type MediaRequestServiceClient (connect.Transport _transport) {
  Future<media_requestsv1media_requests.SearchResponse> search(
      media_requestsv1media_requests.SearchRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.search,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.ListResponse> list(
      media_requestsv1media_requests.ListRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.list,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.DeleteResponse> delete(
      media_requestsv1media_requests.DeleteRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.delete,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.EditResponse> edit(
      media_requestsv1media_requests.EditRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.edit,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.ExistsResponse> exists(
      media_requestsv1media_requests.ExistsRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.exists,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.RetryResponse> retry(
      media_requestsv1media_requests.RetryRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.retry,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.AddMediaResponse> addMedia(
      media_requestsv1media_requests.AddMediaRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.addMedia,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<media_requestsv1media_requests.AddMediaResponse> addMediaWithFreeleech(
      media_requestsv1media_requests.AddMediaRequest input, {
        connect.Headers? headers,
        connect.AbortSignal? signal,
        Function(connect.Headers)? onHeader,
        Function(connect.Headers)? onTrailer,
      }) {
    return connect.Client(_transport).unary(
      specs.MediaRequestService.addMediaWithFreeleech,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
