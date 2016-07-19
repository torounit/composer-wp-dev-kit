#!/usr/bin/env bash

set -ex;

WP_CLI="wp-content/mu-plugins/vendor/wp-cli/wp-cli/bin/wp";

## Get config.
ROOT=$(cd $(dirname $0);cd ../;pwd)
DOC_ROOT=$ROOT
WP_PATH=$DOC_ROOT/wp
CONFIG_PATH=$ROOT/local-config.json

if [ -f "$CONFIG_PATH" ]; then
    PORT=$(cat $CONFIG_PATH | jq -r ".server.port")

else
    echo "local-config.json is NOT a file."
    exit 0
fi

if !(mysql.server status | fgrep -q SUCCESS); then
    echo "MySQL not Started."
    exit 0
fi

## Open Built-in Server
open http://127.0.0.1:$PORT
$WP_CLI server --host=0.0.0.0 --port=$PORT --docroot=$DOC_ROOT
