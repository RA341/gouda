# Stage 1: Flutter build
FROM debian:latest AS flutter_builder

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter doctor
RUN flutter config --enable-web

# Clone your repository
RUN git clone https://github.com/RA341/brie /app
WORKDIR /app/

# Build Flutter web
RUN flutter build web

# Stage 2: Go build
FROM golang:1.23-alpine AS go_builder

WORKDIR /app

RUN apk update

# Copy the Go source code
COPY ./src .

# Get dependencies
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
