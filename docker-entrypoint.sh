#!/bin/sh
set -e

if [ ! -f index.php ]; then
    git clone -q ${REPO_URL} .
    mv admin.php cmsadmin.php
    chmod a+rw -R application runtime upload static addons
    echo "maccms10 Initialized"
fi

exec "$@"