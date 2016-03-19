#!/bin/bash

HEALTHCHECK_FALL=${HEALTHCHECK_FALL:-3}
HEALTHCHECK_RISE=${HEALTHCHECK_RISE:-2}
HEALTHCHECK_PERIOD=${HEALTHCHECK_PERIOD:-5}

success=0
failure=0
expected_body="null: Hello, I'm 0.1 DB: SOLERA,  DB: CHALLENGE, "

echo APP_PORT=${APP_PORT}

while true 
do
    body=$( curl -s localhost:${APP_PORT} ) 
    if [[  "${body}" == "${expected_body}" ]] 
    then
        let success++
        failure=0
        if (( ${success} > ${HEALTHCHECK_RISE} ))
        then
            echo OK > /var/run/demo/health.txt
        else
            echo success count=${success}
        fi
    else
        let failure++
        success=0
        echo "failure count=${failure}; body=${body}"
        if (( ${failure} > ${HEALTHCHECK_FALL} ))
        then
            rm -f /var/run/demo/health.txt
        fi
    fi 

    sleep ${HEALTHCHECK_PERIOD} 
done
