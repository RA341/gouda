# Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

WORKDIR /app/

COPY ./brie/pubspec.* .

RUN flutter pub get

COPY ./brie .

# Build Flutter web
RUN flutter build web

# Stage Go build
FROM golang:1.24-alpine AS go_builder

# arg substitution
# https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG VERSION
ENV BV=${VERSION}
# for sqlite
ENV CGO_ENABLED=1

RUN apk update && apk add --no-cache gcc musl-dev

WORKDIR /app

COPY ./src/go.* .

RUN go mod download

COPY ./src .

COPY --from=flutter_builder /app/build/web ./web

# Build optimized binary without debugging symbols
RUN go build  \
    -ldflags "-s -w -X github.com/RA341/gouda/utils.Version=$BV" \
    -o gouda

# Stage: Final stage
FROM alpine:latest

ENV IS_DOCKER=true

WORKDIR /app/

COPY --from=go_builder /app/gouda .

CMD ["./gouda"]
