#!/bin/sh
set -e

# allow the container to be started with `--user`
if [ "$1" = 'nzbget' -a "$(id -u)" = '0' ]; then
	chown -R nzbget .
	exec su-exec nzbget "$@"
fi

exec "$@"
