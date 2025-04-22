set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

list:
    just --list

# lint go (currently broken)
lint:
    clear
    golangci-lint run

# build a gouda dev image
dkbd:
    docker build . -t ras334/gouda:dev

# prune docker containers
prune:
    docker image prune -f

# start a temprory gouda build using docker run
devr:
    just dkbd
    docker run --rm -e GOUDA_USERNAME=admin -e GOUDA_PASS=admin -p 9862:9862 ras334/gouda:dev

# build and push gouda:dev build
devp:
    just dkbd
    docker login
    docker push ras334/gouda:dev

# no cache docker build
dkc:
    docker build . -t ras334/gouda:local --no-cache

# build the latest web ui
[working-directory: 'brie']
ui:
    flutter build web
    rm -r ../src/cmd/web
    cp -r build/web/ ../src/cmd/web

# a dev docker build only with gouda
loc:
    docker compose down
    docker compose --profile local up --build --force-recreate

# a dev docker build with gouda and transmission
gou:
    docker compose down
    docker compose --profile gou up --build --force-recreate

# start a transmission inst for testing
tor:
    docker compose down
    docker compose --profile tor up --force-recreate

# start a qbit inst for testing
qbit:
    docker compose down
    docker compose --profile qbit up --force-recreate
    docker compose down

# start a deluge inst for testing
delug:
    docker compose down
    docker compose --profile delug up --force-recreate
    docker compose down

