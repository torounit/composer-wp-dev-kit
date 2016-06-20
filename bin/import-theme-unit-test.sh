#!/usr/bin/env bash

set -ex;

WP_CLI="wp-content/mu-plugins/vendor/wp-cli/wp-cli/bin/wp";

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

$WP_CLI plugin activate wordpress-importer
curl https://raw.githubusercontent.com/jawordpressorg/theme-test-data-ja/master/wordpress-theme-test-date-ja.xml > theme-unit-test-data.xml
$WP_CLI wxr-importer import theme-unit-test-data.xml
rm theme-unit-test-data.xml