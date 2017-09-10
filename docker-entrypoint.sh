#!/bin/bash

$neighbors
for buddy in $(cat /iri/conf/neighbors); do
  neighbors="$buddy $neighbors"
done
neighbors=${neighbors::-1}

exec java -XX:+DisableAttachMechanism -Xmx4g -Xms4g -Dlogback.configurationFile=/iri/conf/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/target/iri-1.3.2.jar -p 14265 -u 14777 -t 15777 -n "$neighbors" --remote --remote-limit-api "attachToTangle, addNeighbors, removeNeighbors" --send-limit 100.0 "$@"
