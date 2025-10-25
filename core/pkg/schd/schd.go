package schd

import (
	"time"

	"github.com/rs/zerolog/log"
)

type Task func()

type Scheduler struct {
	task     Task
	interval time.Duration
	// used to send cancel task loop
	cancelChan chan interface{}
	// used to initiate task
	manualChan chan interface{}
}

func NewScheduler(task Task, interval time.Duration) *Scheduler {
	return &Scheduler{
		task:       task,
		interval:   interval,
		cancelChan: make(chan interface{}),
		manualChan: make(chan interface{}),
	}
}

// Manual Trigger the task manually
//
// will skip the timer if occurs during task execution
func (s *Scheduler) Manual() {
	select {
	case s.manualChan <- struct{}{}:
	default:
		log.Debug().Msg("updater is already running chill")
	}
}

// Restart the loop read in new interval if modified
func (s *Scheduler) Restart() {
	s.Stop()
	s.Start()
}

// Stop the loop exiting the go routine as immediately
//
// if a task is running it will wait until it is done executing
func (s *Scheduler) Stop() {
	select {
	case s.cancelChan <- struct{}{}:
	default:
		log.Debug().Msg("Cancel channel is already cancelled")
	}
}

// Start the task loop
func (s *Scheduler) Start() {
	go s.loop()
}

func (s *Scheduler) loop() {
	interval := s.interval

	ticker := time.NewTicker(interval)
	defer ticker.Stop()
	for {
		select {
		case _ = <-ticker.C:
			s.Manual()
		case <-s.manualChan:
			s.task()
			_ = <-s.manualChan
		case <-s.cancelChan:
			_ = <-s.cancelChan
			return
		}
	}
}
