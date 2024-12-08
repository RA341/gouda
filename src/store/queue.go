package store

import (
	"context"
	"github.com/ThreeDotsLabs/watermill"
	"github.com/ThreeDotsLabs/watermill/message"
	"github.com/ThreeDotsLabs/watermill/pubsub/gochannel"
)

func CreatePubSub(topicName string) <-chan *message.Message {
	pubSub := gochannel.NewGoChannel(
		gochannel.Config{},
		watermill.NewStdLogger(false, false),
	)

	messages, err := pubSub.Subscribe(context.Background(), topicName)
	if err != nil {
		panic(err)
	}

	return messages
}

func ProcessDownloadQueue() {

}
