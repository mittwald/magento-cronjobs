#!/bin/sh
# Author: Daniel Kraemer <d.kraemer@mittwald.de> for Mittwald CM Service GmbH & Co. KG
# Author: Daniel Wolf <d.wolf@mittwald.de> for Mittwald CM Service GmbH & Co. KG
# Description: Shellscript for starting Magento-cronjobs without the need of "ps".
# Compatible Magento versions: 1.9.2.4, 1.9.2.3, 1.9.2.2, 1.9.2.1, 1.9.2.0, 1.9.1.1, 1.9.1.0, 1.9.0.1, 1.8.1.0, 1.8.0.0

# Please report bugs and feedback to
# https://github.com/mittwald/magento-cronjobs/issues

lockfile=/tmp/cron.lock
PHP_BIN=/usr/local/bin/php_cli
ABSOLUTE_PATH=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)/$(basename "${BASH_SOURCE[0]}")
INSTALLDIR=${ABSOLUTE_PATH%/*}

function cleanup() {
    for cpid in $(jobs -p); do kill $cpid; done
    rm -f $lockfile
}

trap cleanup 1 2 3 6 9 15

if [ ! -f $lockfile ];then
    echo $$ > $lockfile
else
    if [ $(find $lockfile -mmin +59) ];then
        rm -f $lockfile
    else
        exit 0
    fi
fi

if [ -n "$1" ] ; then
    CRONSCRIPT=$1
else
    CRONSCRIPT=cron.php
fi

for i in default always; do
    $PHP_BIN $INSTALLDIR/$CRONSCRIPT -m$i 1>/dev/null 2>&1 &
done
wait
rm -f $lockfile

exit 0
