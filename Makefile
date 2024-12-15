build:
	go build -o bin/debug

dkcb:
	docker compose up --build

dkbd:
	docker build . -t ras344/gouda:dev

main:
	docker compose down
	docker compose --profile main up --force-recreate

gou:
	docker compose down
	docker compose --profile gou up --build --force-recreate

tor:
	docker compose down
	docker compose --profile tor up --force-recreate

