// @generated by protoc-gen-es v1.10.0 with parameter "target=ts"
// @generated from file media_requests/v1/media_requests.proto (package media_requests.v1, syntax proto3)
/* eslint-disable */
// @ts-nocheck

import type { BinaryReadOptions, FieldList, JsonReadOptions, JsonValue, PartialMessage, PlainMessage } from "@bufbuild/protobuf";
import { Message, proto3, protoInt64 } from "@bufbuild/protobuf";

/**
 * @generated from message media_requests.v1.SearchRequest
 */
export class SearchRequest extends Message<SearchRequest> {
  /**
   * @generated from field: string mediaQuery = 1;
   */
  mediaQuery = "";

  constructor(data?: PartialMessage<SearchRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.SearchRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "mediaQuery", kind: "scalar", T: 9 /* ScalarType.STRING */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): SearchRequest {
    return new SearchRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): SearchRequest {
    return new SearchRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): SearchRequest {
    return new SearchRequest().fromJsonString(jsonString, options);
  }

  static equals(a: SearchRequest | PlainMessage<SearchRequest> | undefined, b: SearchRequest | PlainMessage<SearchRequest> | undefined): boolean {
    return proto3.util.equals(SearchRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.SearchResponse
 */
export class SearchResponse extends Message<SearchResponse> {
  /**
   * @generated from field: repeated media_requests.v1.Media results = 1;
   */
  results: Media[] = [];

  constructor(data?: PartialMessage<SearchResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.SearchResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "results", kind: "message", T: Media, repeated: true },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): SearchResponse {
    return new SearchResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): SearchResponse {
    return new SearchResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): SearchResponse {
    return new SearchResponse().fromJsonString(jsonString, options);
  }

  static equals(a: SearchResponse | PlainMessage<SearchResponse> | undefined, b: SearchResponse | PlainMessage<SearchResponse> | undefined): boolean {
    return proto3.util.equals(SearchResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.ListRequest
 */
export class ListRequest extends Message<ListRequest> {
  /**
   * @generated from field: uint64 limit = 1;
   */
  limit = protoInt64.zero;

  /**
   * @generated from field: uint64 offset = 2;
   */
  offset = protoInt64.zero;

  constructor(data?: PartialMessage<ListRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.ListRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "limit", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
    { no: 2, name: "offset", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): ListRequest {
    return new ListRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): ListRequest {
    return new ListRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): ListRequest {
    return new ListRequest().fromJsonString(jsonString, options);
  }

  static equals(a: ListRequest | PlainMessage<ListRequest> | undefined, b: ListRequest | PlainMessage<ListRequest> | undefined): boolean {
    return proto3.util.equals(ListRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.ListResponse
 */
export class ListResponse extends Message<ListResponse> {
  /**
   * @generated from field: uint64 totalRecords = 2;
   */
  totalRecords = protoInt64.zero;

  /**
   * @generated from field: repeated media_requests.v1.Media results = 1;
   */
  results: Media[] = [];

  constructor(data?: PartialMessage<ListResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.ListResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 2, name: "totalRecords", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
    { no: 1, name: "results", kind: "message", T: Media, repeated: true },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): ListResponse {
    return new ListResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): ListResponse {
    return new ListResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): ListResponse {
    return new ListResponse().fromJsonString(jsonString, options);
  }

  static equals(a: ListResponse | PlainMessage<ListResponse> | undefined, b: ListResponse | PlainMessage<ListResponse> | undefined): boolean {
    return proto3.util.equals(ListResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.DeleteRequest
 */
export class DeleteRequest extends Message<DeleteRequest> {
  /**
   * @generated from field: uint64 requestId = 1;
   */
  requestId = protoInt64.zero;

  constructor(data?: PartialMessage<DeleteRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.DeleteRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "requestId", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): DeleteRequest {
    return new DeleteRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): DeleteRequest {
    return new DeleteRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): DeleteRequest {
    return new DeleteRequest().fromJsonString(jsonString, options);
  }

  static equals(a: DeleteRequest | PlainMessage<DeleteRequest> | undefined, b: DeleteRequest | PlainMessage<DeleteRequest> | undefined): boolean {
    return proto3.util.equals(DeleteRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.DeleteResponse
 */
export class DeleteResponse extends Message<DeleteResponse> {
  constructor(data?: PartialMessage<DeleteResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.DeleteResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): DeleteResponse {
    return new DeleteResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): DeleteResponse {
    return new DeleteResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): DeleteResponse {
    return new DeleteResponse().fromJsonString(jsonString, options);
  }

  static equals(a: DeleteResponse | PlainMessage<DeleteResponse> | undefined, b: DeleteResponse | PlainMessage<DeleteResponse> | undefined): boolean {
    return proto3.util.equals(DeleteResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.EditRequest
 */
export class EditRequest extends Message<EditRequest> {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;

  constructor(data?: PartialMessage<EditRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.EditRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "media", kind: "message", T: Media },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): EditRequest {
    return new EditRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): EditRequest {
    return new EditRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): EditRequest {
    return new EditRequest().fromJsonString(jsonString, options);
  }

  static equals(a: EditRequest | PlainMessage<EditRequest> | undefined, b: EditRequest | PlainMessage<EditRequest> | undefined): boolean {
    return proto3.util.equals(EditRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.EditResponse
 */
export class EditResponse extends Message<EditResponse> {
  constructor(data?: PartialMessage<EditResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.EditResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): EditResponse {
    return new EditResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): EditResponse {
    return new EditResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): EditResponse {
    return new EditResponse().fromJsonString(jsonString, options);
  }

  static equals(a: EditResponse | PlainMessage<EditResponse> | undefined, b: EditResponse | PlainMessage<EditResponse> | undefined): boolean {
    return proto3.util.equals(EditResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.ExistsRequest
 */
export class ExistsRequest extends Message<ExistsRequest> {
  /**
   * @generated from field: uint64 mamId = 1;
   */
  mamId = protoInt64.zero;

  constructor(data?: PartialMessage<ExistsRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.ExistsRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "mamId", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): ExistsRequest {
    return new ExistsRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): ExistsRequest {
    return new ExistsRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): ExistsRequest {
    return new ExistsRequest().fromJsonString(jsonString, options);
  }

  static equals(a: ExistsRequest | PlainMessage<ExistsRequest> | undefined, b: ExistsRequest | PlainMessage<ExistsRequest> | undefined): boolean {
    return proto3.util.equals(ExistsRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.ExistsResponse
 */
export class ExistsResponse extends Message<ExistsResponse> {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;

  constructor(data?: PartialMessage<ExistsResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.ExistsResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "media", kind: "message", T: Media },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): ExistsResponse {
    return new ExistsResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): ExistsResponse {
    return new ExistsResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): ExistsResponse {
    return new ExistsResponse().fromJsonString(jsonString, options);
  }

  static equals(a: ExistsResponse | PlainMessage<ExistsResponse> | undefined, b: ExistsResponse | PlainMessage<ExistsResponse> | undefined): boolean {
    return proto3.util.equals(ExistsResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.RetryRequest
 */
export class RetryRequest extends Message<RetryRequest> {
  /**
   * @generated from field: uint64 ID = 1;
   */
  ID = protoInt64.zero;

  constructor(data?: PartialMessage<RetryRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.RetryRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "ID", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): RetryRequest {
    return new RetryRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): RetryRequest {
    return new RetryRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): RetryRequest {
    return new RetryRequest().fromJsonString(jsonString, options);
  }

  static equals(a: RetryRequest | PlainMessage<RetryRequest> | undefined, b: RetryRequest | PlainMessage<RetryRequest> | undefined): boolean {
    return proto3.util.equals(RetryRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.RetryResponse
 */
export class RetryResponse extends Message<RetryResponse> {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;

  constructor(data?: PartialMessage<RetryResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.RetryResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "media", kind: "message", T: Media },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): RetryResponse {
    return new RetryResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): RetryResponse {
    return new RetryResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): RetryResponse {
    return new RetryResponse().fromJsonString(jsonString, options);
  }

  static equals(a: RetryResponse | PlainMessage<RetryResponse> | undefined, b: RetryResponse | PlainMessage<RetryResponse> | undefined): boolean {
    return proto3.util.equals(RetryResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.AddMediaRequest
 */
export class AddMediaRequest extends Message<AddMediaRequest> {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;

  constructor(data?: PartialMessage<AddMediaRequest>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.AddMediaRequest";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "media", kind: "message", T: Media },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): AddMediaRequest {
    return new AddMediaRequest().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): AddMediaRequest {
    return new AddMediaRequest().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): AddMediaRequest {
    return new AddMediaRequest().fromJsonString(jsonString, options);
  }

  static equals(a: AddMediaRequest | PlainMessage<AddMediaRequest> | undefined, b: AddMediaRequest | PlainMessage<AddMediaRequest> | undefined): boolean {
    return proto3.util.equals(AddMediaRequest, a, b);
  }
}

/**
 * @generated from message media_requests.v1.AddMediaResponse
 */
export class AddMediaResponse extends Message<AddMediaResponse> {
  constructor(data?: PartialMessage<AddMediaResponse>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.AddMediaResponse";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): AddMediaResponse {
    return new AddMediaResponse().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): AddMediaResponse {
    return new AddMediaResponse().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): AddMediaResponse {
    return new AddMediaResponse().fromJsonString(jsonString, options);
  }

  static equals(a: AddMediaResponse | PlainMessage<AddMediaResponse> | undefined, b: AddMediaResponse | PlainMessage<AddMediaResponse> | undefined): boolean {
    return proto3.util.equals(AddMediaResponse, a, b);
  }
}

/**
 * @generated from message media_requests.v1.Media
 */
export class Media extends Message<Media> {
  /**
   * @generated from field: uint64 ID = 1;
   */
  ID = protoInt64.zero;

  /**
   * @generated from field: string author = 2;
   */
  author = "";

  /**
   * @generated from field: string book = 3;
   */
  book = "";

  /**
   * @generated from field: string series = 4;
   */
  series = "";

  /**
   * @generated from field: uint32 series_number = 5;
   */
  seriesNumber = 0;

  /**
   * @generated from field: string category = 6;
   */
  category = "";

  /**
   * @generated from field: uint64 mam_book_id = 7;
   */
  mamBookId = protoInt64.zero;

  /**
   * @generated from field: string file_link = 12;
   */
  fileLink = "";

  /**
   * @generated from field: string status = 8;
   */
  status = "";

  /**
   * @generated from field: string torrent_id = 9;
   */
  torrentId = "";

  /**
   * @generated from field: uint32 time_running = 10;
   */
  timeRunning = 0;

  /**
   * @generated from field: string torrent_file_location = 11;
   */
  torrentFileLocation = "";

  /**
   * @generated from field: string createdAt = 13;
   */
  createdAt = "";

  constructor(data?: PartialMessage<Media>) {
    super();
    proto3.util.initPartial(data, this);
  }

  static readonly runtime: typeof proto3 = proto3;
  static readonly typeName = "media_requests.v1.Media";
  static readonly fields: FieldList = proto3.util.newFieldList(() => [
    { no: 1, name: "ID", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
    { no: 2, name: "author", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 3, name: "book", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 4, name: "series", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 5, name: "series_number", kind: "scalar", T: 13 /* ScalarType.UINT32 */ },
    { no: 6, name: "category", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 7, name: "mam_book_id", kind: "scalar", T: 4 /* ScalarType.UINT64 */ },
    { no: 12, name: "file_link", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 8, name: "status", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 9, name: "torrent_id", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 10, name: "time_running", kind: "scalar", T: 13 /* ScalarType.UINT32 */ },
    { no: 11, name: "torrent_file_location", kind: "scalar", T: 9 /* ScalarType.STRING */ },
    { no: 13, name: "createdAt", kind: "scalar", T: 9 /* ScalarType.STRING */ },
  ]);

  static fromBinary(bytes: Uint8Array, options?: Partial<BinaryReadOptions>): Media {
    return new Media().fromBinary(bytes, options);
  }

  static fromJson(jsonValue: JsonValue, options?: Partial<JsonReadOptions>): Media {
    return new Media().fromJson(jsonValue, options);
  }

  static fromJsonString(jsonString: string, options?: Partial<JsonReadOptions>): Media {
    return new Media().fromJsonString(jsonString, options);
  }

  static equals(a: Media | PlainMessage<Media> | undefined, b: Media | PlainMessage<Media> | undefined): boolean {
    return proto3.util.equals(Media, a, b);
  }
}

