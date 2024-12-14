transmission:
	docker compose -f test-docker-compose.yml up

build:
	go build -o bin/debug

dkcb:
	docker compose -f test-docker-compose.yml up --build

dkbd:
	docker build . -t ras344/gouda:dev

tor:
	docker compose --profile tor -f test-docker-compose.yml up

