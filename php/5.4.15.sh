#!/bin/bash

cd /usr/local/src/
wget http://hk1.php.net/get/php-5.4.15.tar.gz/from/hk2.php.net/mirror


ln -s /usr/pgsql-9.2/lib/* /usr/lib/
ln -s /usr/pgsql-9.2/include/* /usr/include/

tar zxvf php-5.4.15.tar.gz
cd php-5.4.15

./configure --prefix=/srv/php-5.4.15 \
--with-config-file-path=/srv/php-5.4.15/etc \
--with-config-file-scan-dir=/srv/php-5.4.15/etc/conf.d \
--enable-fpm \
--with-fpm-user=www \
--with-fpm-group=www \
--with-pear \
--with-curl \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir \
--with-zlib-dir \
--with-iconv \
--with-mcrypt \
--with-mhash \
--with-pdo-pgsql=/usr/pgsql-9.2 \
--with-pgsql=/usr/pgsql-9.2 \
--with-mysql \
--with-mysqli=/usr/bin/mysql_config \
--with-pdo-mysql \
--with-mysql-sock=/var/lib/mysql/mysql.sock \
--with-openssl \
--with-mhash \
--with-xsl \
--with-recode \
--enable-sockets \
--enable-soap \
--enable-mbstring \
--enable-gd-native-ttf \
--enable-zip \
--enable-xml \
--enable-bcmath \
--enable-calendar \
--enable-shmop \
--enable-dba \
--enable-wddx \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-pcntl \
--with-tsrm-pthreads \
--disable-debug

make && make install
		
mkdir -p /srv/php-5.4.15/etc/conf.d
cp php.ini-* /srv/php-5.4.15/etc/
#cp /srv/php-5.4.15/etc/php.ini-development /srv/php-5.4.15/etc/php.ini
cp /srv/php-5.4.15/etc/php.ini-production /srv/php-5.4.15/etc/php.ini
cp /srv/php-5.4.15/etc/php-fpm.conf.default /srv/php-5.4.15/etc/php-fpm.conf
cp /srv/php-5.4.15/etc/pear.conf{,.original}
cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

ln -s /srv/php-5.4.15/ /srv/php		

vim /srv/php-5.4.15/etc/php-fpm.conf <<end > /dev/null 2>&1
:25,25s/;//
:32,32s/;//
:wq
end

vim /srv/php-5.4.15/etc/php.ini <<EOF > /dev/null 2>&1
:%s!;include_path = ".:/php/includes"!include_path = ".:/srv/php-5.4.15/lib/php:/srv/php-5.4.15/share"!
:%s:extension_dir = "./":extension_dir = "/srv/php-5.4.15/lib/php/extensions":
:%s/memory_limit = 128M/memory_limit = 16M/
:%s$;open_basedir = $open_basedir = /www/:/tmp/:/srv/php-5.4.15/lib/php/:/srv/php-5.4.15/bin/$
:%s/upload_max_filesize = 2M/upload_max_filesize = 8M/
:%s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/
:%s$;date.timezone =$date.timezone = Asia/Hong_Kong$
:%s:;session.save_path = "/tmp":session.save_path = "/dev/shm":
:wq
EOF

/srv/php-5.4.15/bin/pecl install apc
ln -s /srv/php-5.4.15/lib/php/extensions/no-debug-non-zts-20100525/apc.so /srv/php-5.4.15/lib/php/extensions/
cat > /srv/php-5.4.15/etc/conf.d/apc.ini <<EOF
extension=apc.so
EOF

php -r 'phpinfo();' |grep apc
