// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.1
// 	protoc        (unknown)
// source: media_requests/v1/media_requests.proto

package v1

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type SearchRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	MediaQuery    string                 `protobuf:"bytes,1,opt,name=mediaQuery,proto3" json:"mediaQuery,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *SearchRequest) Reset() {
	*x = SearchRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SearchRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SearchRequest) ProtoMessage() {}

func (x *SearchRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SearchRequest.ProtoReflect.Descriptor instead.
func (*SearchRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{0}
}

func (x *SearchRequest) GetMediaQuery() string {
	if x != nil {
		return x.MediaQuery
	}
	return ""
}

type SearchResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Results       []*Media               `protobuf:"bytes,1,rep,name=results,proto3" json:"results,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *SearchResponse) Reset() {
	*x = SearchResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *SearchResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*SearchResponse) ProtoMessage() {}

func (x *SearchResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use SearchResponse.ProtoReflect.Descriptor instead.
func (*SearchResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{1}
}

func (x *SearchResponse) GetResults() []*Media {
	if x != nil {
		return x.Results
	}
	return nil
}

type ListRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Limit         uint64                 `protobuf:"varint,1,opt,name=limit,proto3" json:"limit,omitempty"`
	Offset        uint64                 `protobuf:"varint,2,opt,name=offset,proto3" json:"offset,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ListRequest) Reset() {
	*x = ListRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[2]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ListRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListRequest) ProtoMessage() {}

func (x *ListRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[2]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListRequest.ProtoReflect.Descriptor instead.
func (*ListRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{2}
}

func (x *ListRequest) GetLimit() uint64 {
	if x != nil {
		return x.Limit
	}
	return 0
}

func (x *ListRequest) GetOffset() uint64 {
	if x != nil {
		return x.Offset
	}
	return 0
}

type ListResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	TotalRecords  uint64                 `protobuf:"varint,2,opt,name=totalRecords,proto3" json:"totalRecords,omitempty"`
	Results       []*Media               `protobuf:"bytes,1,rep,name=results,proto3" json:"results,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ListResponse) Reset() {
	*x = ListResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[3]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ListResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListResponse) ProtoMessage() {}

func (x *ListResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[3]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListResponse.ProtoReflect.Descriptor instead.
func (*ListResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{3}
}

func (x *ListResponse) GetTotalRecords() uint64 {
	if x != nil {
		return x.TotalRecords
	}
	return 0
}

func (x *ListResponse) GetResults() []*Media {
	if x != nil {
		return x.Results
	}
	return nil
}

type DeleteRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	RequestId     uint64                 `protobuf:"varint,1,opt,name=requestId,proto3" json:"requestId,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *DeleteRequest) Reset() {
	*x = DeleteRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[4]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *DeleteRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*DeleteRequest) ProtoMessage() {}

func (x *DeleteRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[4]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use DeleteRequest.ProtoReflect.Descriptor instead.
func (*DeleteRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{4}
}

func (x *DeleteRequest) GetRequestId() uint64 {
	if x != nil {
		return x.RequestId
	}
	return 0
}

type DeleteResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *DeleteResponse) Reset() {
	*x = DeleteResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[5]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *DeleteResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*DeleteResponse) ProtoMessage() {}

func (x *DeleteResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[5]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use DeleteResponse.ProtoReflect.Descriptor instead.
func (*DeleteResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{5}
}

type EditRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Media         *Media                 `protobuf:"bytes,1,opt,name=media,proto3" json:"media,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *EditRequest) Reset() {
	*x = EditRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[6]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *EditRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EditRequest) ProtoMessage() {}

func (x *EditRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[6]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EditRequest.ProtoReflect.Descriptor instead.
func (*EditRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{6}
}

func (x *EditRequest) GetMedia() *Media {
	if x != nil {
		return x.Media
	}
	return nil
}

type EditResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *EditResponse) Reset() {
	*x = EditResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[7]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *EditResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EditResponse) ProtoMessage() {}

