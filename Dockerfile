#
FROM debian:9-slim
MAINTAINER „Wojciech Repinski” <tech@actuna.com>

# OTRS_INSTALL=yes ; tylko instaluje gołego OTRS
# OTRS_INSTALL=no ; nadpisuje katalog i używa bazy mysql
ENV OTRS_INSTALL=no
ENV OTRS_VERSION=6.0.15

RUN apt-get update && \
    apt-get install -y supervisor \
    apt-utils \
    libterm-readline-perl-perl && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
	apt-get install -y libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl libnet-ldap-perl \
    libio-socket-ssl-perl libpdf-api2-perl libdbd-mysql-perl libsoap-lite-perl libtext-csv-xs-perl \
    libjson-xs-perl libapache-dbi-perl libxml-libxml-perl libxml-libxslt-perl libyaml-perl \
    libarchive-zip-perl libcrypt-eksblowfish-perl libencode-hanextra-perl libmail-imapclient-perl \
    libtemplate-perl mariadb-server cron ssmtp apache2 rsyslog curl unzip gzip tar bzip2

RUN mkdir -p /var/run/mysqld && \ 
	chmod 777 /var/run/mysqld && \
	chmod +t /var/run/mysqld

COPY etc /etc/

#
# MaraDB

VOLUME /var/lib/mysql
COPY mysql.sh /
RUN chmod 755 /mysql.sh && \ 
	/mysql.sh


#
# OTRS

COPY otrs_install.sh /
RUN chmod 755 /otrs_install.sh && \
	/otrs_install.sh

COPY otrs.sh /
RUN chmod 755 /otrs.sh && \
	/otrs.sh



EXPOSE 80
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

