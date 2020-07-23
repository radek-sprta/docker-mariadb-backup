#!/usr/bin/env bash
###
### Script to dump MariaDB databases
###
### Usage:
###   mariadb-backup.sh
###
### Required environment variables:
###   MARIADB_HOST
###   MARIADB_PASSWORD
###   MARIADB_PORT
###   MARIADB_USER
###
### Author: Radek Sprta <mail@radeksprta.eu>

set -o errexit  # Error if a command fails
set -o errtrace # Inherit error trap
set -o nounset  # Error if a variable is unset
set -o pipefail # Error if pipe fails
IFS=$'\n\t'     # Make iterations more predictible

BACKUP_LOCATION="${BACKUP_LOCATION:-/backup}"
MARIADB_CONNECTION=(-h "${MARIADB_HOST}" -P "${MARIADB_PORT}" -u "${MARIADB_USER}" -p"${MARIADB_PASSWORD}")

# Main control flow
function main() {
    trap script_error ERR
    has mysql
    has mysqldump
    has sed

    echo "MariaDB backup starting"
    [ -d "${BACKUP_LOCATION}" ] || error "Backup location does not exist"

    list_databases | while read -r database; do
        # Skip system databases
        if [[ "${database}" =~ (information|performance)_schema|mysql ]]; then
            continue
        fi

        backup_file=$BACKUP_LOCATION/$database.sql.gz
        echo "Backing up $database into $backup_file"
        mysqldump "${MARIADB_CONNECTION[@]}" "${database}" |
            gzip -c >"${backup_file}"
        chmod 600 "${backup_file}"
    done
}

# Print string to stderr in red.
# Args: $1 (required): String to print.
function error() {
    echo "$*" >&2
}

# Print list of databases
function list_databases() {
    mysql "${MARIADB_CONNECTION[@]}" -B -N -e "show databases"
}

# Check if given binary is available.
function has() {
    command -v "$1" >/dev/null 2>&1 || script_error "$1 binary not found"
}

# Cleanly handle unexpected errors.
# Args: $1 (optional): Error message.
function script_error() {
    # Disable error handling, so we can exit cleanly.
    trap - ERR
    set +o errexit
    set +o pipefail
    error "${1:-}"
    usage
    exit 1
}

# Print usage to stdout.
function usage() {
    sed -rn 's/^### ?//;T;p' "$0"
}

# Run the script
main "$@"

# vim: syntax=sh cc=80 tw=79 ts=4 sw=4 sts=4 et sr
