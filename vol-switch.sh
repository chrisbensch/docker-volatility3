#!/bin/sh

case "$1" in
    vol)
    vol "${@:2}" ;;
    shell)
    /bin/sh;;
    "")
    vol "${@:2}" ;;
    *)
        echo "Unsupported command: $1"
esac
