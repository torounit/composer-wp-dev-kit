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
    THEME_UNIT_TEST_URI=$(cat $CONFIG_PATH | jq -r ".theme_unit_test_uri")
else
    echo "local-config.json is NOT a file."
    exit 0
fi

wp plugin activate wordpress-importer
curl $THEME_UNIT_TEST_URI > theme-unit-test-data.xml
wp wxr-importer import theme-unit-test-data.xml
rm theme-unit-test-data.xml