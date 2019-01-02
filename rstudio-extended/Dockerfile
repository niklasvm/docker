ARG R_VERSION=3.5.1
FROM rocker/verse:${R_VERSION}

# get build arguments
ARG GITHUB_USER_EMAIL
ARG GITHUB_USER_NAME
ARG RSTUDIO_BETA_VERSION=1.2.1206
ARG SPARK_VERSION=2.3.2
ARG BUILD_DATE=2018-12-28

# add environment variables
ENV RSTUDIO_VERSION=$RSTUDIO_BETA_VERSION
ENV SPARK_VERSION=$SPARK_VERSION
ENV BUILD_DATE=$BUILD_DATE
ENV PASSWORD=hello
ENV ROOT=TRUE
ENV add=shiny

# installs and updates
RUN apt-get update && \
  apt-get install -y \
  python-pip \
  htop \
  nano \
  wget \
  gdebi-core;

# install pre-release rstudio server
RUN echo "${RSTUDIO_VERSION}" && \
  wget https://s3.amazonaws.com/rstudio-ide-build/server/trusty/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb && \
  gdebi -n rstudio-server-${RSTUDIO_VERSION}-amd64.deb;

# update CRAN snapshot date
RUN MRAN=https://mran.microsoft.com/snapshot/${BUILD_DATE} && \
  echo "options(repos = c(CRAN='$MRAN'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

# install latest h2o
RUN R -e 'install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")))'

# install given spark version, create symbolic link and update SPARK_LOCAL_IP to expose WEB UI
RUN R -e "install.packages('sparklyr')" && \
  R -e "sparklyr::spark_install(version='${SPARK_VERSION}',verbose=T)" && \
  mv /root/spark /opt/ && \
  chown -R rstudio:rstudio /opt/spark/ && \
  ln -s /opt/spark/ /home/rstudio/ && \
  cp /opt/spark/spark-${SPARK_VERSION}-bin-hadoop2.7/conf/spark-env.sh.template /opt/spark/spark-${SPARK_VERSION}-bin-hadoop2.7/conf/spark-env.sh && \
  echo 'SPARK_LOCAL_IP=0.0.0.0' >> /opt/spark/spark-${SPARK_VERSION}-bin-hadoop2.7/conf/spark-env.sh

# install keras
RUN R -e "install.packages('keras')" && \
  pip install virtualenv && \
  su - rstudio -c "R -e \"keras::install_keras()\""

# install aws cli for rstudio user
USER rstudio
RUN pip install awscli --upgrade --user
USER root
ENV PATH="${PATH}:/home/rstudio/.local/bin"

# copy files
COPY /setup_git.sh /setup_git.sh

# ports
EXPOSE 8787 4040
