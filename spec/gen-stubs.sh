#!/bin/bash

# Create output directories
mkdir -p generated/dart generated/go generated/web

# Generate Dart gRPC stubs
#protoc \
#  --proto_path=./protos/ \
#  -I./protos \
#  --dart_out=grpc:./generated/dart \
#  $(find protos/ -name "*.proto")

# Generate Connect-RPC stubs using buf
buf generate

# Fix permissions on generated files
chmod -R 770 ./generated
