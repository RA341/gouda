# Stage 1: Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

RUN flutter config --enable-web --no-cli-animations && flutter doctor

COPY ./brie /app
WORKDIR /app/

# Build Flutter web
RUN flutter build web

# Stage 2: Go build
FROM golang:1.23-alpine AS go_builder

WORKDIR /app

COPY ./src .

RUN go mod tidy

# Build optimized binary without debugging symbols
RUN go build -ldflags "-s -w" -o app

# Stage 3: Final stage
FROM alpine:latest

WORKDIR /app/

RUN apk update

COPY --from=go_builder /app/app .
# Copy the Flutter web build
COPY --from=flutter_builder /app/build/web ./web

# start go-gin in release mode
ENV IS_DOCKER=true
ENV GIN_MODE=release

CMD ["./app"]
