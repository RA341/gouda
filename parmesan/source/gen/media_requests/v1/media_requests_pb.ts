// @generated by protoc-gen-es v2.2.3 with parameter "target=ts"
// @generated from file media_requests/v1/media_requests.proto (package media_requests.v1, syntax proto3)
/* eslint-disable */

import type { GenFile, GenMessage, GenService } from "@bufbuild/protobuf/codegenv1";
import { fileDesc, messageDesc, serviceDesc } from "@bufbuild/protobuf/codegenv1";
import type { Message } from "@bufbuild/protobuf";

/**
 * Describes the file media_requests/v1/media_requests.proto.
 */
export const file_media_requests_v1_media_requests: GenFile = /*@__PURE__*/
  fileDesc("CiZtZWRpYV9yZXF1ZXN0cy92MS9tZWRpYV9yZXF1ZXN0cy5wcm90bxIRbWVkaWFfcmVxdWVzdHMudjEiIwoNU2VhcmNoUmVxdWVzdBISCgptZWRpYVF1ZXJ5GAEgASgJIjsKDlNlYXJjaFJlc3BvbnNlEikKB3Jlc3VsdHMYASADKAsyGC5tZWRpYV9yZXF1ZXN0cy52MS5NZWRpYSIsCgtMaXN0UmVxdWVzdBINCgVsaW1pdBgBIAEoBBIOCgZvZmZzZXQYAiABKAQiTwoMTGlzdFJlc3BvbnNlEhQKDHRvdGFsUmVjb3JkcxgCIAEoBBIpCgdyZXN1bHRzGAEgAygLMhgubWVkaWFfcmVxdWVzdHMudjEuTWVkaWEiIgoNRGVsZXRlUmVxdWVzdBIRCglyZXF1ZXN0SWQYASABKAQiEAoORGVsZXRlUmVzcG9uc2UiNgoLRWRpdFJlcXVlc3QSJwoFbWVkaWEYASABKAsyGC5tZWRpYV9yZXF1ZXN0cy52MS5NZWRpYSIOCgxFZGl0UmVzcG9uc2UiHgoNRXhpc3RzUmVxdWVzdBINCgVtYW1JZBgBIAEoBCI5Cg5FeGlzdHNSZXNwb25zZRInCgVtZWRpYRgBIAEoCzIYLm1lZGlhX3JlcXVlc3RzLnYxLk1lZGlhIhoKDFJldHJ5UmVxdWVzdBIKCgJJRBgBIAEoBCI4Cg1SZXRyeVJlc3BvbnNlEicKBW1lZGlhGAEgASgLMhgubWVkaWFfcmVxdWVzdHMudjEuTWVkaWEiOgoPQWRkTWVkaWFSZXF1ZXN0EicKBW1lZGlhGAEgASgLMhgubWVkaWFfcmVxdWVzdHMudjEuTWVkaWEiEgoQQWRkTWVkaWFSZXNwb25zZSL+AQoFTWVkaWESCgoCSUQYASABKAQSDgoGYXV0aG9yGAIgASgJEgwKBGJvb2sYAyABKAkSDgoGc2VyaWVzGAQgASgJEhUKDXNlcmllc19udW1iZXIYBSABKA0SEAoIY2F0ZWdvcnkYBiABKAkSEwoLbWFtX2Jvb2tfaWQYByABKAQSEQoJZmlsZV9saW5rGAwgASgJEg4KBnN0YXR1cxgIIAEoCRISCgp0b3JyZW50X2lkGAkgASgJEhQKDHRpbWVfcnVubmluZxgKIAEoDRIdChV0b3JyZW50X2ZpbGVfbG9jYXRpb24YCyABKAkSEQoJY3JlYXRlZEF0GA0gASgJMsMEChNNZWRpYVJlcXVlc3RTZXJ2aWNlEk8KBlNlYXJjaBIgLm1lZGlhX3JlcXVlc3RzLnYxLlNlYXJjaFJlcXVlc3QaIS5tZWRpYV9yZXF1ZXN0cy52MS5TZWFyY2hSZXNwb25zZSIAEkkKBExpc3QSHi5tZWRpYV9yZXF1ZXN0cy52MS5MaXN0UmVxdWVzdBofLm1lZGlhX3JlcXVlc3RzLnYxLkxpc3RSZXNwb25zZSIAEk8KBkRlbGV0ZRIgLm1lZGlhX3JlcXVlc3RzLnYxLkRlbGV0ZVJlcXVlc3QaIS5tZWRpYV9yZXF1ZXN0cy52MS5EZWxldGVSZXNwb25zZSIAEkkKBEVkaXQSHi5tZWRpYV9yZXF1ZXN0cy52MS5FZGl0UmVxdWVzdBofLm1lZGlhX3JlcXVlc3RzLnYxLkVkaXRSZXNwb25zZSIAEk8KBkV4aXN0cxIgLm1lZGlhX3JlcXVlc3RzLnYxLkV4aXN0c1JlcXVlc3QaIS5tZWRpYV9yZXF1ZXN0cy52MS5FeGlzdHNSZXNwb25zZSIAEkwKBVJldHJ5Eh8ubWVkaWFfcmVxdWVzdHMudjEuUmV0cnlSZXF1ZXN0GiAubWVkaWFfcmVxdWVzdHMudjEuUmV0cnlSZXNwb25zZSIAElUKCEFkZE1lZGlhEiIubWVkaWFfcmVxdWVzdHMudjEuQWRkTWVkaWFSZXF1ZXN0GiMubWVkaWFfcmVxdWVzdHMudjEuQWRkTWVkaWFSZXNwb25zZSIAQsABChVjb20ubWVkaWFfcmVxdWVzdHMudjFCEk1lZGlhUmVxdWVzdHNQcm90b1ABWjJnaXRodWIuY29tL1JBMzQxL2dvdWRhL2dlbmVyYXRlZC9tZWRpYV9yZXF1ZXN0cy92MaICA01YWKoCEE1lZGlhUmVxdWVzdHMuVjHKAhBNZWRpYVJlcXVlc3RzXFYx4gIcTWVkaWFSZXF1ZXN0c1xWMVxHUEJNZXRhZGF0YeoCEU1lZGlhUmVxdWVzdHM6OlYxYgZwcm90bzM");

