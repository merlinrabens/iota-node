cd /home/ec2-user/docker/
docker build iota-node --no-cache --tag iota-node:latest
docker tag iota-node kaidehling/iota-node:latest
docker push kaidehling/iota-node:latest
