package mam

import (
	"testing"
	"time"
)

func TestCalculateOptimalPurchase(t *testing.T) {
	vipExpiry, err := time.Parse("2006-01-02 15:04:05", "2025-12-30 06:22:50")
	if err != nil {
		t.Fatal(err)
	}
	t.Log("export", vipExpiry)

	gb, vip := CalculateOptimalPurchase(5000, 11.5)

	t.Log("GB: ", gb)
	t.Log("VIP: ", vip)
}
