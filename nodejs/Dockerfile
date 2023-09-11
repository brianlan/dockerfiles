FROM --platform=linux/amd64 ubuntu:20.04

RUN mkdir /workspace

RUN apt-get update \
    && apt-get install -y wget ca-certificates

COPY sources/ubuntu/sources.list /etc/apt/

# to prevent stuck at npm install asking for your input on Geographic area
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y npm vim git apache2 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

CMD ["apachectl", "-D", "FOREGROUND"]