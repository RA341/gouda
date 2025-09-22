package auth_test

import (
	"testing"
	"time"

	"github.com/RA341/gouda/internal/auth"
	"github.com/stretchr/testify/require"
)

func Test_SessionExpiry(t *testing.T) {
	_ = setup(t)

	tokenDuration := time.Second * 1

	customSession := auth.NewSessionServiceWithCustomDuration(
		sessionStore,
		tokenDuration,
		tokenDuration,
	)

	srv := &auth.Service{
		SessionService: customSession,
		User:           userStore,
	}

	user := "test"
	pass := "test"

	err := srv.Register(user, pass, auth.RoleAdmin)
	require.NoError(t, err)

	ses, err := srv.Login(user, pass)
	require.NoError(t, err)

	err = srv.SessionVerifySessionToken(ses.SessionToken)
	require.NoError(t, err)

	time.Sleep(tokenDuration)

	err = srv.SessionVerifySessionToken(ses.SessionToken)
	require.ErrorIs(t, err, auth.ErrInvalidSessionTokenExpired)
}

func Test_SessionDelete(t *testing.T) {
	srv := setup(t)

	user := "test"
	pass := "test"

	err := srv.Register(user, pass, auth.RoleAdmin)
	require.NoError(t, err)

	ses, err := srv.Login(user, pass)
	require.NoError(t, err)

	err = srv.SessionVerifySessionToken(ses.SessionToken)
	require.NoError(t, err)

	err = srv.SessionDelete(ses.ID)
	require.NoError(t, err)

	err = srv.SessionVerifySessionToken(ses.SessionToken)
	require.ErrorIs(t, err, auth.ErrInvalidSessionToken)
}

func Test_SessionLimit(t *testing.T) {
	srv := setup(t)

	user := "test"
	pass := "test"

	err := srv.Register(user, pass, auth.RoleAdmin)
	require.NoError(t, err)

	sessionLimit := 5
	initialSession, err := srv.Login(user, pass)
	require.NoError(t, err)

	err = srv.UpdateUserSessionLimit(initialSession.UserID, uint(sessionLimit))
	require.NoError(t, err)

	var loopSession []*auth.Session
	for i := 0; i < sessionLimit; i++ {
		ses, err := srv.Login(user, pass)
		require.NoErrorf(t, err, "login failed on attempt %d", i)

		require.NotNil(t, ses)
		loopSession = append(loopSession, ses)
	}

	for _, s := range loopSession {
		err = srv.SessionVerifySessionToken(s.SessionToken)
		require.NoError(t, err)
	}

	err = srv.SessionVerifySessionToken(initialSession.SessionToken)
	require.Error(t, err)
}
