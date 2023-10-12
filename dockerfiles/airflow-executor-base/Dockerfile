FROM debian:bullseye-slim

# install packages from apt-get
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates 

COPY source/debian-bullseye/sources.list /etc/apt/sources.list
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget curl && \
    rm -rf /var/lib/apt/lists/*

# install miniconda
RUN wget \
    https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py38_23.5.1-0-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash /Miniconda3-py38_23.5.1-0-Linux-x86_64.sh -b \
    && rm -f /Miniconda3-py38_23.5.1-0-Linux-x86_64.sh 
COPY source/conda/condarc /root/.condarc

# install minio client
RUN curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /root/minio-binaries/mc

# set PATH
ENV PATH="/root/miniconda3/bin:/root/minio-binaries:${PATH}"
ARG PATH="/root/miniconda3/bin:/root/minio-binaries:${PATH}"

# install python packages
RUN pip install --no-cache-dir tqdm==4.65.0 -i https://pypi.tuna.tsinghua.edu.cn/simple

# prepare s3cmd
RUN pip install --no-cache-dir s3cmd==2.3.0


CMD [ "/bin/bash" ]
