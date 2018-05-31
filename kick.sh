#!/usr/bin/env bash
set -x

# Hostname and container name
CONTAINER=$1

# Erase old keys and generate/regenerate old ones
rm -rf id_rsa*
ssh-keygen -t rsa -N "" -f id_rsa

# Invoke a second shell to build the image
(cd server && docker build . -t server)

# Erase any existing container and start the new one
docker stop wirecard; docker rm wirecard
docker run --detach \
  --volume $(pwd)/id_rsa.pub:/home/admin/.ssh/authorized_keys:ro \
  --publish 8022:22 --publish 8080:80 --publish 8443:443         \
  --name ${CONTAINER} --hostname ${CONTAINER}                    \
  server

