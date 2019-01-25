#!/bin/bash

if [ $# -lt 1 ]; then
    connection_file=/tmp/connection-file.json
else
    connection_file=$1
fi

cat $connection_file

python3 -m ipykernel_launcher -f $connection_file