#!/bin/bash

# Create IDs.
TRACE_ID=($RANDOM % 1000000)
SPAN_ID=($RANDOM % 1000000)

# Start a timer.
# For the Alpine image, in order to get the time in nanoseconds,
# you may need to install coreutils ("apk add coreutils").
START=$(date +%s%N)

# Stop the timer.
DURATION=$(($(date +%s%N) - $START))

# Send the traces.
curl -s -X PUT -H "Content-type: application/json" \
  -d "[[{
    \"trace_id\": $TRACE_ID,
    \"span_id\": $SPAN_ID,
    \"name\": \"$APM_SPAN_NAME\",
    \"resource\": \"/home\",
    \"service\": \"$APM_ADDRESS_NAME\",
    \"type\": \"web\",
    \"start\": $START,
    \"duration\": $DURATION
}]]" \
  http://$APM_AGENT_HOST:8126/v0.3/traces
