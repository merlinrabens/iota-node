#!/bin/bash

$neighbors
for buddy in $(cat /iri/conf/neighbors); do
  neighbors="$buddy $neighbors"
done
neighbors=${neighbors::-1}

exec java \
  $JAVA_OPTIONS \
  -Xms$MIN_MEMORY -Xmx$MAX_MEMORY \
  -Djava.net.preferIPv4Stack=true \
  -Dlogback.configurationFile=/iri/conf/logback.xml \
  -jar /iri/target/iri*.jar \
  --config /iri/conf/iri.ini \
  --neighboring-socket-address ${TCP_SOCKET_ADDRESS} \
  --neighboring-socket-port ${TCP_PORT} \
  --port $API_PORT \
  --remote=true --remote-limit-api "$REMOTE_API_LIMIT" \
  --neighbors "$neighbors" \
  "$@"