func (x *EditResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[7]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EditResponse.ProtoReflect.Descriptor instead.
func (*EditResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{7}
}

type ExistsRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	MamId         uint64                 `protobuf:"varint,1,opt,name=mamId,proto3" json:"mamId,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ExistsRequest) Reset() {
	*x = ExistsRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[8]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ExistsRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ExistsRequest) ProtoMessage() {}

func (x *ExistsRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[8]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ExistsRequest.ProtoReflect.Descriptor instead.
func (*ExistsRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{8}
}

func (x *ExistsRequest) GetMamId() uint64 {
	if x != nil {
		return x.MamId
	}
	return 0
}

type ExistsResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Media         *Media                 `protobuf:"bytes,1,opt,name=media,proto3" json:"media,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ExistsResponse) Reset() {
	*x = ExistsResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[9]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ExistsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ExistsResponse) ProtoMessage() {}

func (x *ExistsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[9]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ExistsResponse.ProtoReflect.Descriptor instead.
func (*ExistsResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{9}
}

func (x *ExistsResponse) GetMedia() *Media {
	if x != nil {
		return x.Media
	}
	return nil
}

type RetryRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	ID            uint64                 `protobuf:"varint,1,opt,name=ID,proto3" json:"ID,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *RetryRequest) Reset() {
	*x = RetryRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[10]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *RetryRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*RetryRequest) ProtoMessage() {}

func (x *RetryRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[10]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use RetryRequest.ProtoReflect.Descriptor instead.
func (*RetryRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{10}
}

func (x *RetryRequest) GetID() uint64 {
	if x != nil {
		return x.ID
	}
	return 0
}

type RetryResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Media         *Media                 `protobuf:"bytes,1,opt,name=media,proto3" json:"media,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *RetryResponse) Reset() {
	*x = RetryResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[11]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *RetryResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*RetryResponse) ProtoMessage() {}

