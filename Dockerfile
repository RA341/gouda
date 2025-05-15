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

# build optimized binary without debugging symbols
RUN SOURCE_HASH=$(find . -type f -name "*.go" -print0 | sort -z | xargs -0 cat | sha256sum | cut -d ' ' -f1) && \
    go build -ldflags "-s -w \
        -X github.com/RA341/gouda/internal/info.Version=${VERSION} \
        -X github.com/RA341/gouda/internal/info.CommitInfo=${COMMIT_INFO} \
        -X github.com/RA341/gouda/internal/info.BuildDate=${BUILD_DATE} \
        -X github.com/RA341/gouda/internal/info.Branch=${BRANCH} \
        -X github.com/RA341/gouda/internal/info.SourceHash=${SOURCE_HASH} \
    " \
    -o gouda ./cmd/server


# Stage: Final stage
FROM alpine:latest

ENV IS_DOCKER=true

WORKDIR /app/

COPY --from=go_builder /app/gouda .

CMD ["./gouda"]
