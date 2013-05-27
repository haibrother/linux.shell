#!/bin/bash

#!/bin/bash
TITLE="PostgreSQL"

PKG=$(whiptail --title "$TITLE" --menu "Options:" 10 50 2 \
"1" "PostgreSQL server programs" \
"2" "PostgreSQL client programs" \
3>&1 1>&2 2>&3)

case "$PKG" in
	1)
		yum install postgresql-server
		;;
	2)
		yum install postgresql
		;;
	*)
		
		RETVAL=1
esac

#exit $RETVAL