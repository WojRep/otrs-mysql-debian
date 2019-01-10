#!/bin/bash
#
mkdir -p /opt/otrs

curl -o /opt/otrs-$OTRS_VERSION.zip http://ftp.otrs.org/pub/otrs/otrs-$OTRS_VERSION.zip

cd /opt

unzip otrs-$OTRS_VERSION.zip

rm otrs-$OTRS_VERSION.zip 



