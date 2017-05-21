FROM java:8

ADD bin /opt/iri/bin
ADD conf /opt/iri/conf
ADD data /opt/iri/data
WORKDIR /opt/iri/data

EXPOSE 14700
EXPOSE 14777
EXPOSE 15777

ENTRYPOINT java -jar ../bin/iri-1.1.3.10.jar -p 14700 -u 14777 -t 15777 -n "$NEIGHBORS" --testnet --remote --remote-limit-api "attachToTangle, addNeighbors, removeNeighbors"
