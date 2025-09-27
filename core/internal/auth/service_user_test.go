package auth_test

import (
	"io"
	"os"
	"testing"

	"github.com/RA341/gouda/internal/auth"
	"github.com/RA341/gouda/internal/database"
	"github.com/stretchr/testify/require"
	"gorm.io/gorm"
)

const testDir = "./test"

var (
	db           *gorm.DB
	userStore    auth.UserStore
	sessionStore auth.SessionStore
)

func setup(t *testing.T) *auth.Service {
	err := os.MkdirAll(testDir, 0770)
	if err != nil {
		t.Fatal(err)
	}

	db, err = database.ConnectToDB(testDir, &auth.User{}, &auth.Session{})
	if err != nil {
		t.Fatal(err)
	}

	sessionStore = database.NewAuthSessionGorm(db)
	userStore = database.NewAuthStoreGorm(db)

	service := auth.NewService(sessionStore, userStore)

	d, err := db.DB()
	if err != nil {
		t.Fatal(err)
	}

	t.Cleanup(func() {
		TearDown(d)
	})

	return service
}

func TearDown(closer io.Closer) {
	_ = closer.Close()
	_ = os.RemoveAll(testDir)
}

func Test_Register(t *testing.T) {
	srv := setup(t)

	user := "test"
	pass := "test"
	role := auth.RoleAdmin

	err := srv.Register(user, pass, role)
	if err != nil {
		t.Fatal(err)
	}

	err = srv.Register(user, pass, role)
	require.ErrorIs(t, err, auth.ErrUserExists)
}

func Test_Admin_Existence(t *testing.T) {
	srv := setup(t)

	_, err := srv.Login(auth.DefaultAdminUsername, auth.DefaultAdminPassword)
	require.NoError(t, err)

	// try again
	err = srv.CreateInitialAdmin()
	require.NoError(t, err)
}

func Test_Login(t *testing.T) {
	srv := setup(t)

	user := "test"
	pass := "test"

	err := srv.Register(user, pass, auth.RoleAdmin)
	require.NoError(t, err)

	_, err = srv.Login(user, "incorrect-password")
	require.ErrorIs(t, err, auth.ErrInvalidCredentials, "Incorrect password test")

	_, err = srv.Login("unknown-user", pass)
	require.ErrorIs(t, err, auth.ErrInvalidCredentials, "Incorrect username test")

	sess, err := srv.Login(user, pass)
	require.NoError(t, err)

	_, err = srv.SessionVerifyToken(sess.SessionToken)
	require.NoError(t, err)
}
