# image: afioregartland/python_container
FROM continuumio/anaconda3
LABEL maintainer="agartlan@fredhutch.org"

ENV PACKAGES procps git build-essential software-properties-common \
    ca-certificates zlib1g-dev curl unzip autoconf gnupg \
    ed less locales vim-tiny nano wget screen default-jre default-jdk \
    apt-transport-https gnupg-agent

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home

RUN mkdir -p /usr/share/man/man1

RUN apt-get update && \
	apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    apt-get clean

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN curl -k -L https://raw.githubusercontent.com/agartland/python_container/master/requirements.yml -o requirements.yml
RUN conda env create -f requirements.yml && conda init bash

RUN wget -qO- https://get.nextflow.io | bash

# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# RUN add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/debian \
#   $(lsb_release -cs) \
#   stable"
# RUN apt-get install -y docker-ce docker-ce-cli containerd.io

RUN cd /home
# ENTRYPOINT ["/bin/bash"]