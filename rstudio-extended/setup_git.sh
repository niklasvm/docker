#!/bin/bash

# set up github credentials and config

# capture command line arguments
GITHUB_PRIVATE_KEY="$1";
GITHUB_USER_EMAIL="$2";
GITHUB_USER_NAME="$3";

# create directory
mkdir /home/rstudio/.ssh

# create key file
echo $GITHUB_PRIVATE_KEY > /home/rstudio/.ssh/id_rsa

# set permissions
chown -R rstudio /home/rstudio/.ssh
chmod 600 /home/rstudio/.ssh/id_rsa && \
chmod 700 /home/rstudio/.ssh && \

# set configuration
git config --global user.email "${GITHUB_USER_EMAIL}" && \
git config --global user.name "${GITHUB_USER_NAME}" && \
git config --global core.fileMode false

rstudio-server restart;