/**
 * @generated from message media_requests.v1.SearchRequest
 */
export type SearchRequest = Message<"media_requests.v1.SearchRequest"> & {
  /**
   * @generated from field: string mediaQuery = 1;
   */
  mediaQuery: string;
};

/**
 * Describes the message media_requests.v1.SearchRequest.
 * Use `create(SearchRequestSchema)` to create a new message.
 */
export const SearchRequestSchema: GenMessage<SearchRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 0);

/**
 * @generated from message media_requests.v1.SearchResponse
 */
export type SearchResponse = Message<"media_requests.v1.SearchResponse"> & {
  /**
   * @generated from field: repeated media_requests.v1.Media results = 1;
   */
  results: Media[];
};

/**
 * Describes the message media_requests.v1.SearchResponse.
 * Use `create(SearchResponseSchema)` to create a new message.
 */
export const SearchResponseSchema: GenMessage<SearchResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 1);

/**
 * @generated from message media_requests.v1.ListRequest
 */
export type ListRequest = Message<"media_requests.v1.ListRequest"> & {
  /**
   * @generated from field: uint64 limit = 1;
   */
  limit: bigint;

  /**
   * @generated from field: uint64 offset = 2;
   */
  offset: bigint;
};

/**
 * Describes the message media_requests.v1.ListRequest.
 * Use `create(ListRequestSchema)` to create a new message.
 */
export const ListRequestSchema: GenMessage<ListRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 2);

/**
 * @generated from message media_requests.v1.ListResponse
 */
export type ListResponse = Message<"media_requests.v1.ListResponse"> & {
  /**
   * @generated from field: uint64 totalRecords = 2;
   */
  totalRecords: bigint;

  /**
   * @generated from field: repeated media_requests.v1.Media results = 1;
   */
  results: Media[];
};

/**
 * Describes the message media_requests.v1.ListResponse.
 * Use `create(ListResponseSchema)` to create a new message.
 */
export const ListResponseSchema: GenMessage<ListResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 3);

/**
 * @generated from message media_requests.v1.DeleteRequest
 */
export type DeleteRequest = Message<"media_requests.v1.DeleteRequest"> & {
  /**
   * @generated from field: uint64 requestId = 1;
   */
  requestId: bigint;
};

/**
 * Describes the message media_requests.v1.DeleteRequest.
 * Use `create(DeleteRequestSchema)` to create a new message.
 */
export const DeleteRequestSchema: GenMessage<DeleteRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 4);

/**
 * @generated from message media_requests.v1.DeleteResponse
 */
export type DeleteResponse = Message<"media_requests.v1.DeleteResponse"> & {
};

/**
 * Describes the message media_requests.v1.DeleteResponse.
 * Use `create(DeleteResponseSchema)` to create a new message.
 */
export const DeleteResponseSchema: GenMessage<DeleteResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 5);

/**
 * @generated from message media_requests.v1.EditRequest
 */
export type EditRequest = Message<"media_requests.v1.EditRequest"> & {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;
};

/**
 * Describes the message media_requests.v1.EditRequest.
 * Use `create(EditRequestSchema)` to create a new message.
 */
export const EditRequestSchema: GenMessage<EditRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 6);

/**
 * @generated from message media_requests.v1.EditResponse
 */
export type EditResponse = Message<"media_requests.v1.EditResponse"> & {
};

/**
 * Describes the message media_requests.v1.EditResponse.
 * Use `create(EditResponseSchema)` to create a new message.
 */
export const EditResponseSchema: GenMessage<EditResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 7);

/**
 * @generated from message media_requests.v1.ExistsRequest
 */
export type ExistsRequest = Message<"media_requests.v1.ExistsRequest"> & {
  /**
   * @generated from field: uint64 mamId = 1;
   */
  mamId: bigint;
};

