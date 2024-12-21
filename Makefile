build:
	go build -o bin/debug

dkcb:
	docker compose up --build

lint:
	clear
	golangci-lint run

dkbd:
	docker build . -t ras344/gouda:local

prune:
	docker image prune -f

devp:
	docker build . -t ras334/gouda:dev
	docker login
	docker push ras334/gouda:dev

# no cache build
dkc:
	docker build . -t ras334/gouda:local --no-cache

main:
	docker compose down
	docker compose --profile main up --force-recreate

loc:
	docker compose down
	docker compose --profile local up --build --force-recreate


gou:
	docker compose down
	docker compose --profile gou up --build --force-recreate

tor:
	docker compose down
	docker compose --profile tor up --force-recreate

ui:
	cd brie && flutter build web