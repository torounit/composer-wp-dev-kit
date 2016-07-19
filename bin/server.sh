#!/usr/bin/env bash

set -ex;

if ! which jq; then
    echo "jq is not installed"
    exit 0;
fi

if ! which wp; then
    echo "WP-CLI is not installed"
    exit 0;
fi

if !(mysql.server status | fgrep -q SUCCESS); then
    echo "MySQL not Started."
    exit 0
fi

## Get config.
ROOT=$(cd $(dirname $0);cd ../;pwd)
DOC_ROOT=$ROOT
WP_PATH=$DOC_ROOT/wp
CONFIG_PATH=$ROOT/local-config.json

if [ -f "$CONFIG_PATH" ]; then
    PORT=$(cat $CONFIG_PATH | jq -r ".server.port")
    HOST=$(cat $CONFIG_PATH | jq -r ".server.host")

else
    echo "local-config.json is NOT a file."
    exit 0
fi

## Open Built-in Server
open http://$HOST:$PORT
wp server --host=$HOST --port=$PORT --docroot=$DOC_ROOT
