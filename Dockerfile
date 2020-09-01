# image: afioregartland/python_container
FROM continuumio/anaconda3
RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install git-all
LABEL maintainer="agartlan@fredhutch.org"

WORKDIR /home

RUN curl -k -L https://github.com/agartland/python_container/requirements.yml -o requirements.yml && \
    conda env create -f requirements.yml && \
    conda activate py36

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN cd /home
# ENTRYPOINT ["/bin/bash"]