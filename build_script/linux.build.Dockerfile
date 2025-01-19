# common flutter base
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_base

# Flutter build tools
RUN apt-get update && apt-get install --no-install-recommends -y \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev \
      libstdc++-12-dev


COPY ./brie /app
WORKDIR /app/

RUN flutter doctor && \
    flutter config --enable-linux-desktop && \
    flutter config --enable-web && \
    flutter pub get

# Web builder
FROM flutter_base AS f_web_builder
# Build Flutter web
RUN flutter build web

# Desktop builder
FROM flutter_base AS f_desktop_builder
# build Linux desktop
RUN flutter build linux --release

# go base
FROM golang:1.23-bookworm AS go_base

WORKDIR /app
COPY ./src .

RUN go mod tidy

# For sqlite
ENV CGO_ENABLED=1

# arg substitution
# https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG VERSION
ENV BV=${VERSION}

# desktop variant
FROM go_base AS go_desktop_builder

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gcc libgtk-3-dev libayatana-appindicator3-dev
# Copy web build
COPY --from=f_web_builder /app/build/web/* ./web/
# Build gouda desktop variant
RUN go build -tags systray -ldflags "-s -w \
        -X github.com/RA341/gouda/service.Version=$BV \
        -X github.com/RA341/gouda/service.BinaryType=desktop \
        " -o gouda-desktop

FROM go_base AS go_server_builder
# Copy web build
COPY --from=f_web_builder /app/build/web/* ./web/
# Build gouda server variant
RUN go build -ldflags "-s -w \
        -X github.com/RA341/gouda/service.Version=$BV" \
        -o gouda-server-linux

FROM ubuntu:latest AS final_builder

WORKDIR /build/

RUN apt-get update && \
    apt-get install --no-install-recommends -y zip

COPY --from=go_server_builder /app/gouda-server-linux ./gouda-server-linux

COPY --from=go_desktop_builder /app/gouda-desktop ./gouda-desktop

COPY --from=f_desktop_builder /app/build/linux/x64/release/bundle/ ./frontend/

# Fix permissions
RUN chown -R 1000:1000 . \
    && chmod +x gouda-desktop \
    && chmod +x gouda-server-linux \
    && zip -r ./gouda-desktop-linux.zip * --exclude "gouda-server-linux"

# copy both files to their respective dirs
CMD ["/bin/sh", "-c", "\
    cp -r /build/gouda-server-linux /server/gouda-server-linux && \
    cp -r /build/gouda-desktop-linux.zip /desktop/gouda-desktop-linux.zip"]
