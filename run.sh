#!/bin/bash
#
/otrs_install.sh
#
ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf
#
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &
/mysql.sh
#
cd /opt/otrs
bin/otrs.SetPermissions.pl
#
/opt/otrs/bin/Cron.sh start otrs
su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
#
#
while true
do
 tail -f /dev/null & wait ${!}
done
