#!/bin/sh
set -e

if [ ! -f index.php ]; then
    git clone -q ${REPO_URL} .
    rm -rf .git .github .gitignore
    chmod a+rw -R application runtime upload static addons
    echo "maccms10 downloaded"
fi

if [ -f admin.php ]; then
    mv admin.php $ADMIN_PHP
    echo "admin.php => $ADMIN_PHP"
fi

exec "$@"