cd /root
docker build iota-node --tag iota-node:latest
#docker build iota-node --no-cache --tag iota-node:latest

read -p "Username:" username
read -p "Password:" password
docker login --username $username --password $password
docker tag iota-node kaidehling/iota-node:latest
docker push kaidehling/iota-node:latest
