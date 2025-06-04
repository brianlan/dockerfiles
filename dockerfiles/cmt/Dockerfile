FROM nvidia/cuda:11.1.1-devel-ubuntu20.04
RUN mkdir -p /workspace

# COPY source/ubuntu-20.04/sources.list /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx build-essential wget git curl libsm6 libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install anaconda
RUN curl http://192.168.22.208:8000/docker-building-files/anaconda/Anaconda3-2021.05-Linux-x86_64.sh --output anaconda.sh
RUN /bin/bash anaconda.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && /opt/conda/bin/conda clean -afy
RUN rm anaconda.sh

ENV PATH=/opt/conda/bin:$PATH
ENV CUDA_HOME=/usr/local/cuda
RUN pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple
COPY source/conda/condarc /root/.condarc

# prepare s3cmd
RUN pip install --no-cache-dir s3cmd==2.3.0
# install s5cmd
RUN curl http://192.168.22.208:8000/docker-building-files/s5cmd/s5cmd_2.2.2_linux_amd64.deb --output s5cmd_2.2.2_linux_amd64.deb
RUN dpkg -i s5cmd_2.2.2_linux_amd64.deb
# install s3fs
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y s3fs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*



# install pytorch
RUN curl http://192.168.22.208:8000/docker-building-files/python-packages/torch-1.9.0+cu111-cp38-cp38-linux_x86_64.whl --output torch-1.9.0+cu111-cp38-cp38-linux_x86_64.whl
RUN curl http://192.168.22.208:8000/docker-building-files/python-packages/torchvision-0.10.0+cu111-cp38-cp38-linux_x86_64.whl --output torchvision-0.10.0+cu111-cp38-cp38-linux_x86_64.whl
RUN pip install --no-cache-dir torch-1.9.0+cu111-cp38-cp38-linux_x86_64.whl torchvision-0.10.0+cu111-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.9.0+cu111-cp38-cp38-linux_x86_64.whl torchvision-0.10.0+cu111-cp38-cp38-linux_x86_64.whl
RUN pip install --no-cache-dir torchaudio==0.9.0



# install multirun
RUN wget -c http://192.168.22.208:8000/docker-building-files/executables/multirun-x86_64-linux-gnu-1.1.3.tar.gz -O - | tar -xz && mv multirun /bin

# prepare pytorch resnet-18 pretrain model
RUN mkdir -p /root/.cache/torch/hub/checkpoints

RUN curl http://192.168.22.208:8000/docker-building-files/checkpoints/resnet18-5c106cde.pth --output /root/.cache/torch/hub/checkpoints/resnet18-5c106cde.pth

# install cmake
RUN apt-get update \
     && apt-get install -y cmake \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

# install some c++ libraries
RUN apt-get update \
     && apt-get install -y libpcl-dev libboost-all-dev libeigen3-dev\
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*


# install other python dependencies
# may have dependence among each other
RUN pip install --no-cache-dir tensorboard==2.14.0 \
    tensorboardX==2.4.1 \
    opencv-python==4.9.0.80 \
    pandas==1.5.0 \
    scipy==1.10.1 \
    matplotlib==3.5.3 \
    scikit-image==0.19.3 \
    scikit-learn==1.3.2 \
    numba==0.53.0 \
    pyquaternion==0.9.9 \
    open3d==0.18.0 \
    pycocotools==2.0.7 \
    SharedArray==3.2.0 \
    csaps==1.1.0

# independent ones
RUN pip install --no-cache-dir flask==3.0.3
RUN pip install --no-cache-dir jinja2==3.1.4
RUN pip install --no-cache-dir termcolor==1.1.0
RUN pip install --no-cache-dir tqdm==4.59.0
RUN pip install --no-cache-dir terminaltables==3.1.10
RUN pip install --no-cache-dir addict==2.4.0
RUN pip install --no-cache-dir rlanutils==0.1.8
RUN pip install --no-cache-dir bitstring==4.0.1
RUN pip install --no-cache-dir pybind11==2.11.1
RUN pip install --no-cache-dir copious==0.1.16 -i https://www.pypi.org/simple
RUN pip install --no-cache-dir easydict==1.13

RUN pip install --no-cache-dir mmcv-full==1.6.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.9.0/index.html
RUN pip install --no-cache-dir numba==0.53.0 numpy==1.23.5 yapf==0.40.1  setuptools==59.5.0  spconv-cu111==2.1.21
RUN pip install --no-cache-dir flash-attn==0.2.2
RUN pip install --no-cache-dir mmdet==2.28.2
RUN pip install --no-cache-dir mmsegmentation==0.30.0


RUN curl http://192.168.22.208:8000/docker-building-files/python-packages/mmdetection3d.zip --output /workspace/mmdetection3d.zip
RUN cd /workspace && unzip mmdetection3d.zip
RUN cd /workspace/mmdetection3d && pip install  -e .
RUN sed -i '59a\ \ \ \ return\ arch' /opt/conda/lib/python3.8/site-packages/spconv/pytorch/cppcore.py

RUN pip install --no-cache-dir loguru==0.7.2 
RUN pip install --no-cache-dir motmetrics==1.1.3

# Rest
WORKDIR /workspace
CMD [ "/bin/bash"  ]

# docker build -f Dockerfile -t 192.168.23.222:4443/cmt:v0.1 .
