//
//  Generated code. Do not modify.
//  source: media_requests/v1/media_requests.proto
//

import "package:connectrpc/connect.dart" as connect;
import "media_requests.pb.dart" as media_requestsv1media_requests;

abstract final class MediaRequestService {
  /// Fully-qualified name of the MediaRequestService service.
  static const name = 'media_requests.v1.MediaRequestService';

  static const search = connect.Spec(
    '/$name/Search',
    connect.StreamType.unary,
    media_requestsv1media_requests.SearchRequest.new,
    media_requestsv1media_requests.SearchResponse.new,
  );

  static const list = connect.Spec(
    '/$name/List',
    connect.StreamType.unary,
    media_requestsv1media_requests.ListRequest.new,
    media_requestsv1media_requests.ListResponse.new,
  );

  static const delete = connect.Spec(
    '/$name/Delete',
    connect.StreamType.unary,
    media_requestsv1media_requests.DeleteRequest.new,
    media_requestsv1media_requests.DeleteResponse.new,
  );

  static const edit = connect.Spec(
    '/$name/Edit',
    connect.StreamType.unary,
    media_requestsv1media_requests.EditRequest.new,
    media_requestsv1media_requests.EditResponse.new,
  );

  static const exists = connect.Spec(
    '/$name/Exists',
    connect.StreamType.unary,
    media_requestsv1media_requests.ExistsRequest.new,
    media_requestsv1media_requests.ExistsResponse.new,
  );

  static const retry = connect.Spec(
    '/$name/Retry',
    connect.StreamType.unary,
    media_requestsv1media_requests.RetryRequest.new,
    media_requestsv1media_requests.RetryResponse.new,
  );

  static const addMedia = connect.Spec(
    '/$name/AddMedia',
    connect.StreamType.unary,
    media_requestsv1media_requests.AddMediaRequest.new,
    media_requestsv1media_requests.AddMediaResponse.new,
  );

  static const addMediaWithFreeleech = connect.Spec(
    '/$name/AddMediaWithFreeleech',
    connect.StreamType.unary,
    media_requestsv1media_requests.AddMediaRequest.new,
    media_requestsv1media_requests.AddMediaResponse.new,
  );
}
