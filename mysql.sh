#!/bin/bash
#


if [ "$OTRS_INSTALL" == "yes"  ]; then
rm -rf /var/lib/mysql
mkdir -p /var/lib/mysql
touch /var/lib/mysql/firsttime
mysql_install_db

fi

