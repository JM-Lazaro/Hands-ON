FROM debian:bullseye-slim AS extract

ENV DOGSTATSD_NAMESPACE=test \
    DOGSTATSD_VALUE=1 \
    DOGSTATSD_METRIC_TYPE=gauge \
    LOGS_LINE="test message" \
    APM_ADDRESS_NAME=test-default \
    APM_SPAN_NAME=test-default \
    SLEEP=5

RUN apt-get update \
 && apt install netcat -y \
 && apt install curl -y

COPY scripts /scripts

CMD chmod 777 /scripts/main.sh /scripts/apm.sh

ENTRYPOINT ["/bin/bash", "-c", "/scripts/main.sh"]
