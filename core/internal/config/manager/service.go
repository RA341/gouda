package manager

import (
	v1 "github.com/RA341/gouda/generated/settings/v1"
	"github.com/RA341/gouda/internal/config"
)

// todo separate logic from handler

type Service struct {
	conf *config.GoudaConfig
}

func (s *Service) loadConfigToRPC() *v1.GoudaConfig {
	s.conf.RW.RLock()
	defer s.conf.RW.RUnlock()
	return ToProto(s.conf)
}

func (s *Service) saveConfigFromRPC(rpcConfig *v1.GoudaConfig) error {
	s.conf.RW.Lock()
	defer s.conf.RW.Unlock()

	FromProto(rpcConfig, s.conf)
	return s.conf.DumpToYaml()
}

func ToProto(cfg *config.GoudaConfig) *v1.GoudaConfig {
	return &v1.GoudaConfig{
		Port:           int32(cfg.Port),
		AllowedOrigins: cfg.AllowedOrigins,
		UiPath:         cfg.UIPath,
		Auth:           cfg.Auth,
		MamToken:       cfg.MamToken,
		Dir: &v1.Directories{
			ConfigDir:   cfg.Dir.ConfigDir,
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
	}
}

func FromProto(pb *v1.GoudaConfig, conf *config.GoudaConfig) {
	if pb == nil || conf == nil {
		return
	}

	conf.Port = int(pb.Port)
	conf.AllowedOrigins = pb.AllowedOrigins
	conf.UIPath = pb.UiPath
	conf.Auth = pb.Auth
	conf.MamToken = pb.MamToken

	if pb.Dir != nil {
		conf.Dir = config.Directories{
			ConfigDir:   pb.Dir.ConfigDir,
			DownloadDir: pb.Dir.DownloadDir,
			CompleteDir: pb.Dir.CompleteDir,
			TorrentDir:  pb.Dir.TorrentDir,
		}
	}

	if pb.Log != nil {
		conf.Log = config.Logger{
			Level:   pb.Log.Level,
			Verbose: pb.Log.Verbose,
		}
	}

	if pb.Downloader != nil {
		conf.Downloader = config.Downloader{
			Timeout:       pb.Downloader.Timeout,
			IgnoreTimeout: pb.Downloader.IgnoreTimeout,
		}
	}

	if pb.Permissions != nil {
		conf.Permissions = config.UserPermissions{
			UID: int(pb.Permissions.Uid),
			GID: int(pb.Permissions.Gid),
		}
	}
}
