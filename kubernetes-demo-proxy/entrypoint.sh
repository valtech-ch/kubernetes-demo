#!/usr/bin/env bash
envsubst '${BASE_FQDN}' < /etc/nginx/conf.d/default.conf.tmpl > /etc/nginx/conf.d/default.conf
sh logger.sh "ngnix proxy server is starting"
exec nginx -g "daemon off;";
