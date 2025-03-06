#!/bin/bash

gcc -o mini-server mini-server.c -lfcgi
spawn-fcgi -p 8080 ./mini-server
service nginx start
/bin/bash
