#!/bin/sh

case "$1" in
    vol3)
    vol3 "${@:2}" ;;
    shell)
    /bin/sh;;
    "")
    vol3 "${@:2}" ;;
    *)
        echo "Unsupported command: $1"
esac
