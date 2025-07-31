FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

RUN rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx build-essential wget git curl libsm6 libxrender1 vim htop iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install anaconda
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-py310_24.7.1-0-Linux-x86_64.sh --output conda_installer.sh
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

# conda install critical libraries
# COPY .condarc /root/.condarc
RUN conda install -y pytorch=2.4.1 torchvision=0.19.1 torchaudio=2.4.1 pytorch-cuda=12.1 -c pytorch -c nvidia

# pip install other libraries
RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir numba==0.60.0 numpy==1.26.4 scipy==1.13.1 nuscenes-devkit opencv-python-headless==4.11.0.86 tqdm loguru ninja copious fsspec==2025.7.0

# Install detectron2
RUN MAX_JOBS=16 pip install -v --use-pep517 --no-build-isolation 'git+https://github.com/facebookresearch/detectron2.git'

# Install mmcv
RUN pip install --no-cache-dir openmim
RUN MAX_JOBS=16 FORCE_CUDA=1 MMCV_WITH_OPS=1 TORCH_CUDA_ARCH_LIST=8.0 mim install -v --no-cache-dir mmcv==2.1.0

# Install TorchEx
RUN git clone https://github.com/Abyssaledge/TorchEx.git
RUN MAX_JOBS=16 TORCH_CUDA_ARCH_LIST=8.0 pip install -v --use-pep517 --no-build-isolation ./TorchEx
# RUN cd TorchEx && pip install --use-pep517 -e .


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

# install extra system utils

# install extra python packages
RUN pip install --no-cache-dir av2==0.3.5
RUN pip install --no-cache-dir polars==1.28.0
RUN pip install --no-cache-dir hydra-core==1.3.2
RUN pip install --no-cache-dir hydra-submitit-launcher==1.2.0
RUN pip install --no-cache-dir pytorch_lightning==2.5.2
RUN pip install --no-cache-dir tensorflow==2.11.0
RUN pip install --no-cache-dir wandb==0.13.11


WORKDIR /workspace

CMD [ "/bin/bash"  ]

