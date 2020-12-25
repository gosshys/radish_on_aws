FROM python:rc-buster

ENV TZ Asia/Tokyo

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    curl \
    libxml2-utils \
    ffmpeg \
    jq

RUN pip3 install awscli --upgrade

WORKDIR /var

ENV PATH $PATH:/usr/local/lib/python3.7/site-packages/awscli

ADD https://raw.githubusercontent.com/uru2/radish/master/radi.sh .
ADD run.sh .
RUN chmod +x radi.sh
RUN chmod +x run.sh

