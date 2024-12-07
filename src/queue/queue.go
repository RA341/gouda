package queue

import (
	"context"
	"encoding/json"
	"github.com/ThreeDotsLabs/watermill"
	"github.com/ThreeDotsLabs/watermill/message"
	"github.com/ThreeDotsLabs/watermill/pubsub/gochannel"
	"log"
)

// QueueItem represents an item to be processed
type QueueItem struct {
	ID       string          `json:"id"`
	Data     json.RawMessage `json:"data"`
	Complete bool            `json:"complete"`
	Progress int             `json:"progress"`
}

// ProcessingService handles the queue processing
type ProcessingService struct {
	pubSub     *gochannel.GoChannel
	router     *message.Router
	onComplete func(QueueItem)
}

func NewProcessingService(onComplete func(QueueItem)) (*ProcessingService, error) {
	router, err := message.NewRouter(message.RouterConfig{}, watermill.NewStdLogger(false, false))
	if err != nil {
		return nil, err
	}

	// Create internal pub/sub
	pubSub := gochannel.NewGoChannel(
		gochannel.Config{
			Persistent: true,
		},
		watermill.NewStdLogger(false, false),
	)

	return &ProcessingService{
		pubSub:     pubSub,
		router:     router,
		onComplete: onComplete,
	}, nil
}

func (s *ProcessingService) Start(ctx context.Context, apiCall func(QueueItem) (int, error)) error {
	// Handler for new items
	s.router.AddHandler(
		"process_items",
		"new_items", // topic for new items
		s.pubSub,
		"progress_updates", // topic for progress updates
		s.pubSub,
		func(msg *message.Message) ([]*message.Message, error) {
			var item QueueItem
			if err := json.Unmarshal(msg.Payload, &item); err != nil {
				return nil, err
			}

			// Call API to get progress
			progress, err := apiCall(item)
			if err != nil {
				log.Printf("Error processing item %s: %v", item.ID, err)
				return nil, err
			}

			item.Progress = progress

			// Check if complete
			if progress >= 100 {
				item.Complete = true
				item.Progress = 100

				if s.onComplete != nil {
					go s.onComplete(item)
				}
			}

			// Create progress update message
			payload, err := json.Marshal(item)
			if err != nil {
				return nil, err
			}

			return []*message.Message{message.NewMessage(
				watermill.NewUUID(),
				payload,
			)}, nil
		},
	)

	// Handler for progress updates
	s.router.AddNoPublisherHandler(
		"progress_monitor",
		"progress_updates",
		s.pubSub,
		func(msg *message.Message) error {
			var item QueueItem
			if err := json.Unmarshal(msg.Payload, &item); err != nil {
				return err
			}

			log.Printf("Progress update for item %s: %d%%", item.ID, item.Progress)
			return nil
		},
	)

	// Start the router
	return s.router.Run(ctx)
}

func (s *ProcessingService) AddItem(item QueueItem) error {
	payload, err := json.Marshal(item)
	if err != nil {
		return err
	}

	msg := message.NewMessage(watermill.NewUUID(), payload)
	return s.pubSub.Publish("new_items", msg)
}

func (s *ProcessingService) Close() error {
	return s.router.Close()
}
