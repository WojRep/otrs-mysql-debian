#!/bin/bash
#


if [ "$OTRS_INSTALL" == "yes"  ]; then
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql

#	mysql_install_db
	mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
#
	touch /var/lib/mysql/firsttime
#	/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=root &
/usr/sbin/mysqld --pid-file=/var/run/mysqld/mysqld.pid --user=mysql &

#mysql_upgrade

	while :
	 do
	  if [ -e "/var/run/mysqld/mysqld.pid" ]; then
		echo $DB_ROOT_PASSWORD
		mysqladmin -u root password '$DB_ROOT_PASSWORD'
		#mysqladmin -u root -h localhost password '$DB_ROOT_PASSWORD'
		#echo "UPDATE mysql.user SET plugin = '' WHERE user = 'root';" | mysql -uroot -hlocalhost -p$DB_ROOT_PASSWORD
   	 if [ $? = 0 ]; then
  	      break
 	   fi
 	   echo "Change password failed. retry"
	  fi
	  sleep 2
	done
	
	#service mariadb stop


fi

