#
FROM debian:9-slim
MAINTAINER „Wojciech Repinski” <tech@actuna.com>

# OTRS_INSTALL=yes ; tylko instaluje gołego OTRS
# OTRS_INSTALL=no ; nadpisuje katalog i używa bazy mysql
ENV OTRS_INSTALL=yes
ENV OTRS_VERSION=6.0.15
ENV DB_ROOT_PASSWORD=DGdre.ds#$34
ENV TIMEZONE=UTC


RUN apt-get update && \
    apt-get install -y supervisor lsb-release gnupg coreutils wget\
    apt-utils \
    libterm-readline-perl-perl && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
	echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-5.7\ndeb-src http://repo.mysql.com/apt/debian/ stretch mysql-5.7" > /etc/apt/sources.list.d/mysql.list && \
	wget -O /tmp/RPM-GPG-KEY-mysql https://repo.mysql.com/RPM-GPG-KEY-mysql && \
	apt-key add /tmp/RPM-GPG-KEY-mysql && \
	apt-get update && \
	apt-get install -y mysql-server && \
	apt-get install -y libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl libnet-ldap-perl \
    libio-socket-ssl-perl libpdf-api2-perl libdbd-mysql-perl libsoap-lite-perl libtext-csv-xs-perl \
    libjson-xs-perl libapache-dbi-perl libxml-libxml-perl libxml-libxslt-perl libyaml-perl \
    libarchive-zip-perl libcrypt-eksblowfish-perl libencode-hanextra-perl libmail-imapclient-perl \
    libtemplate-perl cron ssmtp apache2 rsyslog curl unzip gzip tar bzip2 libcrypt-ssleay-perl libdatetime-perl \
	libauthen-ntlm-perl 

#
#
#

#RUN mkdir -p /var/run/mysqld && \ 
#	chmod 777 /var/run/mysqld && \
#	chmod +t /var/run/mysqld

COPY etc /etc/


VOLUME /var/lib/mysql

COPY mysql.sh /
COPY run.sh /
RUN chmod 755 /mysql.sh && \
	chmod 755 /run.sh
#	/mysql.sh



#
# OTRS

COPY otrs_install.sh /
RUN chmod 755 /otrs_install.sh && \
		/otrs_install.sh
VOLUME /opt/otrs
COPY otrs.sh /
RUN chmod 755 /otrs.sh && \
	/otrs.sh

RUN mkdir -p /opt/otrs-backup &&\ chown otrs:www-data /opt/otrs-backup
VOLUME /opt/otrs-backup

EXPOSE 80
CMD /run.sh

