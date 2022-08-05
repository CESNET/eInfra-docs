FROM debian:buster

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN addgroup --gid 1000 group &&  adduser --gid 1000 --uid 1000 --disabled-password --gecos user user
