#!/bin/bash

while true; do

## DOGSTATSD
if [[ $DOGSTATSD_ENABLE == "true" ]] && [[ -n ${DOGSTATSD_HOST} ]]; then
echo -n "$DOGSTATSD_NAMESPACE.custom_metric:$DOGSTATSD_VALUE|$DOGSTATSD_METRIC_TYPE|#$DOGSTATSD_TAGS" | nc -v -u -w 1 $DOGSTATSD_HOST 8125;
fi

## LOG
if [[ $LOGS_ENABLE == "true" ]]; then
echo $LOGS_LINE;
fi

## APM
if [[ $APM_ENABLE == "true" ]] && [[ -n ${APM_AGENT_HOST} ]]; then
/scripts/apm.sh
fi

## SLEEP
sleep $SLEEP;


done
