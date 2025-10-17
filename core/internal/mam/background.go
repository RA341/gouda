package mam

import (
	"fmt"
	"math"
	"time"

	"github.com/rs/zerolog/log"
)

const (
	PointsPerGB      = 500
	PointsPerVIPWeek = 1250
	MaxVIPWeeks      = 12.8
	MinPointsToKeep  = 2000
)

type BackgroundService struct {
	srv *Service
}

func NewBackgroundService(srv *Service) *BackgroundService {
	return &BackgroundService{srv: srv}
}

func (s *BackgroundService) Start() {
	ticker := time.NewTicker(s.srv.provider().GetMamInterval(24 * time.Hour))

	for {
		select {
		case <-ticker.C:
			s.autoBuy()
		}
	}
}

func (s *BackgroundService) autoBuy() {
	log.Info().Msg("starting autobuy")

	var vip *BuyVIPResponse
	var err error

	if !s.srv.provider().AutoBuyVip {
		log.Info().Msg("AutoBuy vip is disabled, skipping....")
	} else {
		vip, err = s.srv.BuyVIP(0)
		if err != nil {
			log.Warn().Err(err).Msg("unable buy vip")
		} else {
			log.Info().Any("vip", vip).Msg("bought vip weeks")
		}
	}

	if s.srv.provider().AutoBuyBonus {
		gbToBuy := 0
		if vip != nil {
			if vip.SeedBonus > MinPointsToKeep {
				gbToBuy = int((vip.SeedBonus - MinPointsToKeep) / PointsPerGB)
				// reduce by safeMargin incase we are at the edge
				safeMargin := 1
				if gbToBuy > safeMargin {
					gbToBuy -= safeMargin
				}
			}
		}

		log.Info().Int("gb", gbToBuy).Msg("buying bonus")

		bonus, err := s.srv.BuyBonus(uint(gbToBuy))
		if err != nil {
			log.Warn().Err(err).Msg("unable buy bonus")
		} else {
			log.Info().Any("bonus", bonus).Msg("bought bonus points")
		}
	} else {
		log.Info().Msg("AutoBuy bonus is disabled, skipping....")
	}
}

func CalculateWeeksRemaining(vipUntil string) (float64, error) {
	if vipUntil == "" {
		return 0, nil
	}

	// api returns mysql format: 2025-12-30 06:22:50
	// failed to parse VIP expiry date: parsing time "2025-12-30 06:22:50" as
	// "2006-01-02T15:04:05Z07:00": cannot parse " 06:22:50" as "T"

	vipExpiry, err := time.Parse("2006-01-02 15:04:05", vipUntil)
	if err != nil {
		return 0, fmt.Errorf("failed to parse VIP expiry date: %w", err)
	}

	now := time.Now()
	duration := vipExpiry.Sub(now)

	if duration <= 0 {
		return 0, nil // VIP already expired
	}

	weeks := duration.Hours() / 24 / 7
	return weeks, nil
}

func CalculateOptimalPurchase(curPoints int, currentVIPWeeks float64) (GBCreditToBuy int, VIPWeeksToBuy int) {
	// Calculate available points to spend (keep 2000 reserved)
	availablePoints := curPoints - MinPointsToKeep
	if availablePoints <= 0 {
		log.Info().Int("points", curPoints).Msg("insufficient points to purchase")
		return 0, 0
	}

	// Calculate how many VIP weeks we can buy without exceeding 90 days (12.8 weeks) total
	maxWeeksCanBuy := int(math.Floor(MaxVIPWeeks - currentVIPWeeks))
	if maxWeeksCanBuy < 0 {
		maxWeeksCanBuy = 0
	}

	// Calculate how many VIP weeks we can afford
	maxWeeksAffordable := int(availablePoints / PointsPerVIPWeek)
	// Buy the minimum of what we can afford and what's allowed
	VIPWeeksToBuy = min(maxWeeksCanBuy, maxWeeksAffordable)

	// Calculate remaining points after VIP purchase
	remainingPoints := availablePoints - (VIPWeeksToBuy * PointsPerVIPWeek)
	// Calculate how many GB we can buy with remaining points
	GBCreditToBuy = remainingPoints / PointsPerGB

	// Calculate total points spent and remaining
	PointsSpent := (VIPWeeksToBuy * PointsPerVIPWeek) + (GBCreditToBuy * PointsPerGB)
	PointsRemaining := curPoints - PointsSpent
	log.Info().Int("remainingPoints", PointsRemaining).Msg("remaining points")

	return GBCreditToBuy, VIPWeeksToBuy
}
