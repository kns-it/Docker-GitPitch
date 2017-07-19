# Build

Build erfordert mindestens Docker Version 17.06.

Anschließend kann Image mit `docker build [image:tag] .` gebuildet werden.

# GitPitch Container

Starten des Containers:

```bash
docker login inf-docker.fh-rosenheim.de

docker run -d -p 9000:9000 -v /etc/gitpitch:/etc/gitpitch/ inf-docker.fh-rosenheim.de/sinfpekurf/gitpitch
```

wobei mit `-p 9000:9000` der Port angegeben wird, auf den der Container gemappt werden soll und mit `-v /etc/gitpitch:/etc/gitpitch/` das Volume gemountet wird, wo sich die **gitpitch.conf** Datei befindet, die zum Starten des Containers notwendig ist, da in ihr die Git-Provider etc. konfiguriert werden.

# Konfiguration

Eine Beispiel-Datei für die **gitpitch.conf** ist im [Repository](application.conf) enthalten.

Genaue Anweisungen zur Konfiguration von GitPitch können dem öffentlichen [Wiki](https://github.com/gitpitch/gitpitch/wiki/Server-Deploy-Instructions) entnommen werden.

## Offline-Assets

Damit die Offline-Assets korrekt funktionieren sollte in der **gitpitch.conf** der Abschnitt zu **offline** wie folgt aussehen:

```json
offline {

    prod {
        fixed {
            assets {
                home = "/gitpitch/lib/com.gitpitch.server-1.1-assets.jar"
            }
        }
    }

  }
```

ansonsten können die .js- und .css-Dateien nicht gefunden werden und die Offline-Version der Präsentation sieht sehr unspektakulär aus.