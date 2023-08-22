FROM continuumio/anaconda3:2021.05

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y libgl1-mesa-glx libgl1-mesa-dri

COPY ./condarc-tsinghua /root/.condarc
COPY ./condarc-tsinghua /opt/conda/.condarc
RUN conda create -n vispyrender_py38 python=3.8
RUN conda install -n vispyrender_py38 vispy pyqt llvm=15 -c conda-forge -y

COPY ./requirements.txt /
RUN /opt/conda/envs/vispyrender_py38/bin/pip install --no-cache-dir -r /requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN echo "conda activate vispyrender_py38" >> /root/.bashrc
