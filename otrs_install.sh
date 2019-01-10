#!/bin/bash
#
mkdir -p /opt/otrs

if [ "$OTRS_INSTALL" == "yes"  ]; then

curl -o /opt/otrs-$OTRS_VERSION.zip http://ftp.otrs.org/pub/otrs/otrs-$OTRS_VERSION.zip

cd /opt

unzip otrs-$OTRS_VERSION.zip

rm otrs-$OTRS_VERSION.zip 

mv otrs-$OTRS_VERSION/* otrs/

cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm

fi



