# Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

WORKDIR /app/

COPY ./brie/pubspec.* .

RUN flutter pub get

COPY ./brie .

RUN flutter build web

# Stage Go build
FROM golang:1.24-alpine AS go_builder

# for sqlite
ENV CGO_ENABLED=1

RUN apk update && apk add --no-cache gcc musl-dev

WORKDIR /app

COPY ./src/go.* .

RUN go mod download

COPY ./src .

ARG VERSION=dev
ARG COMMIT_INFO=unknown
ARG BRANCH=unknown
ARG INFO_PACKAGE=github.com/RA341/gouda/internal/info

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags "-s -w \
             -X ${INFO_PACKAGE}.Flavour=Docker \
             -X ${INFO_PACKAGE}.Version=${VERSION} \
             -X ${INFO_PACKAGE}.CommitInfo=${COMMIT_INFO} \
             -X ${INFO_PACKAGE}.BuildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
             -X ${INFO_PACKAGE}.Branch=${BRANCH}" \
    -o gouda "./cmd/server"

FROM alpine:latest as main

ENV GOUDA_LOG_LEVEL=info
ENV GOUDA_CONFIG=/config
ENV GOUDA_DOWNLOAD=/downloads
Env GOUDA_COMPLETE=/complete
Env GOUDA_TORRENT=/torrents

WORKDIR /app/

COPY --from=go_builder /app/gouda gouda
COPY --from=flutter_builder /app/build/web web

ENTRYPOINT ["./gouda"]
