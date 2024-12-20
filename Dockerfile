# Stage 1: Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

RUN flutter config --enable-web --no-cli-animations && flutter doctor

COPY ./brie /app
WORKDIR /app/

# Build Flutter web
RUN flutter build web

# Stage 2: Go build
# use bookworm for gcc, required for cgo
FROM golang:1.23-bookworm AS go_builder

WORKDIR /app

COPY ./src .

# for sqlite
ENV CGO_ENABLED=1

RUN go mod tidy

# Build optimized binary without debugging symbols
RUN go build -ldflags "-s -w" -o gouda

# Stage 3: Final stage
FROM debian:bookworm-slim

WORKDIR /app/

RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=go_builder /app/gouda .
# Copy the Flutter web build
COPY --from=flutter_builder /app/build/web ./web

# start go-gin in release mode
ENV IS_DOCKER=true
ENV GIN_MODE=release

#RUN #chmod +x ./gouda
#CMD ["tail", "-f", "/dev/null"]

CMD ["./gouda"]

