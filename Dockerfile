# Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

RUN flutter config --enable-web --no-cli-animations && flutter doctor

COPY ./brie /app
WORKDIR /app/

# Build Flutter web
RUN flutter build web

# Stage Go build
FROM golang:1.23-alpine AS go_builder

WORKDIR /app

COPY ./src .

# arg substitution
# https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG VERSION
ENV BV=${VERSION}

# for sqlite
ENV CGO_ENABLED=1

RUN apk update && apk add --no-cache gcc musl-dev

RUN go mod tidy

COPY --from=flutter_builder /app/build/web ./web

# Build optimized binary without debugging symbols
RUN go build  \
    -ldflags "-s -w -X github.com/RA341/gouda/utils.Version=$BV" \
    -o gouda

# Stage: Final stage
FROM alpine:latest

WORKDIR /app/

COPY --from=go_builder /app/gouda .

# start go-gin in release mode
ENV IS_DOCKER=true
ENV GIN_MODE=release

CMD ["./gouda"]

