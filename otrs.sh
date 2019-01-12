#!/bin/bash
#
useradd -b /opt/otrs otrs
usermod -aG www-data otrs
#
ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf
#
a2enmod perl
a2enmod deflate
a2enmod filter
a2enmod headers
cd /opt/otrs
bin/otrs.SetPermissions.pl





