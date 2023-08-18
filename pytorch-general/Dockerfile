FROM debian:bullseye-slim

RUN mkdir -p /workspace

# install packages from apt-get
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates 

COPY ./sources-bullseye.list /etc/apt/sources.list
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget curl git libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/*

# install miniconda
RUN wget \
    https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py38_23.5.1-0-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash /Miniconda3-py38_23.5.1-0-Linux-x86_64.sh -b \
    && rm -f /Miniconda3-py38_23.5.1-0-Linux-x86_64.sh 
COPY condarc /root/.condarc
COPY condarc /opt/conda/.condarc
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

# install needded python packages
RUN conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=11.3 -c pytorch -y
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

COPY ./requirements.txt /workspace
RUN pip install --no-cache-dir -r /workspace/requirements.txt

CMD [ "/bin/bash"  ]
