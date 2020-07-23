FROM alpine:latest
MAINTAINER Radek Sprta <mail@radeksprta.eu>

# Install cron
RUN apk add --update 'mariadb-client>10.4' bash && \
    rm -rf /var/cache/apk/* && \
    mkdir /backup
  
# Add scripts
COPY mariadb-backup.sh /mariadb-backup.sh
COPY entrypoint.sh /entrypoint.sh
 
ENTRYPOINT /entrypoint.sh
