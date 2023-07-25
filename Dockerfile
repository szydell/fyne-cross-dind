FROM docker.io/library/golang:alpine as build

WORKDIR /app

ENV GOPATH=/go

RUN go install github.com/fyne-io/fyne-cross@latest

FROM docker.io/library/docker:dind


RUN apk add --no-cache --upgrade libc6-compat apk-tools zstd
RUN apk upgrade --available
COPY --from=build /go/bin/fyne-cross /usr/bin
