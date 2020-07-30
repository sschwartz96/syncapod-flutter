protoc --dart_out=grpc:lib/protos/ \
    -I C:/Users/sam/projects/protos/syncapod-protos/ \
    "C:/Program Files/protoc-3.12.3-win64/include/google/protobuf/timestamp.proto" \
    C:/Users/sam/projects/protos/syncapod-protos/*.proto