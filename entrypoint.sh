#!/bin/bash
set -e

case "$1" in
    develop)
        echo "Running Develop"
        exec realize start --run
        ;;
    start)
        echo "Running Start"
        exec ./goapp
        ;;
    *)
        exec "$@"
esac
