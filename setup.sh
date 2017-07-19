#!/bin/bash
mkdir -p /decktape/bin
curl -L https://github.com/astefanutti/decktape/archive/v1.0.0.tar.gz | tar -xz --exclude phantomjs -C /decktape
mv /decktape/decktape-1.0.0/* /decktape
curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64 -o /decktape/bin/phantomjs
chmod +x /decktape/bin/phantomjs
apt update
apt install zip
unzip /tmp/server-*.zip -d /gitpitch
rm -f /tmp/server-*.zip
mv /gitpitch/server-*/* /gitpitch/