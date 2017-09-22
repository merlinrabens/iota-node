Dockerized IOTA Full Node
=========================

## Install
`docker build -t bluedigits/iota-node .`

## Run
1. Create a folder for IRI's data, e.g. `/iri/data`
2. Create a folder for IRI's config, e.g. `/iri/conf`
3. Create a text file `/iri/conf/neighbors` and specify your neighbors IPs, one neighbor per line.
4. Invoke docker run as follows:
`docker run -d --net=host --name iota-node -e API_PORT=14265 -e UDP_PORT=14600 -e TCP_PORT=15600 -v /iri/data:/iri/data -v /iri/conf/neighbors:/iri/conf/neighbors bluedigits/iota-node:latest`

## Ports
You can specify a different API port and different UDP/TCP receiver ports by changing the values behind the -e flags when invoking _docker run_.

## Note
The syncing process takes a while so be patient. You can watch the logging with: `docker logs iota-node -f`

## Neighbors
Please specify the neighbors within your `neighbors` file by adding the udp or tcp IPs and the corresponding ports, one per line.

Example:
```
udp://neighbor1:14600
udp://neighbor2:14600
```

## Sync data:
You might have a compressed backup of transaction data. If so, you can extract data into the dedicated data folder before running your node.

