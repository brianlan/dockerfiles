FROM continuumio/anaconda3:2021.05

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y libgl1-mesa-glx libgl1-mesa-dri

COPY ./condarc /root/.condarc
COPY ./condarc /opt/conda/.condarc
RUN conda install vispy pyqt llvm=15 -c conda-forge -y

COPY ./requirements.txt /workspace
RUN pip install --no-cache-dir -r /workspace/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip cache purge
