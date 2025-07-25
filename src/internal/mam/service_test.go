package mam

import (
	"github.com/joho/godotenv"
	"os"
	"testing"
)

func TestService_Search(t *testing.T) {
	//cookie := getMamCookie(t)
	//srv := NewService(cookie)

	//err := srv.BuyVault(30)
	//require.NoError(t, err)

	//_, _, _, err := srv.Search("hitchhikers")
	//require.NoError(t, err)
	//freeleech, err := srv.UseFreelech("", "")
	//if err != nil {
	//	return
	//}
	//t.Log(search)

	//bonus, err := srv.BuyBonus(1)
	//require.NoError(t, err)
	//t.Log(bonus)
}

func getMamCookie(t *testing.T) string {
	_ = godotenv.Load()
	val, ok := os.LookupEnv("MAM")
	if !ok {
		t.Fatal("Missing MAM environment variable, please set in a .env file")
	}
	return val
}
