#!/usr/bin/env bash

set -e;

if [ ! -e local-config.json ]; then
    cp local-config-sample.json local-config.json;
    echo "Created local-config.json"
else
    echo "local-config.json is already exists."
fi
