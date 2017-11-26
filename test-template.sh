#!/bin/bash

if [ ! -f gomplate ]; then
    curl https://github.com/hairyhenderson/gomplate/releases/download/v2.2.0/gomplate_linux-amd64-slim -o gomplate
    chmod +x gomplate
fi

export GP_APP_SECRET=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w54 | head -n1)
export GP_HOST=localhost

export GP_GITHUB_ACCESS_TOKEN=asdfasdf234234
export GP_GITHUB_AS_DEFAULT=false

cat conf/application.conf.template | ./gomplate -o app-github.conf

unset GP_GITHUB_ACCESS_TOKEN
unset GP_GITHUB_AS_DEFAULT

export GP_GITLAB_BASE=https://gitlab.com/  
export GP_GITLAB_API=https://gitlab.com/api/v4/ 
export GP_GITLAB_ACCESS_TOKEN=your-gitlab-access-token-here
export GP_GITLAB_AS_DEFAULT=true

cat conf/application.conf.template | ./gomplate -o app-gitlab.conf

unset GP_GITLAB_BASE
unset GP_GITLAB_API
unset GP_GITLAB_ACCESS_TOKEN
unset GP_GITLAB_AS_DEFAULT

export GP_BITBUCKET_BASE=https://bitbucket.org/ 
export GP_BITBUCKET_API=https://api.bitbucket.org/2.0/ 
export GP_BITBUCKET_ACCESS_TOKEN=your-bitbucket-access-token-here
export GP_BITBUCKET_AS_DEFAULT=true

cat conf/application.conf.template | ./gomplate -o app-bitbucket.conf

unset GP_BITBUCKET_BASE
unset GP_BITBUCKET_API
unset GP_BITBUCKET_ACCESS_TOKEN
unset GP_BITBUCKET_AS_DEFAULT

export GP_GITEA_BASE=https://localhost:3000/  
export GP_GITEA_API=http://localhost:3000/api/v1/
export GP_GITEA_ACCESS_TOKEN=your-gitea-app-token-here
export GP_GITEA_AS_DEFAULT=true

cat conf/application.conf.template | ./gomplate -o app-gitea.conf

unset GP_GITEA_BASE
unset GP_GITEA_API
unset GP_GITEA_ACCESS_TOKEN
unset GP_GITEA_AS_DEFAULT

export GP_GOGS_BASE=https://localhost:3000/
export GP_GOGS_API=http://localhost:3000/api/v1/
export GP_GOGS_ACCESS_TOKEN=your-gitea-app-token-here
export GP_GOGS_AS_DEFAULT=true

cat conf/application.conf.template | ./gomplate -o app-gogs.conf

unset GP_GOGS_BASE
unset GP_GOGS_API
unset GP_GOGS_ACCESS_TOKEN
unset GP_GOGS_AS_DEFAULT

export GP_GITBUCKET_BASE=https://localhost:3000/
export GP_GITBUCKET_API=http://localhost:3000/api/v1/
export GP_GITBUCKET_ACCESS_TOKEN=your-gitea-app-token-here
export GP_GITBUCKET_AS_DEFAULT=true

cat conf/application.conf.template | ./gomplate -o app-gitbucket.conf

unset GP_GITBUCKET_BASE
unset GP_GITBUCKET_API
unset GP_GITBUCKET_ACCESS_TOKEN
unset GP_GITBUCKET_AS_DEFAULT