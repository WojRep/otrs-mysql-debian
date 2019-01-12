#!/bin/bash
#
echo "#################################"
echo "##                    "
echo "##  ".$DB_ROOT_PASSWORD
echo "##                    "
echo "#################################"

if [ "$OTRS_INSTALL" == "yes"  ]; then
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
	touch /var/lib/mysql/firsttime
	/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=mysql &

	while :
	 do
	  if [ -e "/var/run/mysqld/mysqld.pid" ]; then
		echo "USE mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';"| mysql
		echo "USE mysql;UPDATE mysql.user SET plugin = 'mysql_native_password'"| mysql
		echo "UPDATE mysql.user SET authentication_string = PASSWORD('$DB_ROOT_PASSWORD') WHERE User = 'root';;FLUSH PRIVILEGES;"| mysql
		#echo "USE mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';FLUSH PRIVILEGES;"| mysql
   	 if [ $? = 0 ]; then
  	      break
 	   fi
 	   echo "Change password failed. retry"
	  fi
	  sleep 2
	done
fi

