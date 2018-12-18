#!/bin/bash
set -e

[ "" == "$PORT" ] && echo 'No $PORT specified' && exit 1
[ "" == "$UPSTREAM_URL" ] && echo 'No $UPSTREAM_URL specified' && exit 1

[ "" != "$BASIC_AUTH_USERNAME" ] && [ "" != "$BASIC_AUTH_PASSWORD" ] \
  && htpasswd -c -b /etc/nginx/.htpasswd $BASIC_AUTH_USERNAME $BASIC_AUTH_PASSWORD

[ "" != "$HTPASSWD_FILE_URL" ] \
  && wget -O /etc/nginx/.htpasswd $HTPASSWD_FILE_URL

envsubst '$UPSTREAM_URL $PORT $EXTRA' </etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"

