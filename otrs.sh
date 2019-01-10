#!/bin/bash
#


useradd -b /opt/otrs otrs
usermod -aG www-data otrs
/opt/otrs
bin/otrs.SetPermissions.pl



