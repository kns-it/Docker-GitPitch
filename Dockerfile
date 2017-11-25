FROM 1science/sbt:0.13.8-oracle-jre-8 as SBTBuild
RUN apk add --update git && \
    git clone https://github.com/gitpitch/gitpitch.git /gitpitch && \
    cd /gitpitch && \
    sbt dist

FROM alpine:3.6
COPY --from=SBTBuild /gitpitch/target/universal/server-*.zip /tmp
RUN apk add --update openjdk8-jre yarn nodejs-current unzip bash && \
    rm -rf /var/cache/apk/* && \
    yarn global add decktape && \
    unzip /tmp/server-*.zip -d /gitpitch && \
    rm -rf /tmp/* && \
    mv /gitpitch/server-*/* /gitpitch/

ADD run-gitpitch.sh /gitpitch/bin/run-gitpitch.sh

VOLUME /etc/gitpitch

EXPOSE 9000

CMD ["/gitpitch/bin/run-gitpitch.sh"]