func (x *RetryResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[11]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use RetryResponse.ProtoReflect.Descriptor instead.
func (*RetryResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{11}
}

func (x *RetryResponse) GetMedia() *Media {
	if x != nil {
		return x.Media
	}
	return nil
}

type AddMediaRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Media         *Media                 `protobuf:"bytes,1,opt,name=media,proto3" json:"media,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *AddMediaRequest) Reset() {
	*x = AddMediaRequest{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[12]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *AddMediaRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*AddMediaRequest) ProtoMessage() {}

func (x *AddMediaRequest) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[12]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use AddMediaRequest.ProtoReflect.Descriptor instead.
func (*AddMediaRequest) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{12}
}

func (x *AddMediaRequest) GetMedia() *Media {
	if x != nil {
		return x.Media
	}
	return nil
}

type AddMediaResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *AddMediaResponse) Reset() {
	*x = AddMediaResponse{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[13]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *AddMediaResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*AddMediaResponse) ProtoMessage() {}

func (x *AddMediaResponse) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[13]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use AddMediaResponse.ProtoReflect.Descriptor instead.
func (*AddMediaResponse) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{13}
}

type Media struct {
	state               protoimpl.MessageState `protogen:"open.v1"`
	ID                  uint64                 `protobuf:"varint,1,opt,name=ID,proto3" json:"ID,omitempty"`
	Author              string                 `protobuf:"bytes,2,opt,name=author,proto3" json:"author,omitempty"`
	Book                string                 `protobuf:"bytes,3,opt,name=book,proto3" json:"book,omitempty"`
	Series              string                 `protobuf:"bytes,4,opt,name=series,proto3" json:"series,omitempty"`
	SeriesNumber        uint32                 `protobuf:"varint,5,opt,name=series_number,json=seriesNumber,proto3" json:"series_number,omitempty"`
	Category            string                 `protobuf:"bytes,6,opt,name=category,proto3" json:"category,omitempty"`
	MamBookId           uint64                 `protobuf:"varint,7,opt,name=mam_book_id,json=mamBookId,proto3" json:"mam_book_id,omitempty"`
	FileLink            string                 `protobuf:"bytes,12,opt,name=file_link,json=fileLink,proto3" json:"file_link,omitempty"`
	Status              string                 `protobuf:"bytes,8,opt,name=status,proto3" json:"status,omitempty"`
	TorrentId           string                 `protobuf:"bytes,9,opt,name=torrent_id,json=torrentId,proto3" json:"torrent_id,omitempty"`
	TimeRunning         uint32                 `protobuf:"varint,10,opt,name=time_running,json=timeRunning,proto3" json:"time_running,omitempty"`
	TorrentFileLocation string                 `protobuf:"bytes,11,opt,name=torrent_file_location,json=torrentFileLocation,proto3" json:"torrent_file_location,omitempty"`
	CreatedAt           string                 `protobuf:"bytes,13,opt,name=createdAt,proto3" json:"createdAt,omitempty"`
	unknownFields       protoimpl.UnknownFields
	sizeCache           protoimpl.SizeCache
}

func (x *Media) Reset() {
	*x = Media{}
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[14]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *Media) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Media) ProtoMessage() {}

func (x *Media) ProtoReflect() protoreflect.Message {
	mi := &file_media_requests_v1_media_requests_proto_msgTypes[14]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Media.ProtoReflect.Descriptor instead.
func (*Media) Descriptor() ([]byte, []int) {
	return file_media_requests_v1_media_requests_proto_rawDescGZIP(), []int{14}
}

func (x *Media) GetID() uint64 {
	if x != nil {
		return x.ID
	}
	return 0
}

func (x *Media) GetAuthor() string {
	if x != nil {
		return x.Author
	}
	return ""
}

func (x *Media) GetBook() string {
	if x != nil {
		return x.Book
	}
	return ""
}

func (x *Media) GetSeries() string {
	if x != nil {
		return x.Series
	}
	return ""
}

func (x *Media) GetSeriesNumber() uint32 {
	if x != nil {
		return x.SeriesNumber
	}
	return 0
}

func (x *Media) GetCategory() string {
	if x != nil {
		return x.Category
	}
	return ""
}

func (x *Media) GetMamBookId() uint64 {
	if x != nil {
		return x.MamBookId
	}
	return 0
}

func (x *Media) GetFileLink() string {
	if x != nil {
		return x.FileLink
	}
	return ""
}

func (x *Media) GetStatus() string {
	if x != nil {
		return x.Status
	}
	return ""
}

func (x *Media) GetTorrentId() string {
	if x != nil {
		return x.TorrentId
	}
	return ""
}

func (x *Media) GetTimeRunning() uint32 {
	if x != nil {
		return x.TimeRunning
	}
	return 0
}

func (x *Media) GetTorrentFileLocation() string {
	if x != nil {
		return x.TorrentFileLocation
	}
	return ""
}

func (x *Media) GetCreatedAt() string {
	if x != nil {
		return x.CreatedAt
	}
	return ""
}

var File_media_requests_v1_media_requests_proto protoreflect.FileDescriptor

var file_media_requests_v1_media_requests_proto_rawDesc = []byte{
	0x0a, 0x26, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73,
	0x2f, 0x76, 0x31, 0x2f, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x11, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f,
	0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x22, 0x2f, 0x0a, 0x0d, 0x53,
	0x65, 0x61, 0x72, 0x63, 0x68, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x1e, 0x0a, 0x0a,
	0x6d, 0x65, 0x64, 0x69, 0x61, 0x51, 0x75, 0x65, 0x72, 0x79, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x0a, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x51, 0x75, 0x65, 0x72, 0x79, 0x22, 0x44, 0x0a, 0x0e,
	0x53, 0x65, 0x61, 0x72, 0x63, 0x68, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x32,
	0x0a, 0x07, 0x72, 0x65, 0x73, 0x75, 0x6c, 0x74, 0x73, 0x18, 0x01, 0x20, 0x03, 0x28, 0x0b, 0x32,
	0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73,
	0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x07, 0x72, 0x65, 0x73, 0x75, 0x6c,
	0x74, 0x73, 0x22, 0x3b, 0x0a, 0x0b, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x12, 0x14, 0x0a, 0x05, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x05, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x12, 0x16, 0x0a, 0x06, 0x6f, 0x66, 0x66, 0x73, 0x65,
	0x74, 0x18, 0x02, 0x20, 0x01, 0x28, 0x04, 0x52, 0x06, 0x6f, 0x66, 0x66, 0x73, 0x65, 0x74, 0x22,
	0x66, 0x0a, 0x0c, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12,
	0x22, 0x0a, 0x0c, 0x74, 0x6f, 0x74, 0x61, 0x6c, 0x52, 0x65, 0x63, 0x6f, 0x72, 0x64, 0x73, 0x18,
	0x02, 0x20, 0x01, 0x28, 0x04, 0x52, 0x0c, 0x74, 0x6f, 0x74, 0x61, 0x6c, 0x52, 0x65, 0x63, 0x6f,
	0x72, 0x64, 0x73, 0x12, 0x32, 0x0a, 0x07, 0x72, 0x65, 0x73, 0x75, 0x6c, 0x74, 0x73, 0x18, 0x01,
	0x20, 0x03, 0x28, 0x0b, 0x32, 0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x07,
	0x72, 0x65, 0x73, 0x75, 0x6c, 0x74, 0x73, 0x22, 0x2d, 0x0a, 0x0d, 0x44, 0x65, 0x6c, 0x65, 0x74,
	0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x1c, 0x0a, 0x09, 0x72, 0x65, 0x71, 0x75,
	0x65, 0x73, 0x74, 0x49, 0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x09, 0x72, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x49, 0x64, 0x22, 0x10, 0x0a, 0x0e, 0x44, 0x65, 0x6c, 0x65, 0x74, 0x65,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x3d, 0x0a, 0x0b, 0x45, 0x64, 0x69, 0x74,
	0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x2e, 0x0a, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61,
	0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72,
	0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61,
	0x52, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x22, 0x0e, 0x0a, 0x0c, 0x45, 0x64, 0x69, 0x74, 0x52,
	0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x25, 0x0a, 0x0d, 0x45, 0x78, 0x69, 0x73, 0x74,
	0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x14, 0x0a, 0x05, 0x6d, 0x61, 0x6d, 0x49,
	0x64, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x05, 0x6d, 0x61, 0x6d, 0x49, 0x64, 0x22, 0x40,
	0x0a, 0x0e, 0x45, 0x78, 0x69, 0x73, 0x74, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65,
	0x12, 0x2e, 0x0a, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32,
	0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73,
	0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61,
	0x22, 0x1e, 0x0a, 0x0c, 0x52, 0x65, 0x74, 0x72, 0x79, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x12, 0x0e, 0x0a, 0x02, 0x49, 0x44, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x02, 0x49, 0x44,
	0x22, 0x3f, 0x0a, 0x0d, 0x52, 0x65, 0x74, 0x72, 0x79, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73,
	0x65, 0x12, 0x2e, 0x0a, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b,
	0x32, 0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x05, 0x6d, 0x65, 0x64, 0x69,
	0x61, 0x22, 0x41, 0x0a, 0x0f, 0x41, 0x64, 0x64, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x12, 0x2e, 0x0a, 0x05, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x0b, 0x32, 0x18, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75,
	0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x05, 0x6d,
	0x65, 0x64, 0x69, 0x61, 0x22, 0x12, 0x0a, 0x10, 0x41, 0x64, 0x64, 0x4d, 0x65, 0x64, 0x69, 0x61,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x85, 0x03, 0x0a, 0x05, 0x4d, 0x65, 0x64,
	0x69, 0x61, 0x12, 0x0e, 0x0a, 0x02, 0x49, 0x44, 0x18, 0x01, 0x20, 0x01, 0x28, 0x04, 0x52, 0x02,
	0x49, 0x44, 0x12, 0x16, 0x0a, 0x06, 0x61, 0x75, 0x74, 0x68, 0x6f, 0x72, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x06, 0x61, 0x75, 0x74, 0x68, 0x6f, 0x72, 0x12, 0x12, 0x0a, 0x04, 0x62, 0x6f,
	0x6f, 0x6b, 0x18, 0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x04, 0x62, 0x6f, 0x6f, 0x6b, 0x12, 0x16,
	0x0a, 0x06, 0x73, 0x65, 0x72, 0x69, 0x65, 0x73, 0x18, 0x04, 0x20, 0x01, 0x28, 0x09, 0x52, 0x06,
	0x73, 0x65, 0x72, 0x69, 0x65, 0x73, 0x12, 0x23, 0x0a, 0x0d, 0x73, 0x65, 0x72, 0x69, 0x65, 0x73,
	0x5f, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x18, 0x05, 0x20, 0x01, 0x28, 0x0d, 0x52, 0x0c, 0x73,
	0x65, 0x72, 0x69, 0x65, 0x73, 0x4e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x12, 0x1a, 0x0a, 0x08, 0x63,
	0x61, 0x74, 0x65, 0x67, 0x6f, 0x72, 0x79, 0x18, 0x06, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x63,
	0x61, 0x74, 0x65, 0x67, 0x6f, 0x72, 0x79, 0x12, 0x1e, 0x0a, 0x0b, 0x6d, 0x61, 0x6d, 0x5f, 0x62,
	0x6f, 0x6f, 0x6b, 0x5f, 0x69, 0x64, 0x18, 0x07, 0x20, 0x01, 0x28, 0x04, 0x52, 0x09, 0x6d, 0x61,
	0x6d, 0x42, 0x6f, 0x6f, 0x6b, 0x49, 0x64, 0x12, 0x1b, 0x0a, 0x09, 0x66, 0x69, 0x6c, 0x65, 0x5f,
	0x6c, 0x69, 0x6e, 0x6b, 0x18, 0x0c, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x66, 0x69, 0x6c, 0x65,
	0x4c, 0x69, 0x6e, 0x6b, 0x12, 0x16, 0x0a, 0x06, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x18, 0x08,
	0x20, 0x01, 0x28, 0x09, 0x52, 0x06, 0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x12, 0x1d, 0x0a, 0x0a,
	0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x69, 0x64, 0x18, 0x09, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x09, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x49, 0x64, 0x12, 0x21, 0x0a, 0x0c, 0x74,
	0x69, 0x6d, 0x65, 0x5f, 0x72, 0x75, 0x6e, 0x6e, 0x69, 0x6e, 0x67, 0x18, 0x0a, 0x20, 0x01, 0x28,
	0x0d, 0x52, 0x0b, 0x74, 0x69, 0x6d, 0x65, 0x52, 0x75, 0x6e, 0x6e, 0x69, 0x6e, 0x67, 0x12, 0x32,
	0x0a, 0x15, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x66, 0x69, 0x6c, 0x65, 0x5f, 0x6c,
	0x6f, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x18, 0x0b, 0x20, 0x01, 0x28, 0x09, 0x52, 0x13, 0x74,
	0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x46, 0x69, 0x6c, 0x65, 0x4c, 0x6f, 0x63, 0x61, 0x74, 0x69,
	0x6f, 0x6e, 0x12, 0x1c, 0x0a, 0x09, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x64, 0x41, 0x74, 0x18,
	0x0d, 0x20, 0x01, 0x28, 0x09, 0x52, 0x09, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x64, 0x41, 0x74,
	0x32, 0xc3, 0x04, 0x0a, 0x13, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x12, 0x4f, 0x0a, 0x06, 0x53, 0x65, 0x61, 0x72,
	0x63, 0x68, 0x12, 0x20, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x53, 0x65, 0x61, 0x72, 0x63, 0x68, 0x52, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x1a, 0x21, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x53, 0x65, 0x61, 0x72, 0x63, 0x68, 0x52,
	0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x12, 0x49, 0x0a, 0x04, 0x4c, 0x69, 0x73,
	0x74, 0x12, 0x1e, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x1a, 0x1f, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e,
	0x73, 0x65, 0x22, 0x00, 0x12, 0x4f, 0x0a, 0x06, 0x44, 0x65, 0x6c, 0x65, 0x74, 0x65, 0x12, 0x20,
	0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e,
	0x76, 0x31, 0x2e, 0x44, 0x65, 0x6c, 0x65, 0x74, 0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x1a, 0x21, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x73, 0x2e, 0x76, 0x31, 0x2e, 0x44, 0x65, 0x6c, 0x65, 0x74, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f,
	0x6e, 0x73, 0x65, 0x22, 0x00, 0x12, 0x49, 0x0a, 0x04, 0x45, 0x64, 0x69, 0x74, 0x12, 0x1e, 0x2e,
	0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76,
	0x31, 0x2e, 0x45, 0x64, 0x69, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x1f, 0x2e,
	0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76,
	0x31, 0x2e, 0x45, 0x64, 0x69, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00,
	0x12, 0x4f, 0x0a, 0x06, 0x45, 0x78, 0x69, 0x73, 0x74, 0x73, 0x12, 0x20, 0x2e, 0x6d, 0x65, 0x64,
	0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x45,
	0x78, 0x69, 0x73, 0x74, 0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x21, 0x2e, 0x6d,
	0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31,
	0x2e, 0x45, 0x78, 0x69, 0x73, 0x74, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22,
	0x00, 0x12, 0x4c, 0x0a, 0x05, 0x52, 0x65, 0x74, 0x72, 0x79, 0x12, 0x1f, 0x2e, 0x6d, 0x65, 0x64,
	0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x52,
	0x65, 0x74, 0x72, 0x79, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x20, 0x2e, 0x6d, 0x65,
	0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e,
	0x52, 0x65, 0x74, 0x72, 0x79, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x12,
	0x55, 0x0a, 0x08, 0x41, 0x64, 0x64, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x12, 0x22, 0x2e, 0x6d, 0x65,
	0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31, 0x2e,
	0x41, 0x64, 0x64, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a,
	0x23, 0x2e, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73,
	0x2e, 0x76, 0x31, 0x2e, 0x41, 0x64, 0x64, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x42, 0xc0, 0x01, 0x0a, 0x15, 0x63, 0x6f, 0x6d, 0x2e, 0x6d,
	0x65, 0x64, 0x69, 0x61, 0x5f, 0x72, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2e, 0x76, 0x31,
	0x42, 0x12, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x50,
	0x72, 0x6f, 0x74, 0x6f, 0x50, 0x01, 0x5a, 0x32, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63,
	0x6f, 0x6d, 0x2f, 0x52, 0x41, 0x33, 0x34, 0x31, 0x2f, 0x67, 0x6f, 0x75, 0x64, 0x61, 0x2f, 0x67,
	0x65, 0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x64, 0x2f, 0x6d, 0x65, 0x64, 0x69, 0x61, 0x5f, 0x72,
	0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x2f, 0x76, 0x31, 0xa2, 0x02, 0x03, 0x4d, 0x58, 0x58,
	0xaa, 0x02, 0x10, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x73,
	0x2e, 0x56, 0x31, 0xca, 0x02, 0x10, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71, 0x75, 0x65,
	0x73, 0x74, 0x73, 0x5c, 0x56, 0x31, 0xe2, 0x02, 0x1c, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65,
	0x71, 0x75, 0x65, 0x73, 0x74, 0x73, 0x5c, 0x56, 0x31, 0x5c, 0x47, 0x50, 0x42, 0x4d, 0x65, 0x74,
	0x61, 0x64, 0x61, 0x74, 0x61, 0xea, 0x02, 0x11, 0x4d, 0x65, 0x64, 0x69, 0x61, 0x52, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x73, 0x3a, 0x3a, 0x56, 0x31, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x33,
}

var (
	file_media_requests_v1_media_requests_proto_rawDescOnce sync.Once
	file_media_requests_v1_media_requests_proto_rawDescData = file_media_requests_v1_media_requests_proto_rawDesc
)

func file_media_requests_v1_media_requests_proto_rawDescGZIP() []byte {
	file_media_requests_v1_media_requests_proto_rawDescOnce.Do(func() {
		file_media_requests_v1_media_requests_proto_rawDescData = protoimpl.X.CompressGZIP(file_media_requests_v1_media_requests_proto_rawDescData)
	})
	return file_media_requests_v1_media_requests_proto_rawDescData
}

var file_media_requests_v1_media_requests_proto_msgTypes = make([]protoimpl.MessageInfo, 15)
var file_media_requests_v1_media_requests_proto_goTypes = []any{
	(*SearchRequest)(nil),    // 0: media_requests.v1.SearchRequest
	(*SearchResponse)(nil),   // 1: media_requests.v1.SearchResponse
	(*ListRequest)(nil),      // 2: media_requests.v1.ListRequest
	(*ListResponse)(nil),     // 3: media_requests.v1.ListResponse
	(*DeleteRequest)(nil),    // 4: media_requests.v1.DeleteRequest
	(*DeleteResponse)(nil),   // 5: media_requests.v1.DeleteResponse
	(*EditRequest)(nil),      // 6: media_requests.v1.EditRequest
	(*EditResponse)(nil),     // 7: media_requests.v1.EditResponse
	(*ExistsRequest)(nil),    // 8: media_requests.v1.ExistsRequest
	(*ExistsResponse)(nil),   // 9: media_requests.v1.ExistsResponse
	(*RetryRequest)(nil),     // 10: media_requests.v1.RetryRequest
	(*RetryResponse)(nil),    // 11: media_requests.v1.RetryResponse
	(*AddMediaRequest)(nil),  // 12: media_requests.v1.AddMediaRequest
	(*AddMediaResponse)(nil), // 13: media_requests.v1.AddMediaResponse
	(*Media)(nil),            // 14: media_requests.v1.Media
}
var file_media_requests_v1_media_requests_proto_depIdxs = []int32{
	14, // 0: media_requests.v1.SearchResponse.results:type_name -> media_requests.v1.Media
	14, // 1: media_requests.v1.ListResponse.results:type_name -> media_requests.v1.Media
	14, // 2: media_requests.v1.EditRequest.media:type_name -> media_requests.v1.Media
	14, // 3: media_requests.v1.ExistsResponse.media:type_name -> media_requests.v1.Media
	14, // 4: media_requests.v1.RetryResponse.media:type_name -> media_requests.v1.Media
	14, // 5: media_requests.v1.AddMediaRequest.media:type_name -> media_requests.v1.Media
	0,  // 6: media_requests.v1.MediaRequestService.Search:input_type -> media_requests.v1.SearchRequest
	2,  // 7: media_requests.v1.MediaRequestService.List:input_type -> media_requests.v1.ListRequest
	4,  // 8: media_requests.v1.MediaRequestService.Delete:input_type -> media_requests.v1.DeleteRequest
	6,  // 9: media_requests.v1.MediaRequestService.Edit:input_type -> media_requests.v1.EditRequest
	8,  // 10: media_requests.v1.MediaRequestService.Exists:input_type -> media_requests.v1.ExistsRequest
	10, // 11: media_requests.v1.MediaRequestService.Retry:input_type -> media_requests.v1.RetryRequest
	12, // 12: media_requests.v1.MediaRequestService.AddMedia:input_type -> media_requests.v1.AddMediaRequest
	1,  // 13: media_requests.v1.MediaRequestService.Search:output_type -> media_requests.v1.SearchResponse
	3,  // 14: media_requests.v1.MediaRequestService.List:output_type -> media_requests.v1.ListResponse
	5,  // 15: media_requests.v1.MediaRequestService.Delete:output_type -> media_requests.v1.DeleteResponse
	7,  // 16: media_requests.v1.MediaRequestService.Edit:output_type -> media_requests.v1.EditResponse
	9,  // 17: media_requests.v1.MediaRequestService.Exists:output_type -> media_requests.v1.ExistsResponse
	11, // 18: media_requests.v1.MediaRequestService.Retry:output_type -> media_requests.v1.RetryResponse
	13, // 19: media_requests.v1.MediaRequestService.AddMedia:output_type -> media_requests.v1.AddMediaResponse
	13, // [13:20] is the sub-list for method output_type
	6,  // [6:13] is the sub-list for method input_type
	6,  // [6:6] is the sub-list for extension type_name
	6,  // [6:6] is the sub-list for extension extendee
	0,  // [0:6] is the sub-list for field type_name
}

func init() { file_media_requests_v1_media_requests_proto_init() }
func file_media_requests_v1_media_requests_proto_init() {
	if File_media_requests_v1_media_requests_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_media_requests_v1_media_requests_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   15,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_media_requests_v1_media_requests_proto_goTypes,
		DependencyIndexes: file_media_requests_v1_media_requests_proto_depIdxs,
		MessageInfos:      file_media_requests_v1_media_requests_proto_msgTypes,
	}.Build()
	File_media_requests_v1_media_requests_proto = out.File
	file_media_requests_v1_media_requests_proto_rawDesc = nil
	file_media_requests_v1_media_requests_proto_goTypes = nil
	file_media_requests_v1_media_requests_proto_depIdxs = nil
}
