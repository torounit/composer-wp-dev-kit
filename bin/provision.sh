#!/usr/bin/env bash

set -ex;

WP_CLI="wp-content/mu-plugins/vendor/wp-cli/wp-cli/bin/wp";

## Get config.
ROOT=$(cd $(dirname $0);cd ../;pwd)
DOC_ROOT=$ROOT
WP_PATH=$DOC_ROOT/wp
CONFIG_PATH=$ROOT/local-config.json

if [ -f "$CONFIG_PATH" ]; then
    DB_USER=$(cat $CONFIG_PATH | jq -r ".mysql.username")
    DB_PASS=$(cat $CONFIG_PATH | jq -r ".mysql.password")
    DB_NAME=$(cat $CONFIG_PATH | jq -r ".mysql.database")
    DB_HOST=$(cat $CONFIG_PATH | jq -r ".mysql.host")
    PORT=$(cat $CONFIG_PATH | jq -r ".server.port")

    WP_TITLE=$(cat $CONFIG_PATH | jq -r ".wp.title")
    WP_DESCRIPTION=$(cat $CONFIG_PATH | jq -r ".wp.description")
    WP_LANG=$(cat $CONFIG_PATH | jq -r ".wp.lang")
    WP_GMT_OFFSET=$(cat $CONFIG_PATH | jq -r ".wp.gmt_offset")
    WP_REWRITE_STRUCTURE=$(cat $CONFIG_PATH | jq -r ".wp.rewrute_structure")

    WP_ADMIN_USER=$(cat $CONFIG_PATH | jq -r ".wp.admin.user")
    WP_ADMIN_PASSWORD=$(cat $CONFIG_PATH | jq -r ".wp.admin.password")
    WP_ADMIN_EMAIL=$(cat $CONFIG_PATH | jq -r ".wp.admin.email")

    WP_THEME=$(cat $CONFIG_PATH | jq -r ".wp.theme")

else
    echo "local-config.json is NOT a file."
    exit 0
fi

if !(mysql.server status | fgrep -q SUCCESS); then
    echo "MySQL not Started."
    exit 0
fi

## Start Server if installed.
if ! $($WP_CLI core is-installed); then

    ## Recreate DB for WordPress.
    if [ $DB_PASS ]; then
        echo "DROP DATABASE IF EXISTS $DB_NAME;" | mysql -u$DB_USER -p$DB_PASS
        echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" | mysql -u$DB_USER -p$DB_PASS
    else
        echo "DROP DATABASE IF EXISTS $DB_NAME;" | mysql -u$DB_USER
        echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" | mysql -u$DB_USER
    fi

    ## Install WordPress.
    $WP_CLI core install \
    --url=http://127.0.0.1:$PORT \
    --path=wp \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"

    ## Setup Options.
    $WP_CLI option update blogname "$WP_TITLE"

    if [ $WP_DESCRIPTION ]; then
        $WP_CLI option update blogdescription "$WP_DESCRIPTION"
    fi

    if [ $WP_GMT_OFFSET ]; then
        $WP_CLI option update gmt_offset "$WP_GMT_OFFSET"
    fi

    if [ $WP_LANG ]; then
        $WP_CLI core language install $WP_LANG
        $WP_CLI core language activate $WP_LANG
    fi

    if [ $WP_REWRITE_STRUCTURE ]; then
        $WP_CLI rewrite structure "$WP_REWRITE_STRUCTURE"
    fi

    # Activate Theme.
    if [ $WP_THEME ]; then
        $WP_CLI theme activate "$WP_THEME"
    fi

    # Activate Plugins.
    $WP_CLI plugin activate --all

    # For Post Script.
    if [ -e "provision-post.sh" ]; then
        bash provision-post.sh
    fi

fi

#bash server.sh