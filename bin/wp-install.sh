#!/usr/bin/env bash

set -ex;

mysql.server start

DB_USER=${1-root}
DB_PASS=$2
DB_NAME=${3-wpdev}
PORT=8080
DOC_ROOT=$(pwd)
WP_PATH=$(pwd)/wp
WP_TITLE='Welcome to the WordPress'
WP_DESC='Hello World!'

if $(bin/wp core is-installed); then
    open http://127.0.0.1:$PORT
    bin/wp server --host=0.0.0.0 --port=$PORT --docroot=$DOC_ROOT
    exit 0
fi

if ! bin/wp --info ; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli-nightly.phar
    rm -fr bin && mkdir bin
    mv wp-cli-nightly.phar bin/wp
    chmod 755 bin/wp
fi

echo "path: wp" > $(pwd)/wp-cli.yml

if [ $DB_PASS ]; then
    echo "DROP DATABASE IF EXISTS $DB_NAME;" | mysql -u$DB_USER -p$DB_PASS
    echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql -u$DB_USER -p$DB_PASS
else
    echo "DROP DATABASE IF EXISTS $DB_NAME;" | mysql -u$DB_USER
    echo "CREATE DATABASE $DB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" | mysql -u$DB_USER
fi

bin/wp core install \
--url=http://127.0.0.1:$PORT \
--title="WordPress" \
--admin_user="admin" \
--admin_password="admin" \
--admin_email="admin@example.com"

bin/wp rewrite structure "/archives/%post_id%"

bin/wp option update blogname "$WP_TITLE"
bin/wp option update blogdescription "$WP_DESC"

if [ -e "provision-post.sh" ]; then
    bash provision-post.sh
fi

open http://127.0.0.1:$PORT
bin/wp server --host=0.0.0.0 --port=$PORT --docroot=$DOC_ROOT