#!/bin/bash

CONNECTION_FILE=$1

# Get port numbers from the connection_file
CONTROL_PORT=$(cat $CONNECTION_FILE | jq '.control_port')
SHELL_PORT=$(cat $CONNECTION_FILE | jq '.shell_port')
STDIN_PORT=$(cat $CONNECTION_FILE | jq '.stdin_port')
HB_PORT=$(cat $CONNECTION_FILE | jq '.hb_port')
IOPUB_PORT=$(cat $CONNECTION_FILE | jq '.iopub_port')

echo "--hb=$HB_PORT --shell=$SHELL_PORT --iopub=$IOPUB_PORT --stdin=$STDIN_PORT --control=$CONTROL_PORT"

python3 -m ipykernel_launcher --ip=0.0.0.0 --hb=$HB_PORT --shell=$SHELL_PORT --iopub=$IOPUB_PORT --stdin=$STDIN_PORT --control=$CONTROL_PORT -f $CONNECTION_FILE