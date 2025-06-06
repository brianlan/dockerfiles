FROM nvidia/cuda:12.1.0-devel-ubuntu20.04


RUN rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update \
    && apt-get install -y libgl1-mesa-glx build-essential wget git curl libsm6 libxrender1 \
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

RUN apt-get update \
   && apt-get install -y vim htop iputils-ping git-lfs \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

# pip install other libraries
RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir \
        git+https://github.com/huggingface/transformers \
        accelerate==1.3.0 \
        vllm==0.7.2 \
        gradio==5.4.0 \
        gradio_client==1.4.2 \
        transformers-stream-generator==0.0.4 \
        copious==0.1.24 \
        easydict==1.13 \
        pytest==8.3.3 \
        timm==1.0.15 \
        lmdeploy==0.7.2 \
        modelscope==1.24.0 \
        math_verify==0.7.0 \
        blobfile==3.0.0 \
        deepspeed \
        ninja \
        pytest-cov \
        loguru \
        tqdm

# install qwen-vl-utils
RUN pip install --no-cache-dir qwen-vl-utils[decord]==0.0.8
RUN pip install --no-cache-dir datasets==3.1.0 sortedcontainers simplejson
RUN pip install --no-cache-dir modelscope[audio] -f https://modelscope.oss-cn-beijing.aliyuncs.com/releases/repo.html

# Install flash attention (if complaining no cuda env, we can install after docker run and then commit.)
# COPY ./flash_attn-2.7.3+cu12torch2.5cxx11abiFALSE-cp310-cp310-linux_x86_64.whl /flash_attn-2.7.3+cu12torch2.5cxx11abiFALSE-cp310-cp310-linux_x86_64.whl
# RUN MAX_JOBS=4 pip install -v --no-cache-dir --no-build-isolation /flash_attn-2.7.3+cu12torch2.5cxx11abiFALSE-cp310-cp310-linux_x86_64.whl
# RUN rm -rf /flash_attn-2.7.3+cu12torch2.5cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

# Install other package
RUN apt-get update \
    && apt-get install -y ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*s

RUN pip install --no-cache-dir langdetect==1.0.9
RUN pip install --no-cache-dir WeTextProcessing==1.0.4.1
RUN pip install --no-cache-dir pyloudnorm==0.1.1
RUN pip install --no-cache-dir openai-whisper==20240930
RUN pip install --no-cache-dir setproctitle==1.3.3
RUN pip install --no-cache-dir attrdict==2.0.1
RUN pip install --no-cache-dir x-transformers==1.44.4
RUN pip install --no-cache-dir torchdiffeq==0.2.5
RUN pip install --no-cache-dir ms-swift==3.4.0


WORKDIR /workspace

CMD [ "/bin/bash"  ]

