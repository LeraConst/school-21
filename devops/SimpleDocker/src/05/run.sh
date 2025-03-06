#!/bin/bash

gcc mini-server.c -lfcgi -o mini-server
service nginx start
nginx -s reload
spawn-fcgi -p 8080 -n mini-server
