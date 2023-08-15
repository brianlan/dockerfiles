FROM continuumio/anaconda3:2021.05
RUN mkdir -p /workspace
RUN mkdir -p /projects

COPY ./sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y libgl1-mesa-glx

COPY ./condarc /root/.condarc
COPY ./condarc /opt/conda/.condarc
RUN conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=11.0 -c pytorch -y

COPY ./requirements.txt /workspace
RUN pip install -r /workspace/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN mkdir -p /home/rlan
RUN mkdir -p /ssd/commondata

CMD [ "/bin/bash"  ]
