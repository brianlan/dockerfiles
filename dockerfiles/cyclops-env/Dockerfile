FROM nvidia/cuda:11.3.1-devel-ubuntu20.04
RUN mkdir -p /workspace

COPY source/ubuntu-20.04/sources.list /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx build-essential wget git curl libsm6 libxrender1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install anaconda
RUN curl https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2021.05-Linux-x86_64.sh --output anaconda.sh
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
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
COPY source/conda/condarc /root/.condarc

# prepare mc (Minio Client)
ADD tools/mc /usr/bin/
RUN mc alias set minio224 http://192.168.22.224:9000/  mCpYhETiwPqlS1l4lzZm nuhCvHJ1cYW8FnU6HfSIT9ager7dl2QZkaJdKOp9

# install pytorch
RUN mc cp minio224/motovis-temporary/tools/torch-1.11.0+cu113-cp38-cp38-linux_x86_64.whl .
RUN mc cp minio224/motovis-temporary/tools/torchvision-0.12.0+cu113-cp38-cp38-linux_x86_64.whl .
RUN pip install torch-1.11.0+cu113-cp38-cp38-linux_x86_64.whl torchvision-0.12.0+cu113-cp38-cp38-linux_x86_64.whl
RUN pip install --no-cache-dir torchaudio==0.11.0

# install other dependencies
RUN pip install --no-cache-dir easydict==1.9 \
    pyyaml==5.4.1  \
    deprecated==1.2.13 \
    tensorboard==2.10.0 \
    termcolor==1.1.0 \
    tqdm==4.59.0 \
    opencv-python==4.2.0.34 \
    pandas==1.2.4 \
    scipy==1.5.4 \
    matplotlib==3.3.4 \
    scikit-image==0.18.1 \
    scikit-learn==0.24.1 \
    numba==0.56.4 \
    efficientnet_pytorch==0.7.1 \
    thop==0.0.31.post2005241907 \
    sympy==1.8 \
    terminaltables==3.1.10 \
    addict==2.4.0 \
    cython==0.29.23 \
    pyquaternion==0.9.9 \
    cvxpy==1.2.2 \
    open3d==0.14.1 \
    setuptools==65.6.3
    # pycocotools==2.0.4

# prepare pytorch resnet-18 pretrain model
RUN mkdir -p /root/.cache/torch/hub/checkpoints/ \
    && mc cp minio224/motovis-temporary/tools/resnet18-f37072fd.pth /root/.cache/torch/hub/checkpoints/

WORKDIR /workspace

CMD [ "/bin/bash"  ]
