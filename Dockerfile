FROM golang:alpine AS build

RUN apk add --no-cache curl git alpine-sdk
WORKDIR $GOPATH/src/github.com/servian/TechChallengeApp

COPY go.mod go.sum $GOPATH/src/github.com/servian/TechChallengeApp/

RUN go mod tidy

COPY . .

RUN go build -ldflags="-s -w" -a -o /TechChallengeApp

FROM alpine:latest

WORKDIR /TechChallengeApp

COPY assets ./assets
COPY conf.toml ./conf.toml
COPY --from=build /TechChallengeApp TechChallengeApp

ENTRYPOINT [ "./TechChallengeApp" ]