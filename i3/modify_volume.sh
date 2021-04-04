#!/bin/bash
COMMAND=$1
ARG=$2
for SINK in `pacmd list-sinks | grep 'index:' | cut -b12-`
do
    echo $COMMAND $SINK $ARG
    pactl $COMMAND $SINK $ARG
done
