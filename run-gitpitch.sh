#!/bin/bash

if [ -f /gitpitch/RUNNING_PID ]; then
	rm -f /gitpitch/RUNNING_PID
fi

if [ ! -d /etc/gitpitch ]; then
	mkdir /etc/gitpitch;
fi

if [ ! -f /etc/gitpitch/gitpitch.conf ]; then
	cp /gitpitch/conf/application.conf /etc/gitpitch;
fi

/gitpitch/bin/server -Dconfig.file=/etc/gitpitch/gitpitch.conf