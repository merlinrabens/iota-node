Dockerized IOTA Full Node
=========================

## Install
`docker build -t bluedigits/iota-node .`

## Run
Fill in the neighbors you want in conf/neighbors file. Please be aware of having a minimum of 2 neighbors, the optimum being 7-9. Then change to dir /bin and run iri.sh.

## Note
The syncing process takes a while so be patient. You can watch the logging with: `docker logs iota-node -f`

## Neighbors
Please specify the neighbors by adding the udp or tcp IPs and the corresponding ports to the conf/neighbors file, one per line.

Example:
`udp://yournodeip:14600`

## Sync data:
You can preload your node with transaction data, if you have:
  * Create a folder where you want to store the data and extract the files there
  * Specify this folder as data volume within the iri.sh shell script file: `-v full_path_to_your_data_folder:/opt/iri/data`

