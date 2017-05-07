FROM java:openjdk-8-jre

COPY gitpitch /gitpitch
COPY decktape /decktape
COPY run-gitpitch.sh /gitpitch/bin/run-gitpitch.sh

VOLUME /etc/gitpitch

EXPOSE 9000

ENTRYPOINT ["/gitpitch/bin/run-gitpitch.sh"]