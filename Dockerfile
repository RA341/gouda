FROM golang:1.23-alpine AS builder

WORKDIR /app

RUN apk update

COPY ./src .

# get depedencies
RUN go mod tidy

# build optimized binary without debugging symbols
RUN go build -ldflags "-s -w" -o app

FROM alpine:latest

WORKDIR /app/

RUN apk update

COPY --from=builder /app/app .

# start go-gin in release mode
ENV IS_DOCKER=true
ENV GIN_MODE=release

CMD ["./app"]
