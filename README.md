Dockerized IOTA Full Node
=========================

## Sync data
  * Will be provided soon!

## Install
`docker build -t bluedigits/iota-node .

## Run
`docker run -d -p 14265:14265 -e "NEIGHBORS=udp://neighbor_1 udp://neighbor_2" --name iota-node bluedigits/iota-node`

## Note
The syncing process takes a while so be patient. You can watch the logging with: `docker logs iota-node -f`

## Neighbors
Please specify the neighbors by adding the udp or tcp IPs to the NEIGHBORS variable.

## Sync data:
You can preload your node with transaction data (will be provided soon): create a folder where you want to store the data and extract it there. Then map this folder as data volume when running your docker container:
`docker run -d -p 14265:14265 -e "NEIGHBORS=udp://neighbor_1 udp://neighbor_2" --name iota-node -v full_path_to_your_data_folder:/opt/iri/data bluedigits/iota-node`

