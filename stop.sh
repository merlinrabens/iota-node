#!/bin/bash
docker update --restart=no iota-node

pid=$(ps -C java -o pid=)
echo $pid
kill -s 2 $pid

docker logs -f --since 1m iota-node
