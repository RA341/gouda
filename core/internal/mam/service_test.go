package mam

import (
	"os"
	"testing"

	"github.com/joho/godotenv"
	"github.com/stretchr/testify/require"
)

func TestService_GetProfile(t *testing.T) {
	srv := setup(t)
	_, err := srv.GetBonusProfile()
	require.NoError(t, err)
}

func TestService_BuyVault(t *testing.T) {
	//srv := setup(t)
	//err := srv.BuyVault(srv.cookie, 1000)
	//require.NoError(t, err)
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
	srv := NewService(cookie)
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
