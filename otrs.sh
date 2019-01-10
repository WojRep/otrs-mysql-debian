#!/bin/bash
#


useradd -b /opt/otrs otrs
usermod -aG www-data otrs
cd /opt/otrs
bin/otrs.SetPermissions.pl
#
ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf
#
a2enmod perl
a2enmod deflate
a2enmod filter
a2enmod headers
#
cd /opt/otrs/var/cron
su -c "for foo in *.dist; do cp $foo `basename $foo .dist`; done" -s /bin/bash otrs
/opt/otrs/bin/Cron.sh start otrs
su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
#


