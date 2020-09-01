# image: afioregartland/python_container
FROM continuumio/anaconda3
LABEL maintainer="agartlan@fredhutch.org"

ENV PACKAGES procps git-all\
    ca-certificates zlib1g-dev curl unzip autoconf gnupg \
    ed less locales vim-tiny nano wget screen openjdk-8-jdk

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home

RUN apt-get update && \
	apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    apt-get clean

RUN curl -k -L https://raw.githubusercontent.com/agartland/python_container/master/requirements.yml -o requirements.yml
RUN conda env create -f requirements.yml && conda init bash

RUN wget -qO- https://get.nextflow.io | bash

RUN cd /home
# ENTRYPOINT ["/bin/bash"]