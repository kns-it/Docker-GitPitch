# Build container for GitPitch
FROM 1science/sbt:0.13.8-oracle-jre-8 as SBTBuild
RUN apk add --update git && \
    git clone https://github.com/gitpitch/gitpitch.git /gitpitch && \
    cd /gitpitch && \
    sbt dist

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
FROM alpine:3.6

ENV GITPITCH_VERSION=2.0

# metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="GitPitch" \
      org.label-schema.description="GitPitch including Decktape in an Alpine container" \
      org.label-schema.url="https://github.com/kns-it/Docker-GitPitch" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kns-it/Docker-GitPitch" \
      org.label-schema.vendor="KNS" \
      org.label-schema.version=$GITPITCH_VERSION \
      org.label-schema.schema-version="1.0" \
      maintainer="sebastian.kurfer@kns-it.de"

# copy from build containers
COPY --from=GoBuild /go/src/github.com/hairyhenderson/gomplate/bin/gomplate_linux-amd64-slim /usr/bin/gomplate
COPY --from=SBTBuild /gitpitch/target/universal/server-*.zip /tmp

# setup runtime environment
RUN apk add --update --no-cache openjdk8-jre \
                                yarn \
                                nodejs-current \
                                zip \
                                unzip \
                                bash \
                                fontconfig \
                                curl && \
    yarn global add decktape && \
    unzip /tmp/server-*.zip -d /gitpitch && \
    rm -rf /tmp/* && \
    mv /gitpitch/server-*/* /gitpitch/ && \
    chmod +x /usr/bin/gomplate && \
    cd /usr/share && \
    curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj && \
    ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs && \
    mkdir -p /usr/local/share/.config/yarn/global/node_modules/decktape/bin && \
    ln -s /usr/share/phantomjs/phantomjs /usr/local/share/.config/yarn/global/node_modules/decktape/bin/phantomjs && \
    apk del --purge yarn unzip curl

ADD ./bin/run-gitpitch.sh /gitpitch/bin/run-gitpitch.sh
ADD ./conf/application.conf.template /gitpitch/conf/application.conf.template

EXPOSE 9000

CMD ["/gitpitch/bin/run-gitpitch.sh"]