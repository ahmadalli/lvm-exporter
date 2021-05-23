# syntax=docker/dockerfile:1
FROM golang:1.16 as build
WORKDIR /src/
COPY . .
RUN GO111MODULE=off go get -d -v ./...
RUN GO111MODULE=off CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add lvm2
WORKDIR /root/
COPY --from=build /src/app .
CMD ["./app"]
