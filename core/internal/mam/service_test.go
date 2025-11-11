package mam

import (
	"os"
	"testing"

	sc "github.com/RA341/gouda/internal/server_config"
	"github.com/joho/godotenv"
	"github.com/stretchr/testify/require"
)

func TestService_GetProfile(t *testing.T) {
	srv := setup(t)
	_, err := srv.GetBonusProfile()
	require.NoError(t, err)
}

func Test_divideIntoMamGBAmounts(t *testing.T) {
	res := divideIntoMamGBAmounts(112)
	require.Equal(t, []int{100, 10}, res)
}

func TestService_BuyVault(t *testing.T) {
	srv := setup(t)
	resp, err := srv.BuyBonus(8)
	require.NoError(t, err)
	t.Log(resp)
}

func TestService_SearchRaw(t *testing.T) {
	srv := setup(t)

	query := map[string]any{
		"tor": map[string]any{
			"text": "hitchhikers",
			"srchIn": []string{
				"title",
			},
		},
	}

	results, _, _, err := srv.SearchRaw(query)
	require.NoError(t, err)

	t.Log(results)
}

func setup(t *testing.T) *Service {
	cookie := getMamCookie(t)
	srv := NewService(
		func() *sc.MamConfig {
			return &sc.MamConfig{
				MamToken:        cookie,
				ServiceInterval: "",
				AutoBuyBonus:    false,
				AutoBuyVip:      false,
			}
		},
		func() *sc.Logger {
			return &sc.Logger{
				Level:   "debug",
				Verbose: true,
			}
		},
	)
	return srv
}

func getMamCookie(t *testing.T) string {
	_ = godotenv.Load()
	val, ok := os.LookupEnv("MAM")
	if !ok {
		t.Fatal("Missing MAM environment variable, please set in a .env file")
	}
	return val
}
