#!/bin/bash

if [ $# -lt 1 ]; then
    connection_file=/tmp/connection-file.json
else
    connection_file=$1
fi


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

python3 -m ipykernel_launcher --ip=0.0.0.0 --hb=$HB_PORT --shell=$SHELL_PORT --iopub=$IOPUB_PORT --stdin=$STDIN_PORT --control=$CONTROL_PORT -f $CONNECTION_FILE
