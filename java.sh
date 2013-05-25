#!/bin/bash
rsync -auzv root@172.16.3.23:/srv/* /srv/
ln -s /srv/java /usr/local/java
ln -s /srv/apache-tomcat /usr/local/
mkdir -p /www/logs/tomcat
echo -ne '
export JAVA_HOME=/srv/java
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:
export JAVA_OPTS="-server -Xms512m -Xmx8192m  -XX:PermSize=64M -XX:MaxPermSize=512m"
' >> /etc/profile
