#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Missing the connection file as first parameter"
    exit 1
fi

# Script settings
DOCKER_IMAGE=python-kernel

# This thing should be a full path by Jupyter
connection_file=$1

# Get the port number out
# Here we assume the local machine has JQ installed
CONTROL_PORT=$(jq '.control_port' < $connection_file)
SHELL_PORT=$(jq '.shell_port' < $connection_file)
STDIN_PORT=$(jq '.stdin_port' < $connection_file)
HB_PORT=$(jq '.hb_port' < $connection_file)
IOPUB_PORT=$(jq '.iopub_port' < $connection_file)

echo control ${CONTROL_PORT}
echo shell ${SHELL_PORT}
echo stdin ${STDIN_PORT}
echo hb ${HB_PORT}
echo iopub ${IOPUB_PORT}

sed -i.bu 's;127.0.0.1;0.0.0.0;' "${connection_file}"

# Run docker image with the connection file mounted in, and ports forwarded
docker run -d --rm -t \
    -v $connection_file:/tmp/connection-file.json \
    -p $CONTROL_PORT:$CONTROL_PORT \
    -p $SHELL_PORT:$SHELL_PORT \
    -p $STDIN_PORT:$STDIN_PORT \
    -p $HB_PORT:$HB_PORT \
    -p $IOPUB_PORT:$IOPUB_PORT \
    $DOCKER_IMAGE
