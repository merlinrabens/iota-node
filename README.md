Dockerized IOTA Full Node
=========================

## Install
`docker build -t bluedigits/iota-node .`

## Run
1. Create a folder for IRI's data, e.g. `/iri/data`
2. Create a folder for IRI's config, e.g. `/iri/conf`
3. Create a text file `/iri/conf/neighbors` and specify your neighbors IPs, one neighbor per line.
4. Invoke docker run as follows:
`docker run -d --net=host --name iota-node -v /iri/data:/iri/data -v /iri/conf/neighbors:/iri/conf/neighbors bluedigits/iota-node:latest`

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

