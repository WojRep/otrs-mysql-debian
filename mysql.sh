#!/bin/bash
#


if [ "$OTRS_INSTALL" == "yes"  ]; then
rm -rf /var/lib/mysql
mkdir -p /var/lib/mysql
touch /var/lib/mysql/firsttime
mysql_install_db

mysqladmin -u root password '$DB_ROOT_PASSWORD'
mysqladmin -u root -h localhost password '$DB_ROOT_PASSWORD'

echo "UPDATE mysql.user SET plugin = '' WHERE user = 'root';" | mysql -uroot -hlocalhost -p$DB_ROOT_PASSWORD
fi

