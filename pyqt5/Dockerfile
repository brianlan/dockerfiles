FROM --platform=linux/amd64 ubuntu:20.04

RUN mkdir /workspace

RUN apt-get update \
    && apt-get install -y wget ca-certificates

COPY sources/ubuntu/sources.list /etc/apt/

RUN cd /workspace \
  && wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh \
  && bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b \
  && rm Miniconda3-py39_4.12.0-Linux-x86_64.sh 

ENV PATH=/root/miniconda3/bin:$PATH

RUN apt-get update \
    && apt-get install -y x11-apps libgl1-mesa-glx ffmpeg libsm6 libxext6 \
    '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
    libxkbcommon-dev libxkbcommon-x11-dev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN pip --no-cache-dir install labelCloud -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip --no-cache-dir install -U PyOpenGL==3.1.6 PyOpenGL-accelerate~=3.1.5 -i https://pypi.tuna.tsinghua.edu.cn/simple

CMD ["/bin/bash"]
