package store

import "sync"

// GlobalList provides a thread-safe global list
type GlobalList struct {
	mu   sync.RWMutex
	list []int64
}

// NewList creates a new GlobalList instance
func NewList() *GlobalList {
	return &GlobalList{
		list: make([]int64, 0),
	}
}

// Add appends an item to the list
func (g *GlobalList) Add(item int64) {
	g.mu.Lock()
	defer g.mu.Unlock()
	g.list = append(g.list, item)
}

// Get returns all items in the list
func (g *GlobalList) Get() []int64 {
	g.mu.RLock()
	defer g.mu.RUnlock()
	// Create a copy to avoid external modifications
	result := make([]int64, len(g.list))
	copy(result, g.list)
	return result
}
