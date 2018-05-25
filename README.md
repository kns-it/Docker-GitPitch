# GitPitch Container

> This is an unofficial Docker container for GitPitch. GitPitch
itself now offers [GitPitch Enterprise](https://gitpitch.com/pricing), the official Docker container for GitPitch which runs the same enhanced server that runs on [gitpitch.com](https://gitpitch.com).

It's recommended to run the container with `docker-compose` because there are a few environment variables and it's easier to configure them all in one `docker-compose.yml` than passing them all in one `docker run` statement.

But if you want to, you could run the container like this:

```bash
docker run -d --rm --name gitpitch -e GP_GITHUB_AS_DEFAULT=true -p 9000:9000 knsit/gitpitch
```

This starts the container, enables the GitHub service and sets it as default.

To start the container and configure it for GitLab the call would look like this:

```bash
docker run -d --rm --name gitpitch -e GP_GITLAB_BASE=https://gitlab.com/ -e GP_GITLAB_API=https://gitlab.com/api/v4/ -e GP_GITLAB_AS_DEFAULT=true -p 9000:9000 knsit/gitpitch
```

This configuration enables the GitLab service and configures it for **public repositories only**.
If you want to access private repositories you'll need a private token.

All other providers are configured equivalently.
Have a look at the following section containing all available environment variables.

# Environment Variables

## Common

| Variable        | Explanation                                                      | Example                                                          |
| --------------- | ---------------------------------------------------------------- | ---------------------------------------------------------------- |
| `GP_HOST`       | Host binding                                                     | localhost:9000                                                   |
| `GP_APP_SECRET` | Play Framework crypto secret (random will be created if not set) | QCY?tAnfk?aZ?iwrNwnxIlR6CTf:G3gf:90Latabg@5241AB`R5W:1uDFN];Ik@n |

## GitHub

| Variable                 | Explanation              | Example                       |
| ------------------------ | ------------------------ | ----------------------------- |
| `GP_GITHUB_ACCESS_TOKEN` | Private token for GitHub | your-github-access-token-here |
| `GP_GITHUB_AS_DEFAULT`   | Set GitHub as default    | true ( default true )         |

## GitLab
| Variable                 | Explanation                     | Example                       |
| ------------------------ | ------------------------------- | ----------------------------- |
| `GP_GITLAB_BASE`         | Base URL of the GitLab instance | https://gitlab.com/           |
| `GP_GITLAB_API`          | URL to the current API version  | https://gitlab.com/api/v4/    |
| `GP_GITLAB_ACCESS_TOKEN` | Private token for GitLab        | your-gitlab-access-token-here |
| `GP_GITLAB_AS_DEFAULT`   | Set GitLab as default           | true ( default false )        |

## Bitbucket

| Variable                    | Explanation                        | Example                          |
| --------------------------- | ---------------------------------- | -------------------------------- |
| `GP_BITBUCKET_BASE`         | Base URL of the Bitbucket instance | https://bitbucket.org/           |
| `GP_BITBUCKET_API`          | URL to the current API version     | https://api.bitbucket.org/2.0/   |
| `GP_BITBUCKET_ACCESS_TOKEN` | Access token for Bitbucket         | your-bitbucket-access-token-here |
| `GP_BITBUCKET_AS_DEFAULT`   | Set Bitbucket as default           | true (default false)             |

## Gitea

| Variable                | Explanation                    | Example                         |
| ----------------------- | ------------------------------ | ------------------------------- |
| `GP_GITEA_BASE`         | Base URL of the Gitea instance | https://localhost:3000/         |
| `GP_GITEA_API`          | URL to the current API version | http://localhost:3000/api/v1/   |
| `GP_GITEA_ACCESS_TOKEN` | Private token for Gitea        | your-gitea-app-token-here |
| `GP_GITEA_AS_DEFAULT`   | Set Gitea as default           | true (default false)            |

## Gogs

| Variable               | Explanation                    | Example                         |
| ---------------------- | ------------------------------ | ------------------------------- |
| `GP_GOGS_BASE`         | Base URL of the Gogs instance  | https://localhost:3000/         |
| `GP_GOGS_API`          | URL to the current API version | http://localhost:3000/api/v1/   |
| `GP_GOGS_ACCESS_TOKEN` | Private token for Gogs         | your-gogs-app-token-here |
| `GP_GOGS_AS_DEFAULT`   | Set Gogs as default            | true (default false)            |

## GitBucket

| Variable                    | Explanation                        | Example                                |
| --------------------------- | ---------------------------------- | -------------------------------------- |
| `GP_GITBUCKET_BASE`         | Base URL of the GitBucket instance | http://localhost:8080/                 |
| `GP_GITBUCKET_API`          | URL to the current API version     | http://localhost:8080/api/v3/          |
| `GP_GITBUCKET_ACCESS_TOKEN` | Private token for GitBucket        | your-gitbucket-access-token-here |
| `GP_GITBUCKET_AS_DEFAULT`   | Set GitBucket as default           | true (default false)                   |

# Docker-Compose

As already mentioned it's much easier to run the configuration with `docker-compose`.
The equivalent to the `docker run` call above could look like this:

```yaml
version: '3'
services:
  gitpitch:
    image: knsit/gitpitch:latest
    environment:
      - "GP_GITLAB_BASE=https://gitlab.com/"
      - "GP_GITLAB_API=https://gitlab.com/api/v4/"
      - "GP_GITLAB_AS_DEFAULT=true"
    ports:
      - 9000:9000
```
