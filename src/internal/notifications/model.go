package notifications

import "gorm.io/gorm"

const (
	DownloadUpdate = iota
	MediaUpdate
)

type Notifications struct {
	gorm.Model
	notificationType int
}

type NotificationConfig struct {
	title            string
	body             string
	urls             []string
	notificationType int
}

type NotificationOpt func(config *NotificationConfig)

func parseOpts(opts ...NotificationOpt) NotificationConfig {
	config := NotificationConfig{}
	for _, opt := range opts {
		opt(&config)
	}
	if config.title == "" {
		switch config.notificationType {
		case DownloadUpdate:
			config.title = "Download Complete"
		case MediaUpdate:
			config.title = "Media updated"
		default:
			config.title = "Unknown"
		}
	}

	return config
}

func WithUrl(url string) NotificationOpt {
	return func(config *NotificationConfig) {
		config.urls = append(config.urls, url)
	}
}

func WithTitle(title string) NotificationOpt {
	return func(config *NotificationConfig) {
		config.title = title
	}
}

func WithBody(body string) NotificationOpt {
	return func(config *NotificationConfig) {
		config.body = body
	}
}

func WithType(notificationType int) NotificationOpt {
	return func(config *NotificationConfig) {
		config.notificationType = notificationType
	}
}
