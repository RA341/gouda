# Stage 1: Flutter builder
FROM ghcr.io/cirruslabs/flutter:stable AS flutter_builder

# Flutter build tools
RUN sudo apt-get update && apt-get install \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev \
      libstdc++-12-dev -y

RUN flutter doctor

COPY ./brie /app
WORKDIR /app/

# build Linux desktop
RUN flutter build linux --release

# Build Flutter web
RUN flutter build web

# Stage 2: API builder
FROM golang:1.23-bookworm AS desktop_builder

# arg substitution
# https://stackoverflow.com/questions/44438637/arg-substitution-in-run-command-not-working-for-dockerfile
ARG VERSION
ENV BV=${VERSION}

WORKDIR /app

COPY ./src .

# For sqlite
ENV CGO_ENABLED=1

# Copy from Flutter builder
COPY --from=flutter_builder /app/build/web/* ./web/

RUN apt-get update && \
    apt-get install gcc libgtk-3-dev libayatana-appindicator3-dev -y

RUN go mod tidy

# Build gouda desktop variant
RUN go build -tags systray -ldflags "-s -w \
        -X github.com/RA341/gouda/service.BinaryType=desktop \
        -X github.com/RA341/gouda/service.Version=$BV" \
        -o gouda-desktop


FROM golang:1.23-bookworm AS server_builder

ARG VERSION
ENV BV=${VERSION}

WORKDIR /app

COPY ./src .

# For sqlite
ENV CGO_ENABLED=1

# Copy from Flutter builder
COPY --from=flutter_builder /app/build/web/* ./web/

RUN go mod tidy

# Build gouda server variant
RUN go build -ldflags "-s -w \
        -X github.com/RA341/gouda/service.Version=$BV" \
        -o gouda-server-linux

FROM ubuntu:latest AS gouda_desktop_builder

WORKDIR /build/

COPY --from=server_builder /app/gouda-server-linux ./gouda-server-linux

COPY --from=desktop_builder /app/gouda-desktop ./gouda-desktop

COPY --from=flutter_builder /app/build/linux/x64/release/bundle/* ./frontend/

RUN apt-get update && \
    apt-get install zip -y

# Fix permissions
RUN chown -R 1000:1000 . \
    && chmod +x gouda-desktop \
    && chmod +x gouda-server-linux \
    && zip -r ./gouda-desktop-linux.zip *

# copy both files to their respective dirs
CMD ["/bin/sh", "-c", "cp -r /build/gouda-server-linux /server/gouda-server-linux && cp -r /build/gouda-desktop-linux.zip /desktop/gouda-desktop-linux.zip"]
