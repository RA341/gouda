FROM golang:1.24-alpine AS goub

# for sqlite
ENV CGO_ENABLED=1

RUN apk update && apk add --no-cache gcc musl-dev

WORKDIR /app

COPY ./goub/ .

RUN go build -o=goub

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

COPY --from=flutter_builder /app/build/web ./cmd/web

# Build arguments
ARG VERSION=dev
ARG COMMIT_INFO=unknown
ARG BUILD_DATE=unknown
ARG BRANCH=unknown

# arg substitution, do not put it higher than this for caching
# https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ENV VERSION=${VERSION}
ENV COMMIT_INFO=${COMMIT_INFO}
ENV BUILD_DATE=${BUILD_DATE}
ENV BRANCH=${BRANCH}

COPY --from=goub /app/goub .
# custom build tool
RUN ./goub go build server -o=out -c=${COMMIT_INFO} -t=${VERSION} -b=${BRANCH}
RUN mv out/gouda-server-linux gouda

FROM alpine:latest

ENV IS_DOCKER=true
ENV GOUDA_LOG_LEVEL=info

WORKDIR /app/

COPY --from=go_builder /app/gouda .

CMD ["./gouda"]
