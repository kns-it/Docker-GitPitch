FROM 1science/sbt:0.13.8-oracle-jre-8 as SBTBuild
RUN apk update && apk add git
COPY build_gitpitch.sh /
RUN /build_gitpitch.sh

FROM java:openjdk-8-jre
COPY --from=SBTBuild /gitpitch/target/universal/server-*.zip /tmp
COPY setup.sh /setup.sh
RUN /setup.sh && rm -f /setup.sh

COPY run-gitpitch.sh /gitpitch/bin/run-gitpitch.sh

VOLUME /etc/gitpitch

EXPOSE 9000

ENTRYPOINT ["/gitpitch/bin/run-gitpitch.sh"]