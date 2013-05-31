#!/bin/bash

cd /usr/local/src/

tar zxvf server-jre-7u21-linux-x64.gz 
mv jdk1.7.0_21 /srv/
ln -s /srv/jdk1.7.0_21 /srv/java