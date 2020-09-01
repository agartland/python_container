# image: afioregartland/python_container
FROM continuumio/anaconda3
LABEL maintainer="agartlan@fredhutch.org"

ENV PACKAGES procps git-all\
    ca-certificates zlib1g-dev curl unzip autoconf gnupg \
    ed less locales vim-tiny nano wget screen

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    apt-get clean

RUN curl -k -L https://github.com/agartland/python_container/requirements.yml -o requirements.yml
# RUN conda env create -f requirements.yml && conda activate py36

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN cd /home
# ENTRYPOINT ["/bin/bash"]