# mariadb-backup

## Quick reference
-	**Maintained by**: [Radek Sprta](https://gitlab.com/radek-sprta)
-	**Where to get help**: [Repository Issues](https://gitlab.com/radek-sprta/docker-mariadb-backup/-/issues)

## Description
The container is designed to make a backup of MariaDB databases using mysqldump.

## Usage
Example `docker-compose.yml`, that assumes you MariaDB container is called mariadb and runs in a network
of the same name:

```yaml
version: '2'
services:
  backup:
    container_name: mariadb-backup
    image: registry.gitlab.com/radek-sprta/docker-mariadb-backup
    environment:
      - CRON_TIMER=@daily
      - MARIADB_HOST=mariadb
      - MARIADB_PASSWORD=secret
      - MARIADB_PORT=3306
      - MARIADB_USER=root
    volumes:
      - "/var/lib/backup:/backup"
    networks:
      - database
    restart: unless-stopped
networks:
  database:
    external:
      name: mariadb
```

## Environment variables
For the container to work, you need to declare several environment variables.

### CRON_TIMER
How often should the dumps be made. Uses cron time definition (such as '0 5 * * 0'). Defaults to @daily.

### MARIADB_HOST
Host to connect to.

### MARIADB_PASSWORD
Password of the backup user.

### MARIADB_PORT
Port to connect to.

### MARIADB_USER
User to perform the backup. Needs to have the necessary permissions. 

## Contributing
For information on how to contribute to the project, please check the [Contributor's Guide][contributing].

## Contact
[mail@radeksprta.eu](mailto:mail@radeksprta.eu)  
[incoming+radek-sprta/docker-mariadb-backup@gitlab.com](incoming+radek-sprta/docker-mariadb-backup@gitlab.com)

## License
GNU General Public License v3

## Credits
This package was created with [Cookiecutter][cookiecutter].

[contributing]: https://gitlab.com/radek-sprta/docker-mariadb-backup/blob/master/CONTRIBUTING.md
[cookiecutter]: https://github.com/audreyr/cookiecutter
