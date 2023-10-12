FROM continuumio/anaconda3:2021.05

COPY source/debian-bullseye/sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y libgl1-mesa-glx libgl1-mesa-dri x11-apps

COPY source/conda/condarc /root/.condarc
COPY source/conda/condarc /opt/conda/.condarc

RUN conda create -n vispyrender_py38 python=3.8
RUN conda install -n vispyrender_py38 vispy pyqt llvm=15 -c conda-forge -y

RUN /opt/conda/envs/vispyrender_py38/bin/pip install --no-cache-dir jupyter \
    jupyter_rfb \
    pytest \
    requests \
    fire \
    black \
    loguru \
    pandas \
    flake8 \
    pyrender \
    matplotlib \
    imgui \
    glfw \ 
    opencv-python \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN echo "conda activate vispyrender_py38" >> /root/.bashrc
