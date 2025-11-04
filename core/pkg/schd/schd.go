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
	cancelChan chan struct{}
	// used to initiate task
	manualChan chan struct{}
}

// NewScheduler task is expected to be a long-running function that will run in a go routine
func NewScheduler(task Task, interval time.Duration) *Scheduler {
	s := &Scheduler{
		task:       task,
		interval:   interval,
		cancelChan: make(chan struct{}, 1),
		manualChan: make(chan struct{}, 1),
	}
	s.start()
	return s
}

// Manual Trigger the task manually
//
// will skip the timer if occurs during task execution
func (s *Scheduler) Manual() {
	select {
	case s.manualChan <- struct{}{}:
		log.Debug().Msg("starting task")
	default:
		log.Debug().Msg("task is already running")
	}
}

// Restart the loop read in new interval if modified
func (s *Scheduler) Restart() {
	s.Stop()
	s.start()
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
func (s *Scheduler) start() {
	go s.loop()
}

func (s *Scheduler) loop() {
	ticker := time.NewTicker(s.interval)
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
