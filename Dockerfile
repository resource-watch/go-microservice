# DEVELOP
FROM golang:alpine AS builder
RUN apk update && apk upgrade && apk add --no-cache --update bash git curl ca-certificates && rm -rf /var/cache/apk/*
RUN go get github.com/oxequa/realize
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
WORKDIR /go/src/app
ADD . /go/src/app
RUN dep ensure
ARG debug=false
ARG env=prod
ENV DEBUG $debug
ENV ENV $env
RUN [ "$ENV" == "prod" ] && cd /go/src/app/src && go build -o goapp || echo "no prod"
EXPOSE 3050
ENTRYPOINT ["./entrypoint.sh"]

FROM alpine
RUN apk update && apk upgrade && apk add --no-cache --update ca-certificates && rm -rf /var/cache/apk/*
WORKDIR /go/src/app
COPY --from=builder /go/src/app/src/goapp /go/src/app
ENTRYPOINT ["./goapp"]
