FROM maven:3.5-jdk-9-slim as build

# procps is very common in build systems, and is a reasonably small package
RUN apt-get update && apt-get install -y --no-install-recommends \
		git \
	&& rm -rf /var/lib/apt/lists/*


WORKDIR /iri

RUN git clone -b v1.4.1.2 https://github.com/iotaledger/iri.git /iri/ 
RUN mvn clean package

# execution image
FROM openjdk:9-jre-slim

COPY --from=build /iri/target/iri*.jar /iri/target/
COPY conf/* /iri/conf/
COPY /docker-entrypoint.sh /

ENV MIN_MEMORY 2G
ENV MAX_MEMORY 4G

#WORKDIR /iri/data

VOLUME /iri/data
VOLUME /iri/conf

EXPOSE 14265
EXPOSE 14777/udp
EXPOSE 15777

ENTRYPOINT ["/docker-entrypoint.sh"]