/**
 * Describes the message media_requests.v1.ExistsRequest.
 * Use `create(ExistsRequestSchema)` to create a new message.
 */
export const ExistsRequestSchema: GenMessage<ExistsRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 8);

/**
 * @generated from message media_requests.v1.ExistsResponse
 */
export type ExistsResponse = Message<"media_requests.v1.ExistsResponse"> & {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;
};

/**
 * Describes the message media_requests.v1.ExistsResponse.
 * Use `create(ExistsResponseSchema)` to create a new message.
 */
export const ExistsResponseSchema: GenMessage<ExistsResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 9);

/**
 * @generated from message media_requests.v1.RetryRequest
 */
export type RetryRequest = Message<"media_requests.v1.RetryRequest"> & {
  /**
   * @generated from field: uint64 ID = 1;
   */
  ID: bigint;
};

/**
 * Describes the message media_requests.v1.RetryRequest.
 * Use `create(RetryRequestSchema)` to create a new message.
 */
export const RetryRequestSchema: GenMessage<RetryRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 10);

/**
 * @generated from message media_requests.v1.RetryResponse
 */
export type RetryResponse = Message<"media_requests.v1.RetryResponse"> & {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;
};

/**
 * Describes the message media_requests.v1.RetryResponse.
 * Use `create(RetryResponseSchema)` to create a new message.
 */
export const RetryResponseSchema: GenMessage<RetryResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 11);

/**
 * @generated from message media_requests.v1.AddMediaRequest
 */
export type AddMediaRequest = Message<"media_requests.v1.AddMediaRequest"> & {
  /**
   * @generated from field: media_requests.v1.Media media = 1;
   */
  media?: Media;
};

/**
 * Describes the message media_requests.v1.AddMediaRequest.
 * Use `create(AddMediaRequestSchema)` to create a new message.
 */
export const AddMediaRequestSchema: GenMessage<AddMediaRequest> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 12);

/**
 * @generated from message media_requests.v1.AddMediaResponse
 */
export type AddMediaResponse = Message<"media_requests.v1.AddMediaResponse"> & {
};

/**
 * Describes the message media_requests.v1.AddMediaResponse.
 * Use `create(AddMediaResponseSchema)` to create a new message.
 */
export const AddMediaResponseSchema: GenMessage<AddMediaResponse> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 13);

/**
 * @generated from message media_requests.v1.Media
 */
export type Media = Message<"media_requests.v1.Media"> & {
  /**
   * @generated from field: uint64 ID = 1;
   */
  ID: bigint;

  /**
   * @generated from field: string author = 2;
   */
  author: string;

  /**
   * @generated from field: string book = 3;
   */
  book: string;

  /**
   * @generated from field: string series = 4;
   */
  series: string;

  /**
   * @generated from field: uint32 series_number = 5;
   */
  seriesNumber: number;

  /**
   * @generated from field: string category = 6;
   */
  category: string;

  /**
   * @generated from field: uint64 mam_book_id = 7;
   */
  mamBookId: bigint;

  /**
   * @generated from field: string file_link = 12;
   */
  fileLink: string;

  /**
   * @generated from field: string status = 8;
   */
  status: string;

  /**
   * @generated from field: string torrent_id = 9;
   */
  torrentId: string;

  /**
   * @generated from field: uint32 time_running = 10;
   */
  timeRunning: number;

  /**
   * @generated from field: string torrent_file_location = 11;
   */
  torrentFileLocation: string;

  /**
   * @generated from field: string createdAt = 13;
   */
  createdAt: string;
};

/**
 * Describes the message media_requests.v1.Media.
 * Use `create(MediaSchema)` to create a new message.
 */
export const MediaSchema: GenMessage<Media> = /*@__PURE__*/
  messageDesc(file_media_requests_v1_media_requests, 14);

/**
 * @generated from service media_requests.v1.MediaRequestService
 */
export const MediaRequestService: GenService<{
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.Search
   */
  search: {
    methodKind: "unary";
    input: typeof SearchRequestSchema;
    output: typeof SearchResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.List
   */
  list: {
    methodKind: "unary";
    input: typeof ListRequestSchema;
    output: typeof ListResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.Delete
   */
  delete: {
    methodKind: "unary";
    input: typeof DeleteRequestSchema;
    output: typeof DeleteResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.Edit
   */
  edit: {
    methodKind: "unary";
    input: typeof EditRequestSchema;
    output: typeof EditResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.Exists
   */
  exists: {
    methodKind: "unary";
    input: typeof ExistsRequestSchema;
    output: typeof ExistsResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.Retry
   */
  retry: {
    methodKind: "unary";
    input: typeof RetryRequestSchema;
    output: typeof RetryResponseSchema;
  },
  /**
   * @generated from rpc media_requests.v1.MediaRequestService.AddMedia
   */
  addMedia: {
    methodKind: "unary";
    input: typeof AddMediaRequestSchema;
    output: typeof AddMediaResponseSchema;
  },
}> = /*@__PURE__*/
  serviceDesc(file_media_requests_v1_media_requests, 0);

