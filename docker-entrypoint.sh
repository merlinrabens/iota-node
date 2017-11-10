#!/bin/bash

$neighbors
for buddy in $(cat /iri/conf/neighbors); do
  neighbors="$buddy $neighbors"
done
neighbors=${neighbors::-1}

exec java --add-modules java.xml.bind -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+DisableAttachMechanism -Xms$MIN_MEMORY -Xmx$MAX_MEMORY -Dlogback.configurationFile=/iri/conf/logback.xml -Djava.net.preferIPv4Stack=true -jar /iri/target/iri*.jar -p 14265 -u 14777 -t 15777 -n "$neighbors" --remote --remote-limit-api "attachToTangle, addNeighbors, removeNeighbors" "$@"

