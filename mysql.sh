#!/bin/bash
#
echo "#################################\n"
echo "##                    \n"
echo "##  ".$DB_ROOT_PASSWORD.”   \n”
echo "##                    \n"
echo "#################################\n"

if [ "$OTRS_INSTALL" == "yes"  ]; then
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
	touch /var/lib/mysql/firsttime
	/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=mysql &

	while :
	 do
	  if [ -e "/var/run/mysqld/mysqld.pid" ]; then
		echo "USE mysql;UPDATE mysql.user SET plugin = 'mysql_native_password';FLUSH PRIVILEGES;"| mysql		echo "USE mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';FLUSH PRIVILEGES;"| mysql
		
   	 if [ $? = 0 ]; then
  	      break
 	   fi
 	   echo "Change password failed. retry"
	  fi
	  sleep 2
	done
fi

