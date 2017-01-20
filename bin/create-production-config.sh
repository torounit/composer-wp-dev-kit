#!/usr/bin/env bash

set -e;

if [ ! -e config.php ]; then
    cp config-sample.php config.php
    echo "Created config.php"
else
    cp config-sample.php config.php
    echo "Overwritten config.php"
fi
