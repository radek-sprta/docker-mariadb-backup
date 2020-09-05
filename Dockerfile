FROM alpine:latest
MAINTAINER Radek Sprta <mail@radeksprta.eu>

LABEL org.opencontainers.image.authors "Radek Sprta <mail@radeksprta.eu>"
LABEL org.opencontainers.image.description "Docker container to perform MariaDB backups"
LABEL org.opencontainers.image.documentation "https://radek-sprta.gitlab.io/docker-mariadb-backup/"
LABEL org.opencontainers.image.licenses "GPL-3.0"
LABEL org.opencontainers.image.source "https://gitlab.com/radek-sprta/docker-mariadb-backup"
LABEL org.opencontainers.image.title "rsprta/mariadb-backup"
LABEL org.opencontainers.image.url "https://gitlab.com/radek-sprta/docker-mariadb-backup"

# Install cron
RUN apk add --update 'mariadb-client>10.4' bash && \
    rm -rf /var/cache/apk/* && \
    mkdir /backup
  
# Add scripts
COPY mariadb-backup.sh /mariadb-backup.sh
COPY entrypoint.sh /entrypoint.sh
 
ENTRYPOINT /entrypoint.sh
