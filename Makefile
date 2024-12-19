build:
	go build -o bin/debug

dkcb:
	docker compose up --build

lint:
	clear
	cd src && golangci-lint run

dkbd:
	docker build . -t ras344/gouda:local --no-cache

main:
	docker compose down
	docker compose --profile main up --force-recreate

gou:
	docker compose down
	docker compose --profile gou up --build --force-recreate

tor:
	docker compose down
	docker compose --profile tor up --force-recreate

ui:
	cd brie && flutter build web