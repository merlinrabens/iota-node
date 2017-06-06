#!/bin/bash

$hosts
for ip in $(cat ../conf/neighbors); do
  hosts="$ip $hosts"
done
hosts=${hosts::-1}
command="docker run -d --name iota-node -p 14265:14265 -p 14600:14600/udp -p 14700:14700 -e 'NEIGHBORS="$hosts"' -e JAVA_OPTIONS='-Xmx4g' -v /opt/iri/data:/opt/iri/data bluedigits/iota-node:1.1.4.2 &"
eval $command
