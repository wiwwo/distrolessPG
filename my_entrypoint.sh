#!/bin/bash

#set -x

export PGDATA=/var/lib/postgresql/data
export PATH=$PATH:/usr/lib/postgresql/17/bin/
/usr/local/bin/docker-entrypoint.sh
/usr/local/bin/docker-ensure-initdb.sh
su  postgres << EOF
/usr/lib/postgresql/17/bin/postgres
EOF
