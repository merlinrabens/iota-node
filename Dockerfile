#
# Clone image
#
FROM alpine/git as clone

RUN git clone -b master https://github.com/iotaledger/iri.git /iri

#
# Build image
#
FROM maven:3.5-jdk-8-alpine as build

WORKDIR /iri
COPY --from=clone /iri /iri
RUN mvn clean package -DskipTests=true

#
# Execution image
#
FROM openjdk:8-slim

COPY --from=build /iri/target/iri*.jar /iri/target/
COPY conf/* /iri/conf/
COPY docker-entrypoint.sh /

# Allow change of ports in the container. 
ENV API_PORT 14265
ENV TCP_PORT 15600 

# Allow change of bind address
ENV TCP_SOCKET_ADDRESS "0.0.0.0"

# Default jvm arguments
ENV JAVA_OPTIONS "-XX:+DisableAttachMechanism -XX:+HeapDumpOnOutOfMemoryError"
# Example to make java use docker's memory limits to change its own memory configuration
# (https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits)
#
# ENV JAVA_OPTIONS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"

# Default java memory settings
ENV MIN_MEMORY 2G
ENV MAX_MEMORY 4G

# Default remote api limitations
ENV REMOTE_API_LIMIT "attachToTangle, addNeighbors, removeNeighbors"

# Mark ports for expose
EXPOSE $API_PORT
EXPOSE $TCP_PORT

WORKDIR /iri/data

# Define volumes
VOLUME /iri/data
VOLUME /iri/conf

ENTRYPOINT ["/docker-entrypoint.sh"]
