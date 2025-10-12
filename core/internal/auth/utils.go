package auth

import (
	"crypto/rand"
	"crypto/sha256"
	"fmt"
	"math/big"

	"golang.org/x/crypto/bcrypt"
)

func generateRandomToken(length int) string {
	const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	var randomString []byte

	for i := 0; i < length; i++ {
		randomIndex, _ := rand.Int(rand.Reader, big.NewInt(int64(len(characters))))
		randomString = append(randomString, characters[randomIndex.Int64()])
	}

	return string(randomString)
}

func checkEncryptedString(input string, hashedInput string) error {
	err := bcrypt.CompareHashAndPassword([]byte(hashedInput), []byte(input))
	if err != nil {
		return err
	}
	return nil
}

func EncryptPassword(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", fmt.Errorf("unable to encrypt password")
	}
	return string(hashedPassword), nil
}

func hashString(input string) string {
	hash := sha256.New()
	hash.Write([]byte(input))

	hashedBytes := hash.Sum(nil)

	hashedString := fmt.Sprintf("%x", hashedBytes)
	return hashedString
}
