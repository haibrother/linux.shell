#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/tomcat/tomcat-7/v7.0.40/bin/apache-tomcat-7.0.40.tar.gz
tar zxvf apache-tomcat-7.0.40.tar.gz 
mv apache-tomcat-7.0.40 /srv/
ln -s /srv/apache-tomcat-7.0.40 /srv/apache-tomcat

rm -rf /srv/apache-tomcat/webapps/*