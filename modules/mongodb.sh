#!/bin/bash
if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

yum install mongodb-server mongodb -y
chkconfig mongod on
service mongod start

#yum install mongodb

