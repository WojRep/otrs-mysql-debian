#!/bin/bash
#
echo "#################################"
echo "##                    "
echo "##  ".$DB_ROOT_PASSWORD
echo "##                    "
echo "#################################"
echo "Start mysql.sh" > /tmp/mysql.log
if [ "$OTRS_INSTALL" == "yes"  ]; then
	echo "OTRS_INSTALL=$OTRS_INSTALL" >> /tmp/mysql.log
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	echo "Initializing MySQL" >> /tmp/mysql.log
	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
	touch /var/lib/mysql/firsttime
	echo "Starting MySQLd" >> /tmp/mysql.log
	/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=mysql &
	sleep 10
	while :
	 do
	  if [ -e "/var/run/mysqld/mysqld.pid" ]; then
		echo "/var/run/mysqld/mysqld.pid" >> /tmp/mysql.log
		echo "Start update privileges and set root password" >> /tmp/mysql.log
		echo "USE mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';FLUSH PRIVILEGES;"| mysql
		echo "UPDATE mysql.user SET plugin = 'mysql_native_password';FLUSH PRIVILEGES;"| mysql
		echo "UPDATE mysql.user SET authentication_string = PASSWORD('$DB_ROOT_PASSWORD') WHERE User = 'root';FLUSH PRIVILEGES;"| mysql
		#echo "USE mysql;GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';FLUSH PRIVILEGES;"| mysql
   	 if [ $? = 0 ]; then
		  echo "braek" >> /tmp/mysql.log
  	      break
 	   fi
 	   echo "Change password failed. retry"
	   echo "Change password failed. retry" >> /tmp/mysql.log
	  fi
	  sleep 5
	  echo "sleep 5" >> /tmp/mysql.log
	done
fi

echo "End mysql.sh" >> /tmp/mysql.log
