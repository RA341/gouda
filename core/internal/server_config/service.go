package server_config

import (
	"fmt"
	"os"
	"path/filepath"

	v1 "github.com/RA341/gouda/generated/settings/v1"
)

// todo separate logic from handler

type ValidatorMamToken func(token string) error

type ValidatorTorrentClient func(client *TorrentClient) error

type Service struct {
	conf            *GoudaConfig
	mamValidator    ValidatorMamToken
	clientValidator ValidatorTorrentClient
}

func NewService(
	conf *GoudaConfig,
	mamValidator ValidatorMamToken,
	clientValidator ValidatorTorrentClient,
) *Service {
	return &Service{
		conf:            conf,
		mamValidator:    mamValidator,
		clientValidator: clientValidator,
	}
}

func (s *Service) loadConfigToRPC() *v1.GoudaConfig {
	s.conf.RW.RLock()
	defer s.conf.RW.RUnlock()
	return ToProto(s.conf)
}

func (s *Service) updateMam(mamToken string) error {
	s.conf.RW.RLock()
	defer s.conf.RW.RUnlock()

	err := s.mamValidator(mamToken)
	if err != nil {
		return err
	}

	s.conf.MamToken = mamToken

	return s.conf.DumpToYaml()
}

func (s *Service) updateTorrentClient(client *TorrentClient) error {
	s.conf.RW.RLock()
	defer s.conf.RW.RUnlock()

	err := s.clientValidator(client)
	if err != nil {
		return err
	}

	s.conf.TorrentClient = *client

	return s.conf.DumpToYaml()
}

func (s *Service) listDir(workingDir string) (folders []string, files []string, err error) {
	workingDir, err = filepath.Abs(workingDir)
	if err != nil {
		return nil, nil, fmt.Errorf("unable to get absloute path: %w", err)
	}

	dir, err := os.ReadDir(workingDir)
	if err != nil {
		return nil, nil, err
	}

	for _, file := range dir {
		path := filepath.Join(workingDir, file.Name())
		path = filepath.ToSlash(path)

		if file.IsDir() {
			folders = append(folders, path)
		} else {
			files = append(files, path)
		}
	}

	return folders, files, err
}

func (s *Service) saveConfigWithValidation(rpcConfig *v1.GoudaConfig) error {
	s.conf.RW.Lock()
	defer s.conf.RW.Unlock()

	err := s.mamValidator(rpcConfig.MamToken)
	if err != nil {
		return fmt.Errorf("error validating mam token: %v", err)
	}

	err = s.clientValidator(TorrentClientFromRpc(rpcConfig.TorrentClient))
	if err != nil {
		return fmt.Errorf("error validating torrent client: %v", err)
	}

	FromProto(rpcConfig, s.conf)

	return s.conf.DumpToYaml()
}

func (s *Service) saveConfig(rpcConfig *v1.GoudaConfig) error {
	s.conf.RW.Lock()
	defer s.conf.RW.Unlock()

	err := s.mamValidator(rpcConfig.MamToken)
	if err != nil {
		return fmt.Errorf("error validating mam token: %v", err)
	}

	err = s.clientValidator(TorrentClientFromRpc(rpcConfig.TorrentClient))
	if err != nil {
		return fmt.Errorf("error validating torrent client: %v", err)
	}

	FromProto(rpcConfig, s.conf)

	return s.conf.DumpToYaml()
}

func ToProto(cfg *GoudaConfig) *v1.GoudaConfig {
	return &v1.GoudaConfig{
		Port:           int32(cfg.Port),
		AllowedOrigins: cfg.AllowedOrigins,
		UiPath:         cfg.UIPath,
		MamToken:       cfg.MamToken,
		Dir: &v1.Directories{
			DownloadDir: cfg.Dir.DownloadDir,
			CompleteDir: cfg.Dir.CompleteDir,
			TorrentDir:  cfg.Dir.TorrentDir,
		},
		Log: &v1.Logger{
			Level:   cfg.Log.Level,
			Verbose: cfg.Log.Verbose,
		},
		Downloader: &v1.Downloader{
			Timeout:       cfg.Downloader.Timeout,
			IgnoreTimeout: cfg.Downloader.IgnoreTimeout,
		},
		Permissions: &v1.UserPermissions{
			Uid: int32(cfg.Permissions.UID),
			Gid: int32(cfg.Permissions.GID),
		},
		TorrentClient: &v1.TorrentClient{
			ClientType: cfg.TorrentClient.ClientType,
			Protocol:   cfg.TorrentClient.Protocol,
			Host:       cfg.TorrentClient.Host,
			User:       cfg.TorrentClient.User,
			Password:   cfg.TorrentClient.Password,
		},
	}
}

func FromProto(pb *v1.GoudaConfig, conf *GoudaConfig) {
	if pb == nil || conf == nil {
		return
	}

	conf.Port = int(pb.Port)
	conf.AllowedOrigins = pb.AllowedOrigins
	conf.UIPath = pb.UiPath
	conf.MamToken = pb.MamToken

	if pb.Dir != nil {
		conf.Dir = Directories{
			DownloadDir: pb.Dir.DownloadDir,
			CompleteDir: pb.Dir.CompleteDir,
			TorrentDir:  pb.Dir.TorrentDir,
		}
	}

	if pb.Log != nil {
		conf.Log = Logger{
			Level:   pb.Log.Level,
			Verbose: pb.Log.Verbose,
		}
	}

	if pb.Downloader != nil {
		conf.Downloader = Downloader{
			Timeout:       pb.Downloader.Timeout,
			IgnoreTimeout: pb.Downloader.IgnoreTimeout,
		}
	}

	if pb.Permissions != nil {
		conf.Permissions = UserPermissions{
			UID: int(pb.Permissions.Uid),
			GID: int(pb.Permissions.Gid),
		}
	}

	if pb.TorrentClient != nil {
		conf.TorrentClient = *TorrentClientFromRpc(pb.TorrentClient)
	}
}

func TorrentClientFromRpc(client *v1.TorrentClient) *TorrentClient {
	return &TorrentClient{
		ClientType: client.ClientType,
		Protocol:   client.Protocol,
		Host:       client.Host,
		User:       client.User,
		Password:   client.Password,
	}
}
