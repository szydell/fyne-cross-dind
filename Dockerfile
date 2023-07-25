FROM docker.io/library/golang:alpine as build

WORKDIR /app

ENV GOPATH=/go

RUN go install github.com/fyne-io/fyne-cross@latest

FROM docker.io/library/docker:dind

COPY --from=build /go/bin/fyne-cross /usr/bin

CMD [ "bash" ]
