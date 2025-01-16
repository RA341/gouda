// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.2
// 	protoc        (unknown)
// source: settings/v1/settings.proto

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

type ListSupportedClientsRequest struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ListSupportedClientsRequest) Reset() {
	*x = ListSupportedClientsRequest{}
	mi := &file_settings_v1_settings_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ListSupportedClientsRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListSupportedClientsRequest) ProtoMessage() {}

func (x *ListSupportedClientsRequest) ProtoReflect() protoreflect.Message {
	mi := &file_settings_v1_settings_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListSupportedClientsRequest.ProtoReflect.Descriptor instead.
func (*ListSupportedClientsRequest) Descriptor() ([]byte, []int) {
	return file_settings_v1_settings_proto_rawDescGZIP(), []int{0}
}

type ListSupportedClientsResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	Clients       []string               `protobuf:"bytes,1,rep,name=clients,proto3" json:"clients,omitempty"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ListSupportedClientsResponse) Reset() {
	*x = ListSupportedClientsResponse{}
	mi := &file_settings_v1_settings_proto_msgTypes[1]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ListSupportedClientsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListSupportedClientsResponse) ProtoMessage() {}

func (x *ListSupportedClientsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_settings_v1_settings_proto_msgTypes[1]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListSupportedClientsResponse.ProtoReflect.Descriptor instead.
func (*ListSupportedClientsResponse) Descriptor() ([]byte, []int) {
	return file_settings_v1_settings_proto_rawDescGZIP(), []int{1}
}

func (x *ListSupportedClientsResponse) GetClients() []string {
	if x != nil {
		return x.Clients
	}
	return nil
}

type UpdateSettingsResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *UpdateSettingsResponse) Reset() {
	*x = UpdateSettingsResponse{}
	mi := &file_settings_v1_settings_proto_msgTypes[2]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *UpdateSettingsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*UpdateSettingsResponse) ProtoMessage() {}

func (x *UpdateSettingsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_settings_v1_settings_proto_msgTypes[2]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use UpdateSettingsResponse.ProtoReflect.Descriptor instead.
func (*UpdateSettingsResponse) Descriptor() ([]byte, []int) {
	return file_settings_v1_settings_proto_rawDescGZIP(), []int{2}
}

type ListSettingsResponse struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *ListSettingsResponse) Reset() {
	*x = ListSettingsResponse{}
	mi := &file_settings_v1_settings_proto_msgTypes[3]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *ListSettingsResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListSettingsResponse) ProtoMessage() {}

func (x *ListSettingsResponse) ProtoReflect() protoreflect.Message {
	mi := &file_settings_v1_settings_proto_msgTypes[3]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListSettingsResponse.ProtoReflect.Descriptor instead.
func (*ListSettingsResponse) Descriptor() ([]byte, []int) {
	return file_settings_v1_settings_proto_rawDescGZIP(), []int{3}
}

type Settings struct {
	state protoimpl.MessageState `protogen:"open.v1"`
	// General settings
	ApiKey               string `protobuf:"bytes,1,opt,name=api_key,json=apiKey,proto3" json:"api_key,omitempty"`
	ServerPort           string `protobuf:"bytes,2,opt,name=server_port,json=serverPort,proto3" json:"server_port,omitempty"`
	DownloadCheckTimeout uint64 `protobuf:"varint,3,opt,name=download_check_timeout,json=downloadCheckTimeout,proto3" json:"download_check_timeout,omitempty"`
	ExitOnClose          bool   `protobuf:"varint,16,opt,name=exit_on_close,json=exitOnClose,proto3" json:"exit_on_close,omitempty"`
	// Folder settings
	CompleteFolder string `protobuf:"bytes,4,opt,name=complete_folder,json=completeFolder,proto3" json:"complete_folder,omitempty"`
	DownloadFolder string `protobuf:"bytes,5,opt,name=download_folder,json=downloadFolder,proto3" json:"download_folder,omitempty"`
	TorrentsFolder string `protobuf:"bytes,6,opt,name=torrents_folder,json=torrentsFolder,proto3" json:"torrents_folder,omitempty"`
	// User settings
	Username string `protobuf:"bytes,7,opt,name=username,proto3" json:"username,omitempty"`
	Password string `protobuf:"bytes,8,opt,name=password,proto3" json:"password,omitempty"`
	UserUid  uint64 `protobuf:"varint,9,opt,name=user_uid,json=userUid,proto3" json:"user_uid,omitempty"`
	GroupUid uint64 `protobuf:"varint,10,opt,name=group_uid,json=groupUid,proto3" json:"group_uid,omitempty"`
	// Torrent settings
	TorrentHost     string `protobuf:"bytes,11,opt,name=torrent_host,json=torrentHost,proto3" json:"torrent_host,omitempty"`
	TorrentName     string `protobuf:"bytes,12,opt,name=torrent_name,json=torrentName,proto3" json:"torrent_name,omitempty"`
	TorrentPassword string `protobuf:"bytes,13,opt,name=torrent_password,json=torrentPassword,proto3" json:"torrent_password,omitempty"`
	TorrentProtocol string `protobuf:"bytes,14,opt,name=torrent_protocol,json=torrentProtocol,proto3" json:"torrent_protocol,omitempty"`
	TorrentUser     string `protobuf:"bytes,15,opt,name=torrent_user,json=torrentUser,proto3" json:"torrent_user,omitempty"`
	unknownFields   protoimpl.UnknownFields
	sizeCache       protoimpl.SizeCache
}

func (x *Settings) Reset() {
	*x = Settings{}
	mi := &file_settings_v1_settings_proto_msgTypes[4]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *Settings) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Settings) ProtoMessage() {}

func (x *Settings) ProtoReflect() protoreflect.Message {
	mi := &file_settings_v1_settings_proto_msgTypes[4]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Settings.ProtoReflect.Descriptor instead.
func (*Settings) Descriptor() ([]byte, []int) {
	return file_settings_v1_settings_proto_rawDescGZIP(), []int{4}
}

func (x *Settings) GetApiKey() string {
	if x != nil {
		return x.ApiKey
	}
	return ""
}

func (x *Settings) GetServerPort() string {
	if x != nil {
		return x.ServerPort
	}
	return ""
}

func (x *Settings) GetDownloadCheckTimeout() uint64 {
	if x != nil {
		return x.DownloadCheckTimeout
	}
	return 0
}

func (x *Settings) GetExitOnClose() bool {
	if x != nil {
		return x.ExitOnClose
	}
	return false
}

func (x *Settings) GetCompleteFolder() string {
	if x != nil {
		return x.CompleteFolder
	}
	return ""
}

func (x *Settings) GetDownloadFolder() string {
	if x != nil {
		return x.DownloadFolder
	}
	return ""
}

func (x *Settings) GetTorrentsFolder() string {
	if x != nil {
		return x.TorrentsFolder
	}
	return ""
}

func (x *Settings) GetUsername() string {
	if x != nil {
		return x.Username
	}
	return ""
}

func (x *Settings) GetPassword() string {
	if x != nil {
		return x.Password
	}
	return ""
}

func (x *Settings) GetUserUid() uint64 {
	if x != nil {
		return x.UserUid
	}
	return 0
}

func (x *Settings) GetGroupUid() uint64 {
	if x != nil {
		return x.GroupUid
	}
	return 0
}

func (x *Settings) GetTorrentHost() string {
	if x != nil {
		return x.TorrentHost
	}
	return ""
}

func (x *Settings) GetTorrentName() string {
	if x != nil {
		return x.TorrentName
	}
	return ""
}

func (x *Settings) GetTorrentPassword() string {
	if x != nil {
		return x.TorrentPassword
	}
	return ""
}

func (x *Settings) GetTorrentProtocol() string {
	if x != nil {
		return x.TorrentProtocol
	}
	return ""
}

func (x *Settings) GetTorrentUser() string {
	if x != nil {
		return x.TorrentUser
	}
	return ""
}

var File_settings_v1_settings_proto protoreflect.FileDescriptor

var file_settings_v1_settings_proto_rawDesc = []byte{
	0x0a, 0x1a, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2f, 0x76, 0x31, 0x2f, 0x73, 0x65,
	0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x0b, 0x73, 0x65,
	0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x76, 0x31, 0x22, 0x1d, 0x0a, 0x1b, 0x4c, 0x69, 0x73,
	0x74, 0x53, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x65, 0x64, 0x43, 0x6c, 0x69, 0x65, 0x6e, 0x74,
	0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x22, 0x38, 0x0a, 0x1c, 0x4c, 0x69, 0x73, 0x74,
	0x53, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x65, 0x64, 0x43, 0x6c, 0x69, 0x65, 0x6e, 0x74, 0x73,
	0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x18, 0x0a, 0x07, 0x63, 0x6c, 0x69, 0x65,
	0x6e, 0x74, 0x73, 0x18, 0x01, 0x20, 0x03, 0x28, 0x09, 0x52, 0x07, 0x63, 0x6c, 0x69, 0x65, 0x6e,
	0x74, 0x73, 0x22, 0x18, 0x0a, 0x16, 0x55, 0x70, 0x64, 0x61, 0x74, 0x65, 0x53, 0x65, 0x74, 0x74,
	0x69, 0x6e, 0x67, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x16, 0x0a, 0x14,
	0x4c, 0x69, 0x73, 0x74, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x52, 0x65, 0x73, 0x70,
	0x6f, 0x6e, 0x73, 0x65, 0x22, 0xc8, 0x04, 0x0a, 0x08, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67,
	0x73, 0x12, 0x17, 0x0a, 0x07, 0x61, 0x70, 0x69, 0x5f, 0x6b, 0x65, 0x79, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x06, 0x61, 0x70, 0x69, 0x4b, 0x65, 0x79, 0x12, 0x1f, 0x0a, 0x0b, 0x73, 0x65,
	0x72, 0x76, 0x65, 0x72, 0x5f, 0x70, 0x6f, 0x72, 0x74, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x0a, 0x73, 0x65, 0x72, 0x76, 0x65, 0x72, 0x50, 0x6f, 0x72, 0x74, 0x12, 0x34, 0x0a, 0x16, 0x64,
	0x6f, 0x77, 0x6e, 0x6c, 0x6f, 0x61, 0x64, 0x5f, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x5f, 0x74, 0x69,
	0x6d, 0x65, 0x6f, 0x75, 0x74, 0x18, 0x03, 0x20, 0x01, 0x28, 0x04, 0x52, 0x14, 0x64, 0x6f, 0x77,
	0x6e, 0x6c, 0x6f, 0x61, 0x64, 0x43, 0x68, 0x65, 0x63, 0x6b, 0x54, 0x69, 0x6d, 0x65, 0x6f, 0x75,
	0x74, 0x12, 0x22, 0x0a, 0x0d, 0x65, 0x78, 0x69, 0x74, 0x5f, 0x6f, 0x6e, 0x5f, 0x63, 0x6c, 0x6f,
	0x73, 0x65, 0x18, 0x10, 0x20, 0x01, 0x28, 0x08, 0x52, 0x0b, 0x65, 0x78, 0x69, 0x74, 0x4f, 0x6e,
	0x43, 0x6c, 0x6f, 0x73, 0x65, 0x12, 0x27, 0x0a, 0x0f, 0x63, 0x6f, 0x6d, 0x70, 0x6c, 0x65, 0x74,
	0x65, 0x5f, 0x66, 0x6f, 0x6c, 0x64, 0x65, 0x72, 0x18, 0x04, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0e,
	0x63, 0x6f, 0x6d, 0x70, 0x6c, 0x65, 0x74, 0x65, 0x46, 0x6f, 0x6c, 0x64, 0x65, 0x72, 0x12, 0x27,
	0x0a, 0x0f, 0x64, 0x6f, 0x77, 0x6e, 0x6c, 0x6f, 0x61, 0x64, 0x5f, 0x66, 0x6f, 0x6c, 0x64, 0x65,
	0x72, 0x18, 0x05, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0e, 0x64, 0x6f, 0x77, 0x6e, 0x6c, 0x6f, 0x61,
	0x64, 0x46, 0x6f, 0x6c, 0x64, 0x65, 0x72, 0x12, 0x27, 0x0a, 0x0f, 0x74, 0x6f, 0x72, 0x72, 0x65,
	0x6e, 0x74, 0x73, 0x5f, 0x66, 0x6f, 0x6c, 0x64, 0x65, 0x72, 0x18, 0x06, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x0e, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x73, 0x46, 0x6f, 0x6c, 0x64, 0x65, 0x72,
	0x12, 0x1a, 0x0a, 0x08, 0x75, 0x73, 0x65, 0x72, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x07, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x08, 0x75, 0x73, 0x65, 0x72, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x1a, 0x0a, 0x08,
	0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64, 0x18, 0x08, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08,
	0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64, 0x12, 0x19, 0x0a, 0x08, 0x75, 0x73, 0x65, 0x72,
	0x5f, 0x75, 0x69, 0x64, 0x18, 0x09, 0x20, 0x01, 0x28, 0x04, 0x52, 0x07, 0x75, 0x73, 0x65, 0x72,
	0x55, 0x69, 0x64, 0x12, 0x1b, 0x0a, 0x09, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f, 0x75, 0x69, 0x64,
	0x18, 0x0a, 0x20, 0x01, 0x28, 0x04, 0x52, 0x08, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x55, 0x69, 0x64,
	0x12, 0x21, 0x0a, 0x0c, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x68, 0x6f, 0x73, 0x74,
	0x18, 0x0b, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x48,
	0x6f, 0x73, 0x74, 0x12, 0x21, 0x0a, 0x0c, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x6e,
	0x61, 0x6d, 0x65, 0x18, 0x0c, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x74, 0x6f, 0x72, 0x72, 0x65,
	0x6e, 0x74, 0x4e, 0x61, 0x6d, 0x65, 0x12, 0x29, 0x0a, 0x10, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e,
	0x74, 0x5f, 0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64, 0x18, 0x0d, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x0f, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x50, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72,
	0x64, 0x12, 0x29, 0x0a, 0x10, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x70, 0x72, 0x6f,
	0x74, 0x6f, 0x63, 0x6f, 0x6c, 0x18, 0x0e, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0f, 0x74, 0x6f, 0x72,
	0x72, 0x65, 0x6e, 0x74, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x63, 0x6f, 0x6c, 0x12, 0x21, 0x0a, 0x0c,
	0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x5f, 0x75, 0x73, 0x65, 0x72, 0x18, 0x0f, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x0b, 0x74, 0x6f, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x55, 0x73, 0x65, 0x72, 0x32,
	0x9c, 0x02, 0x0a, 0x0f, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x53, 0x65, 0x72, 0x76,
	0x69, 0x63, 0x65, 0x12, 0x4e, 0x0a, 0x0e, 0x55, 0x70, 0x64, 0x61, 0x74, 0x65, 0x53, 0x65, 0x74,
	0x74, 0x69, 0x6e, 0x67, 0x73, 0x12, 0x15, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73,
	0x2e, 0x76, 0x31, 0x2e, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x1a, 0x23, 0x2e, 0x73,
	0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x55, 0x70, 0x64, 0x61, 0x74,
	0x65, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73,
	0x65, 0x22, 0x00, 0x12, 0x4a, 0x0a, 0x0c, 0x4c, 0x69, 0x73, 0x74, 0x53, 0x65, 0x74, 0x74, 0x69,
	0x6e, 0x67, 0x73, 0x12, 0x21, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x76,
	0x31, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x52, 0x65,
	0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x1a, 0x15, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67,
	0x73, 0x2e, 0x76, 0x31, 0x2e, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x22, 0x00, 0x12,
	0x6d, 0x0a, 0x14, 0x4c, 0x69, 0x73, 0x74, 0x53, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x65, 0x64,
	0x43, 0x6c, 0x69, 0x65, 0x6e, 0x74, 0x73, 0x12, 0x28, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e,
	0x67, 0x73, 0x2e, 0x76, 0x31, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x53, 0x75, 0x70, 0x70, 0x6f, 0x72,
	0x74, 0x65, 0x64, 0x43, 0x6c, 0x69, 0x65, 0x6e, 0x74, 0x73, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73,
	0x74, 0x1a, 0x29, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e, 0x76, 0x31, 0x2e,
	0x4c, 0x69, 0x73, 0x74, 0x53, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x65, 0x64, 0x43, 0x6c, 0x69,
	0x65, 0x6e, 0x74, 0x73, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x42, 0x9b,
	0x01, 0x0a, 0x0f, 0x63, 0x6f, 0x6d, 0x2e, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2e,
	0x76, 0x31, 0x42, 0x0d, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x50, 0x72, 0x6f, 0x74,
	0x6f, 0x50, 0x01, 0x5a, 0x2c, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f,
	0x52, 0x41, 0x33, 0x34, 0x31, 0x2f, 0x67, 0x6f, 0x75, 0x64, 0x61, 0x2f, 0x67, 0x65, 0x6e, 0x65,
	0x72, 0x61, 0x74, 0x65, 0x64, 0x2f, 0x73, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x2f, 0x76,
	0x31, 0xa2, 0x02, 0x03, 0x53, 0x58, 0x58, 0xaa, 0x02, 0x0b, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e,
	0x67, 0x73, 0x2e, 0x56, 0x31, 0xca, 0x02, 0x0b, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73,
	0x5c, 0x56, 0x31, 0xe2, 0x02, 0x17, 0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x5c, 0x56,
	0x31, 0x5c, 0x47, 0x50, 0x42, 0x4d, 0x65, 0x74, 0x61, 0x64, 0x61, 0x74, 0x61, 0xea, 0x02, 0x0c,
	0x53, 0x65, 0x74, 0x74, 0x69, 0x6e, 0x67, 0x73, 0x3a, 0x3a, 0x56, 0x31, 0x62, 0x06, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_settings_v1_settings_proto_rawDescOnce sync.Once
	file_settings_v1_settings_proto_rawDescData = file_settings_v1_settings_proto_rawDesc
)

func file_settings_v1_settings_proto_rawDescGZIP() []byte {
	file_settings_v1_settings_proto_rawDescOnce.Do(func() {
		file_settings_v1_settings_proto_rawDescData = protoimpl.X.CompressGZIP(file_settings_v1_settings_proto_rawDescData)
	})
	return file_settings_v1_settings_proto_rawDescData
}

var file_settings_v1_settings_proto_msgTypes = make([]protoimpl.MessageInfo, 5)
var file_settings_v1_settings_proto_goTypes = []any{
	(*ListSupportedClientsRequest)(nil),  // 0: settings.v1.ListSupportedClientsRequest
	(*ListSupportedClientsResponse)(nil), // 1: settings.v1.ListSupportedClientsResponse
	(*UpdateSettingsResponse)(nil),       // 2: settings.v1.UpdateSettingsResponse
	(*ListSettingsResponse)(nil),         // 3: settings.v1.ListSettingsResponse
	(*Settings)(nil),                     // 4: settings.v1.Settings
}
var file_settings_v1_settings_proto_depIdxs = []int32{
	4, // 0: settings.v1.SettingsService.UpdateSettings:input_type -> settings.v1.Settings
	3, // 1: settings.v1.SettingsService.ListSettings:input_type -> settings.v1.ListSettingsResponse
	0, // 2: settings.v1.SettingsService.ListSupportedClients:input_type -> settings.v1.ListSupportedClientsRequest
	2, // 3: settings.v1.SettingsService.UpdateSettings:output_type -> settings.v1.UpdateSettingsResponse
	4, // 4: settings.v1.SettingsService.ListSettings:output_type -> settings.v1.Settings
	1, // 5: settings.v1.SettingsService.ListSupportedClients:output_type -> settings.v1.ListSupportedClientsResponse
	3, // [3:6] is the sub-list for method output_type
	0, // [0:3] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_settings_v1_settings_proto_init() }
func file_settings_v1_settings_proto_init() {
	if File_settings_v1_settings_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_settings_v1_settings_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   5,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_settings_v1_settings_proto_goTypes,
		DependencyIndexes: file_settings_v1_settings_proto_depIdxs,
		MessageInfos:      file_settings_v1_settings_proto_msgTypes,
	}.Build()
	File_settings_v1_settings_proto = out.File
	file_settings_v1_settings_proto_rawDesc = nil
	file_settings_v1_settings_proto_goTypes = nil
	file_settings_v1_settings_proto_depIdxs = nil
}
