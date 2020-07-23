# docker-mariadb-backup

Docker container to dump MariaDB databases

## Installation
`docker pull registry.gitlab.com/radek-sprta/docker-mariadb-backup`

## Usage
You can run it with compose setup similar to this:

```yaml
version: '2'
services:
  backup:
    container_name: mariadb-backup
    image: registry.gitlab.com/radek-sprta/docker-mariadb-backup
    environment:
      - CRON_TIMER=@daily
      - MARIADB_USER=root
      - MARIADB_HOST=<host>
      - MARIADB_PORT=3306
      - MARIADB_PASSWORD=<password>
    volumes:
      - "/var/lib/backup:/backup"
    networks:
      - database
    restart: unless-stopped
networks:
  database:
    external:
      name: <network>
```

## Contributing
For information on how to contribute to the project, please check the [Contributor's Guide][contributing].

## Contact
[mail@radeksprta.eu](mailto:mail@radeksprta.eu)[incoming+radek-sprta/docker-mariadb-backup@gitlab.com](incoming+radek-sprta/docker-mariadb-backup@gitlab.com)## License
GNU General Public License v3

## Credits
This package was created with [Cookiecutter][cookiecutter].

[contributing]: https://gitlab.com/radek-sprta/docker-mariadb-backup/blob/master/CONTRIBUTING.md
[cookiecutter]: https://github.com/audreyr/cookiecutter
