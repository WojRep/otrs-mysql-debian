#!/bin/bash
#


if [ "$OTRS_INSTALL" == "yes"  ]; then
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
	touch /var/lib/mysql/firsttime
	/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=mysql &

	while :
	 do
	  if [ -e "/var/run/mysqld/mysqld.pid" ]; then
		echo $DB_ROOT_PASSWORD
		echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';GRANT ALL PRIVILEGES ON *.* TO 'root’@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';FLUSH PRIVILEGES;"| mysql
		echo "UPDATE mysql.user SET plugin = '';FLUSH PRIVILEGES;"| mysql
   	 if [ $? = 0 ]; then
  	      break
 	   fi
 	   echo "Change password failed. retry"
	  fi
	  sleep 2
	done
fi

