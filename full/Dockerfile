# Build container for GitPitch
FROM bigtruedata/sbt:0.13.15-alpine-2.11.11 as SBTBuild
RUN apk add --update --no-cache git unzip && \
    git clone https://github.com/gitpitch/gitpitch.git /gitpitch-git && \
    cd /gitpitch-git && \
    sbt dist && \
    unzip /gitpitch-git/target/universal/server-*.zip -d /tmp && \
    mv /tmp/server-* /gitpitch

# Build container for gomplate
FROM golang:1.9.1-alpine3.6 as GoBuild

ENV GOMPLATE_VERSION="v2.2.0"

RUN sed -i -e 's/v3\.6/edge/g' /etc/apk/repositories && \
    apk --update add git \
                     make \
                     upx && \
    mkdir -p /go/src/github.com/hairyhenderson && \
    cd /go/src/github.com/hairyhenderson && \
    git clone --branch "$GOMPLATE_VERSION" https://github.com/hairyhenderson/gomplate.git && \
    cd gomplate/ && \
    make build-release

# Runtime container
FROM java:openjdk-8-jre

ENV GITPITCH_VERSION=2.0

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

# copy from build containers
COPY --from=GoBuild /go/src/github.com/hairyhenderson/gomplate/bin/gomplate_linux-amd64-slim /usr/bin/gomplate
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
                        google-chrome-unstable \
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