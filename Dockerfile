FROM docker.io/library/golang:alpine as build

WORKDIR /app

ENV GOPATH=/go

RUN apk add --no-cache --upgrade pigz
RUN apk upgrade --available
RUN wget https://github.com/fyne-io/fyne-cross/archive/refs/tags/v1.4.0.tar.gz
RUN pigz -cd v1.4.0.tar.gz | tar xf -
RUN cd fyne-cross-1.4.0; GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /fyne-cross


FROM docker.io/library/docker:dind


RUN apk add --no-cache --upgrade libc6-compat apk-tools zstd
RUN apk upgrade --available
COPY --from=build /fyne-cross /usr/bin
