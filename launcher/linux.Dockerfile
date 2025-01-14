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

RUN flutter build web

FROM golang:1.23-bookworm AS api_builder

WORKDIR /app

COPY ./src .

# for sqlite
ENV CGO_ENABLED=1

COPY --from=flutter_builder /app/build/web/* ./web/

RUN apt-get update && \
    apt-get install gcc libgtk-3-dev libayatana-appindicator3-dev -y

RUN go mod tidy

# Build optimized binary without debugging symbols
RUN go build -tags systray -ldflags "-X github.com/RA341/gouda/service.BinaryType=desktop" -o gouda-desktop

# Stage 3: Final stage
FROM debian:bookworm

WORKDIR /build/

COPY --from=api_builder /app/gouda-desktop ./gouda-desktop

COPY --from=flutter_builder /app/build/linux/x64/release/bundle/* ./frontend/

RUN chown -R 770

CMD ["/bin/sh", "-c", "cp -r /build/* /output/"]
