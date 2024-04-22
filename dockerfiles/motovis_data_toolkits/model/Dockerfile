FROM zhangjn66/mdt_dev:base

ENV PATH /usr/local/miniconda3/bin:$PATH

# RUN conda activate base

# Install basics
RUN apt-get update -y \
    && apt-get install build-essential -y \
    && apt-get install -y apt-utils git curl ca-certificates bzip2 tree htop wget \
    && apt-get install -y libglib2.0-0 libsm6 libxext6 libxrender-dev bmon iotop g++ \
    && apt install -y libgl1-mesa-glx x11-xserver-utils

# # Install cmake v3.13.2
# RUN apt-get purge -y cmake && \
#     mkdir /root/temp && \
#     cd /root/temp && \
#     wget https://github.com/Kitware/CMake/releases/download/v3.13.2/cmake-3.13.2.tar.gz && \
#     tar -xzvf cmake-3.13.2.tar.gz && \
#     cd cmake-3.13.2 && \
#     bash ./bootstrap && \
#     make && \
#     make install && \
#     cmake --version && \
#     rm -rf /root/temp

RUN pip --no-cache-dir install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

# Install python packages
RUN pip --no-cache-dir install numpy llvmlite numba opencv-python open3d imageio_ffmpeg -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN pip --no-cache-dir install tensorboardX easydict pyyaml==5.4.1 scipy==1.5.4 scikit-image loguru fire tqdm SharedArray six tensorboard==2.11.0 -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN pip --no-cache-dir install spconv-cu113 -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN cd /tmp && wget http://192.168.22.208:8000/docker-building-files/s5cmd/s5cmd_2.2.2_linux_amd64.deb && dpkg -i s5cmd_2.2.2_linux_amd64.deb && rm s5cmd_2.2.2_linux_amd64.deb
