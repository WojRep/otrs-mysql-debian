#!/bin/bash
#
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &
/mysql.sh
#
while true
do
 tail -f /dev/null & wait ${!}
done
