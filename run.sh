#!/bin/bash
#
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &
/mysql.sh
#
/opt/otrs/bin/Cron.sh start otrs
su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
#
#
while true
do
 tail -f /dev/null & wait ${!}
done
