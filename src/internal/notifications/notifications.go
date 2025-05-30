package notifications

import (
	"github.com/containrrr/shoutrrr"
	"github.com/containrrr/shoutrrr/pkg/types"
	"github.com/rs/zerolog/log"
)

type NotificationService struct{}

func (nf *NotificationService) SendNotif(opts ...NotificationOpt) {
	notif := parseOpts(opts...)

	sender, err := shoutrrr.CreateSender(notif.urls...)
	if err != nil {
		log.Error().Err(err).Msg("Unable to create shoutrrr sender")
		return
	}

	results := sender.Send(notif.title, &types.Params{
		"title": notif.title,
		"body":  notif.body,
	})

	for index, result := range results {
		if result != nil {
			log.Error().Err(result).Msgf("Unable to send notification to %s", notif.urls[index])
		}
	}
}
