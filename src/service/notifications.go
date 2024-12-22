package service

import (
	"github.com/containrrr/shoutrrr"
	"github.com/containrrr/shoutrrr/pkg/types"
	"github.com/rs/zerolog/log"
)

type NotificationService struct {
	Urls []string
}

func (nf *NotificationService) SendNotif(message, bodyMessage string) {
	sender, err := shoutrrr.CreateSender(nf.Urls...)
	if err != nil {
		log.Error().Err(err).Msg("Unable to create shoutrrr sender")
		return
	}

	results := sender.Send(message, &types.Params{
		"title": message,
		"body":  bodyMessage,
	})

	for index, result := range results {
		if result != nil {
			log.Error().Err(result).Msgf("Unable to send notification to %s", nf.Urls[index])
		}
	}
}
