transmission:
	docker compose -f test-docker-compose.yml up

build:
	go build -o bin/debug

dkdg:
	docker compose -f test-docker-compose.yml up --build