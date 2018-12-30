#!/bin/bash

docker image build \
  --tag niklasvm/rstudio \
  --build-arg GITHUB_USER_NAME='niklasvm' \
  --build-arg GITHUB_USER_EMAIL='niklasvm@gmail.com' \
  .

CONTAINER_NAME=rstudio;

# stop and remove container if already exists
docker stop $CONTAINER_NAME;
docker rm $CONTAINER_NAME;

# run container
docker run \
  --name $CONTAINER_NAME \
  -it -d \
  -p 8787:8787 \
  -p 4040:4040 \
  niklasvm/rstudio;

# ssh in as rstudio user
# docker exec -ti --user rstudio ${CONTAINER_NAME} bash;
