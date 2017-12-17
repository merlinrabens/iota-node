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

## Additional Parameters
You can specifiy IRI parameters to the end of your `docker run` command chain, e.g. you want IRI to revalidate it's database, just add `--revalidate`.

Full command would be then: `docker run -d --net=host --name iota-node -e API_PORT=14265 -e UDP_PORT=14600 -e TCP_PORT=15600 -v /iri/data:/iri/data -v /iri/conf/neighbors:/iri/conf/neighbors bluedigits/iota-node:latest --revalidate`

## API Limits
You can forbid API commands you don't want IRI to interpret by specifying another ENV variable named `REMOTE_API_LIMIT`. This is by default set to `"attachToTangle, addNeighbors, removeNeighbors"`.

**Example:** You want IRI to forbid the `getNeighbors` command but to allow anything else, just specify `-e REMOTE_API_LIMIT "getNeighbors"`. Multiple limits have to be comma-separated.

## Ports
You can specify a different API port and different UDP/TCP receiver ports by changing the values behind the -e flags when invoking _docker run_.
* API_PORT: The port IRI listens on for receiving API commands, i.e. `getNeighbors`, `attachToTangle`, etc.
* UDP_PORT: The UDP port IRI listens on for mutually exchanging transactions.
* TCP_PORT: The TPC port IRI listens on for mutually exchanging transactions.

## Java Options
You can specify a custom set of Java JVM arguments by adding the environment variable JAVA_OPTIONS when invoking _docker run_. Please note that you have to include the defaults for JAVA_OPTIONS if you don't want to remove them!

Example:
 `docker run [...] -e JAVA_OPTIONS="-XX:-PrintCommandLineFlags -XX:-PrintGCDetails -Xlog:gc:garbage-collection.log" bluedigits/iota-node`
* JAVA_OPTIONS: JVM Options which are passed to the java process

## Note
The syncing process takes a while so be patient. You can watch the logging with: `docker logs iota-node -f`.

## Neighbors
Please specify the neighbors within your `neighbors` file by adding the udp or tcp IPs and the corresponding ports, one per line.

Example:
```
udp://neighbor1:14600
udp://neighbor2:14600
```
## Memory Options
Memory options are currently not used in the image because we suggest to run without explicit memory options for java heap. Majority of memory is consumed by RocksDB and this is native memory and not limited by the -Xmx and -Xms options. So we don't want to bind physical memory to java heap which is most of the time not required by iri. The idea is to leave as much memory as possible unbound and available for RocksDB.
To avoid native out of memory exceptions on a machine with limited resources you may add swap to survive memory peaks.

## Sync data:
You might have a compressed backup of transaction data. If so, you can extract data into the dedicated data folder before running your node.

