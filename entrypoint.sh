#!/bin/bash
set -e

[ "" != "$BASIC_AUTH_USERNAME" ] && [ "" != "$BASIC_AUTH_PASSWORD" ] \
  && htpasswd -c -b /etc/nginx/.htpasswd $BASIC_AUTH_USERNAME $BASIC_AUTH_PASSWORD

[ "" != "$HTPASSWD_FILE_URL" ] \
  && wget -O /etc/nginx/.htpasswd $HTPASSWD_FILE_URL

[ ! -s /etc/nginx/.htpasswd ] && echo 'No credentials provided' && exit 1

envsubst </etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"

