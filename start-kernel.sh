#!/bin/bash

CONNECTION_FILE=$1

# Get port numbers from the connection_file
CONTROL_PORT=$(cat $CONNECTION_FILE | jq '.control_port')
SHELL_PORT=$(cat $CONNECTION_FILE | jq '.shell_port')
STDIN_PORT=$(cat $CONNECTION_FILE | jq '.stdin_port')
HB_PORT=$(cat $CONNECTION_FILE | jq '.hb_port')
IOPUB_PORT=$(cat $CONNECTION_FILE | jq '.iopub_port')

echo "Got ports"
echo "--hb=$HB_PORT --shell=$SHELL_PORT --iopub=$IOPUB_PORT --stdin=$STDIN_PORT --control=$CONTROL_PORT"

# Run docker image with the connection file mounted in, and ports forwarded
docker run -d -v $(dirname $CONNECTION_FILE):/tmp \
    -p $CONTROL_PORT:$CONTROL_PORT \
    -p $SHELL_PORT:$SHELL_PORT \
    -p $STDIN_PORT:$STDIN_PORT \
    -p $HB_PORT:$HB_PORT \
    -p $IOPUB_PORT:$IOPUB_PORT \
    -t python-kernel:latest \
    /tmp/$(basename $CONNECTION_FILE)