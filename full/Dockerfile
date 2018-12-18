# Build container for GitPitch
FROM bigtruedata/sbt:0.13.15-alpine-2.11.11 as SBTBuild
RUN apk add --update --no-cache git unzip
RUN git clone https://github.com/gitpitch/gitpitch.git /gitpitch-git
RUN cd /gitpitch-git && \
    sbt dist && \
    unzip /gitpitch-git/target/universal/server-*.zip -d /tmp && \
    mv /tmp/server-* /gitpitch

# Runtime container
FROM openjdk:8u181-jre-slim-stretch

ENV GITPITCH_VERSION=2.0

ARG GOMPLATE_VERSION="v3.1.0"

# metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="GitPitch-PDF" \
      org.label-schema.description="GitPitch with PDF support" \
      org.label-schema.url="https://github.com/kns-it/Docker-GitPitch" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kns-it/Docker-GitPitch" \
      org.label-schema.vendor="KNS" \
      org.label-schema.version=$GITPITCH_VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="sebastian.kurfer@kns-it.de"

ADD https://github.com/hairyhenderson/gomplate/releases/download/$GOMPLATE_VERSION/gomplate_linux-amd64-slim /usr/bin/gomplate

COPY --from=SBTBuild /gitpitch /gitpitch

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y  zip \
                        fontconfig \
                        apt-transport-https \
			gconf2 \
                        --no-install-recommends && \
    apt-get install -y  nodejs \
                        yarn \
                        --no-install-recommends && \
    yarn global add decktape && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /src/*.deb && \
    chmod +x /usr/bin/gomplate && \
    adduser --home /home/gitpitch --disabled-password --gecos "" gitpitch && \
    mkdir /etc/gitpitch && \
    chown -R gitpitch /gitpitch && \
    chown -R gitpitch /etc/gitpitch && \
    chown -R gitpitch /usr/local/share/.config/yarn/

ADD ./bin/run-gitpitch.sh /gitpitch/bin/run-gitpitch.sh
ADD ./conf/application.conf.template /gitpitch/conf/application.conf.template

EXPOSE 9000

USER gitpitch

CMD ["/gitpitch/bin/run-gitpitch.sh"]
