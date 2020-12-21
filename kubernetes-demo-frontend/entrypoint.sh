#!/usr/bin/env bash
sh gzipAssets.sh

sh logger.sh "Kubernetes Demo Frontend ngnix server is starting"
exec nginx -g "daemon off;";
