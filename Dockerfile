# DEVELOP
FROM golang:alpine AS develop
RUN apk update && apk upgrade && apk add --no-cache --update bash git ca-certificates && rm -rf /var/cache/apk/*
RUN go get -u github.com/kataras/iris
RUN go get github.com/oxequa/realize
WORKDIR /app
ADD . /app
ENV DEBUG true
EXPOSE 3050
ENTRYPOINT ["./entrypoint.sh"]

# BUILDER
FROM golang:alpine AS builder
RUN apk update && apk upgrade && apk add --no-cache --update bash git ca-certificates && rm -rf /var/cache/apk/*
RUN go get -u github.com/kataras/iris
WORKDIR /app
ADD . /app
RUN cd /app/src && go build -o goapp

FROM alpine
RUN apk update && apk upgrade && apk add --no-cache --update bash git ca-certificates && rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=builder /app/src/goapp /app
COPY --from=builder /app/entrypoint.sh /app

ENTRYPOINT ["./entrypoint.sh"]
