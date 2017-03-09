#!/bin/bash

sed -e 's/API_IP/'"$API_IP"'/g' /tmp/properties.js.template > /tmp/properties.js.template2
sed -e 's/API_PORT/'"$API_PORT"'/g' /tmp/properties.js.template2 > /usr/share/nginx/html/properties.js
/etc/init.d/nginx start
tail -f /var/log/nginx/access.log 