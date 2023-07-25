FROM docker.io/library/golang:alpine as build

WORKDIR /app

ENV GOPATH=/go

RUN go install github.com/fyne-io/fyne-cross@latest

FROM docker.io/library/docker:dind

COPY --from=build /go/bin/fyne-cross /usr/bin
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2