#!/bin/bash
#
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &
/mysql.sh
