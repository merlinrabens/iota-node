FROM java:8

ADD bin /opt/iri/bin
WORKDIR /opt/iri/data

EXPOSE 14265

CMD java $JAVA_OPTIONS -jar -Djava.net.preferIPv4Stack=true ../bin/iri-1.1.4.2.jar -p 14265 -n "$NEIGHBORS" --remote --remote-limit-api "attachToTangle, addNeighbors, removeNeighbors"
