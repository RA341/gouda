set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

build:
    go build -o bin/debug

lint:
    clear
    golangci-lint run

dkbd:
    docker build . -t ras334/gouda:dev

prune:
    docker image prune -f

devr:
    just dkbd
    docker run --rm -e GOUDA_USERNAME=admin -e GOUDA_PASS=admin -p 9862:9862 ras334/gouda:dev

devp:
    just dkbd
    docker login
    docker push ras334/gouda:dev

# no cache build
dkc:
    docker build . -t ras334/gouda:local --no-cache

main:
    docker compose down
    docker compose --profile main up --force-recreate

[working-directory: 'brie']
ui:
    flutter build web

loc:
    just ui
    docker compose down
    docker compose --profile local up --build --force-recreate

gou:
    docker compose down
    docker compose --profile gou up --build --force-recreate

tor:
    docker compose down
    docker compose --profile tor up --force-recreate
