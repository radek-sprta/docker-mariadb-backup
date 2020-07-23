#!/usr/bin/env bash

# Start the run once job.
echo "Docker container has been started"

# Save environment variables for cron
declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' >/container.env

# Setup a cron schedule
echo "SHELL=/bin/bash
BASH_ENV=/container.env
${CRON_TIMER:-@daily} /mariadb-backup.sh
# This line is needed" | crontab -

crond -f
