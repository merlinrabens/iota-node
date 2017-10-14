#!/bin/bash

$neighbors
for buddy in $(cat /iri/conf/neighbors); do
  neighbors="$buddy $neighbors"
done
neighbors=${neighbors::-1}

#exec java -XX:+DisableAttachMechanism -Xmx$MEMORY -Xms$MEMORY -Dlogback.configurationFile=/iri/conf/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/target/iri*.jar -p 14265 -u 14777 -t 15777 -n "$neighbors" --remote --remote-limit-api "attachToTangle, addNeighbors, removeNeighbors" --send-limit 100.0 "$@"
exec java -XX:+DisableAttachMechanism -Xmx$MAX_MEMORY -Xms$MIN_MEMORY -Dlogback.configurationFile=/iri/conf/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/target/iri*.jar -p 14265 -u 14777 -t 15777 -n "$neighbors" --remote "$@"

