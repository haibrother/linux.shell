#!/bin/bash

PREFIX_DIR=/srv
HTTPD_DIR=$HTTPD_DIR/httpd-2.4.4

yum install -y apr apr-util 
yum -y install pcre-devel 

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/httpd/httpd-2.4.4.tar.gz
tar zxf httpd-2.4.4.tar.gz 
cd httpd-2.4.4

./configure --prefix=$HTTPD_DIR \
--with-mpm=event \
--enable-modules="so dir mime rewrite deflate expires vhost_alias include" \
--enable-mods-shared="alias filter headers setenvif status info ssl usertrack cache mem-cache file-cache disk-cache version mod_unique_id proxy proxy-connect proxy-http proxy-fcgi proxy-scgi proxy-balancer proxy-express" \
--disable-authn_file \
--disable-authn_default \
--disable-authz_groupfile \
--disable-authz_user \
--disable-authz_default \
--disable-auth_basic \
--disable-version \
--disable-env \
--disable-autoindex \
--disable-asis \
--disable-cgid \
--disable-cgi \
--disable-negotiation \
--disable-actions \
--disable-userdir \
--enable-so \
--enable-file-cache \
--enable-cache \
--enable-disk-cache \
--enable-mem-cache \
--enable-expires \
--enable-headers \
--enable-ssl \
--enable-info \
--enable-rewrite \
--enable-ratelimit \
--enable-proxy \
--enable-proxy-connect  \
--enable-proxy-http \
--enable-proxy-fcgi \
--enable-proxy-scgi \
--enable-proxy-balancer \
--enable-proxy-express

#--enable-proxy-ftp \
#--enable-proxy-fdpass \
#--enable-proxy-ajp \

#--enable-session \
#--enable-session-cookie \
#--enable-session-crypto \
#--enable-session-dbd 

make && make install

