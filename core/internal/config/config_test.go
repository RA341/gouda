package config

import "testing"

func TestLoadConf(t *testing.T) {
	conf, err := LoadConf()
	if err != nil {
		t.Fatal(err)
	}

	t.Log(conf)
}
