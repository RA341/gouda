package notifications

import "testing"

func TestNotificationService_SendNotif(t *testing.T) {
	no := NotificationService{}

	no.SendNotif(WithType(DownloadUpdate), WithTitle("Download Complete"))
	no.SendNotif(WithType(MediaUpdate), WithBody("asdasd"))
}
