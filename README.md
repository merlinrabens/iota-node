Dockerized IOTA Full Node
=========================

## Install
`docker build -t bluedigits/iota-node .`

## Run
1. Create a text file with all neighbors IPs, one neighbor per line.
2. Create a folder where IRI can store it's data.
3. Invoke docker run as follows:
`docker run -d --net=host --name iota-node -p 14265:14265 -p 14777:14777/udp -p 15777:15777 -v data_dir_filepath:/iri/data -v neighbors_filepath:/iri/conf/neighbors bluedigits/iota-node:1.2.1`

## Note
The syncing process takes a while so be patient. You can watch the logging with: `docker logs iota-node -f`

## Neighbors
Please specify the neighbors by adding the udp or tcp IPs and the corresponding ports to the neighbors file, one per line.

Example:
```
udp://neighbor1:14600
udp://neighbor2:14600
```

## Sync data:
You might have a compressed backup of transaction data. If so, you can extract data into the dedicated data folder before running your node.

