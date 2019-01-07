#!/bin/bash
#


if [ "OTRS_INSTALL" == "yes"  ]; then

touch /var/lib/mysql/firsttime
mysql_install_db

fi

