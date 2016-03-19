#!/bin/bash

while true 
do
    if curl -s localhost:8080 | grep -q SOLERA
    then
        touch /var/run/demo/health.txt
    else
        rm -f /var/run/demo/health.txt
    fi 

    sleep 5
done
