FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

WORKDIR /web/

COPY ./brie/pubspec.* .

RUN flutter pub get

COPY ./brie .

RUN flutter build web --wasm

FROM golang:1-alpine AS go_builder

# for sqlite
ENV CGO_ENABLED=1

RUN apk update && apk add --no-cache gcc musl-dev

WORKDIR /core

COPY ./core/go.* .

RUN go mod download

COPY ./core .

ARG VERSION=dev
ARG COMMIT_INFO=unknown
ARG BRANCH=unknown
ARG INFO_PACKAGE=github.com/RA341/gouda/internal/info

ARG TARGET=docker

RUN go build -ldflags "-s -w \
             -X ${INFO_PACKAGE}.Flavour=${TARGET} \
             -X ${INFO_PACKAGE}.Version=${VERSION} \
             -X ${INFO_PACKAGE}.CommitInfo=${COMMIT_INFO} \
             -X ${INFO_PACKAGE}.BuildDate=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
             -X ${INFO_PACKAGE}.Branch=${BRANCH}" \
    -o gouda "./cmd/${TARGET}"

FROM alpine:latest AS main

ENV GOUDA_LOG_LEVEL=info
ENV GOUDA_CONFIG=/config
ENV GOUDA_DOWNLOAD=/downloads
ENV GOUDA_COMPLETE=/complete
ENV GOUDA_TORRENT=/torrents

WORKDIR /app/

COPY --from=go_builder /core/gouda gouda
COPY --from=flutter_builder /web/build/web web

ENTRYPOINT ["./gouda"]
