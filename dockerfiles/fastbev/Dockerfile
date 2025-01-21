FROM nvidia/cuda:11.1.1-devel-ubuntu20.04
RUN mkdir -p /workspace

# COPY source/ubuntu-20.04/sources.list /etc/apt/sources.list
RUN rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx build-essential wget git curl htop vim libsm6 libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install libgllib2.0 and set TimeZone
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
RUN apt-get update \
   && apt-get install -y libglib2.0-0 libxext6 tzdata  \
   && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
   && echo $TZ > /etc/timezone \
   && dpkg-reconfigure -f noninteractive tzdata \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

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


# install miniconda
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py38_23.3.1-0-Linux-x86_64.sh --output conda_installer.sh
RUN /bin/bash conda_installer.sh -b -p /opt/conda \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && /opt/conda/bin/conda clean -afy
RUN rm conda_installer.sh

ENV PATH=/opt/conda/bin:$PATH
ENV CUDA_HOME=/usr/local/cuda


RUN pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple
COPY source/conda/condarc /root/.condarc


# install pytorch (assume torch and torchvision whl are ready in the root directory)
COPY torch-1.8.1+cu111-cp38-cp38-linux_x86_64.whl /workspace/
COPY torchvision-0.9.1+cu111-cp38-cp38-linux_x86_64.whl /workspace/
RUN pip install --no-cache-dir /workspace/torch-1.8.1+cu111-cp38-cp38-linux_x86_64.whl /workspace/torchvision-0.9.1+cu111-cp38-cp38-linux_x86_64.whl
RUN rm /workspace/torch-1.8.1+cu111-cp38-cp38-linux_x86_64.whl /workspace/torchvision-0.9.1+cu111-cp38-cp38-linux_x86_64.whl
RUN pip install --no-cache-dir torchaudio==0.8.1


# install basic python dependencies
RUN pip install --no-cache-dir tensorboard==2.14.0 \
    tensorboardX==2.4.1 \
    opencv-python==4.9.0.80 \
    pandas==2.0.3 \
    scipy==1.10.1 \
    matplotlib==3.5.3 \
    scikit-image==0.19.3 \
    scikit-learn==1.3.2 \
    pyquaternion==0.9.9 \
    pycocotools==2.0.7 \
    SharedArray==3.2.0 \
    csaps==1.1.0 \
    tqdm==4.59.0 \
    termcolor==1.1.0 \
    flask==3.0.3 \
    jinja2==3.1.4 \
    terminaltables==3.1.10 \
    addict==2.4.0 \
    rlanutils==0.1.8 \
    bitstring==4.0.1 \
    pybind11==2.11.1 \
    copious==0.1.24 \
    easydict==1.13 \
    loguru \
    ipdb 

# install mmcv, mmdet, mmsegmentation
RUN pip install --no-cache-dir mmcv==1.4.0 mmdet==2.14.0 mmsegmentation==0.14.1 mmcv-full==1.4.0
RUN pip install --no-cache-dir timm==0.6.13 numba==0.48.0

# install spconv
RUN pip install --no-cache-dir spconv-cu111==2.1.21

# install flash-attn
RUN pip install --no-cache-dir flash-attn==0.2.2

# install numpy (fix this version to avoid np.long error)
RUN pip install --no-cache-dir numpy==1.23.5

# install nuscenes-devkit
RUN pip install --no-cache-dir \
        nuscenes-devkit==1.1.11 \
        lyft_dataset_sdk==0.0.8 \
        trimesh==2.35.39 \
        yapf==0.40.1


# manual fix for spconv
RUN sed -i '59a\ \ \ \ return\ arch' /opt/conda/lib/python3.8/site-packages/spconv/pytorch/cppcore.py

# Rest
WORKDIR /workspace
CMD [ "/bin/bash"  ]
