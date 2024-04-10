#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export GDB_JAVA_OPTS="-Dgraphdb.home=/opt/graphdb/home/ -Dgraphdb.home.conf=/opt/graphdb/dist/conf/"
if [ ! -d /opt/graphdb/home/data/repositories/fdp ]; then
    /opt/graphdb/dist/bin/importrdf preload -c $SCRIPT_DIR/fdp.ttl /dev/null
fi
if [ ! -d /opt/graphdb/home/data/repositories/caresm ]; then
    /opt/graphdb/dist/bin/importrdf preload -c $SCRIPT_DIR/caresm.ttl /dev/null
fi
if [ ! -f /opt/graphdb/home/data/settings.js ]; then
    echo '{"properties" : { "security.enabled" : "true" }}' > /opt/graphdb/home/data/settings.js
fi
if [ ! -f /opt/graphdb/home/data/users.js ]; then
    cp $SCRIPT_DIR/users.js /opt/graphdb/home/data/users.js
fi