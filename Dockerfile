FROM maven:3.5-jdk-9-slim as build

# install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		git \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /iri

RUN git clone -b master https://github.com/iotaledger/iri.git /iri/
RUN mvn clean package

# execution image
FROM openjdk:9-jre-slim

COPY --from=build /iri/target/iri*.jar /iri/target/
COPY conf/* /iri/conf/
COPY docker-entrypoint.sh /

ENV MIN_MEMORY 2G
ENV MAX_MEMORY 4G

ENV API_PORT 14265
ENV UDP_PORT 14600
ENV TCP_PORT 15600

# default remote api limitations
ENV REMOTE_API_LIMIT "attachToTangle, addNeighbors, removeNeighbors"

# mark ports for expose
EXPOSE $API_PORT
EXPOSE $UDP_PORT/UDP
EXPOSE $TCP_PORT

WORKDIR /iri/data

VOLUME /iri/data
VOLUME /iri/conf

ENTRYPOINT ["/docker-entrypoint.sh"]
