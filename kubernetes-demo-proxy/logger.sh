#!/usr/bin/env bash

TIMESTAMP=$(date "+%Y-%m-%d %T")

LOG() {
  echo "${TIMESTAMP} | $1 | $2"
}

INFO() {
  LOG "INFO" "${1}"
}

DEBUG() {
  LOG "DEBUG" "${1}"
}

case $1 in
    -d|--debug)
    DEBUG "$2"
    ;;
    -i|--info)
    INFO "$2"
    ;;
    *)    # default
    INFO "$1"
    ;;
esac
