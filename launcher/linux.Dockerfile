# Stage 1: Flutter build
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

# flutter build tools
# https://docs.flutter.dev/platform-integration/linux/install-linux/install-linux-from-android
RUN sudo apt-get update && apt-get install \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev \
      libstdc++-12-dev -y

RUN flutter doctor

COPY ./brie /app
WORKDIR /app/

# add linux support if missing
RUN flutter create --platforms=linux .

# Build Flutter web
RUN flutter build linux --release

# Stage 2: api build
# use bookworm for gcc, required for cgo
FROM golang:1.23-bookworm AS api_builder

WORKDIR /app

COPY ./src .

# for sqlite
ENV CGO_ENABLED=1

RUN go mod tidy

# Build optimized binary without debugging symbols
RUN go build -ldflags "-s -w" -o gouda

# Stage 3: launcher build
# use bookworm for gcc, required for cgo
FROM golang:1.23-bookworm AS launcher_builder

WORKDIR /app

COPY ./launcher .

RUN go mod tidy

# Build optimized binary without debugging symbols
RUN go build -ldflags "-s -w" -o launcher


# Stage 3: Final stage
FROM debian:bookworm

WORKDIR /build/

COPY --from=api_builder /app/gouda ./api/

COPY --from=flutter_builder /app/build/linux/x64/release/bundle/* ./frontend/

COPY --from=launcher_builder /app/launcher ./

CMD ["/bin/sh", "-c", "cp -r /build/* /output/"]
