#!/bin/sh

if [ -z "$GP_APP_SECRET" ]; then
	export GP_APP_SECRET=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w54 | head -n1)
fi

if [ -f /gitpitch/RUNNING_PID ]; then
	rm -f /gitpitch/RUNNING_PID
fi

if [ ! -f /etc/gitpitch/gitpitch.conf ]; then
	cat /gitpitch/conf/application.conf.template | gomplate -o /gitpitch/conf/gitpitch.conf
	chmod 440 /gitpitch/conf/gitpitch.conf
fi

/gitpitch/bin/server -Dconfig.file=/gitpitch/conf/gitpitch.conf