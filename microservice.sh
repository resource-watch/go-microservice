#!/bin/bash

case "$1" in
    develop)
        docker build --target develop -t go-microservice-develop:latest .
        exec docker run -t -i \
        --mount type=bind,source="$(pwd)",target=/app,consistency=consistent \
        -p 3050:3050 \
        go-microservice-develop:latest \
        develop
        ;;
    *)
        echo "Usage: microservice.sh {develop}" >&2
        exit 1
        ;;
esac

exit 0
