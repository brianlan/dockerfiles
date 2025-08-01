FROM continuumio/miniconda3:22.11.1

# Ensure /tmp exists and is writable
RUN mkdir -p /tmp && chmod 1777 /tmp

# Create workspace directory
RUN mkdir -p /workspace

# Copy sources.list for Debian Bullseye
COPY source/debian-bullseye/sources.list /etc/apt/sources.list

# install packages from apt-get
RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates 

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget curl git vim htop iputils-ping libgl1-mesa-glx build-essential libsm6 libxrender1 && \
    rm -rf /var/lib/apt/lists/*
    
# install conda packages
COPY source/conda/condarc /root/.condarc
RUN conda install -y pip 

# install python packages
RUN pip config set global.index-url https://pypi.mirrors.ustc.edu.cn/simple
RUN pip install --no-cache-dir \
        tqdm==4.65.0 \        
        tensorflow==2.13.0 \
        jinja2==3.1.3 \
        cherrypy==18.9.0 \
        scipy \
        filterpy \
        cheroot==10.0.0 \
        copious \
        loguru \
        easydict \
        pandas

# install s5cmd
RUN wget https://github.com/peak/s5cmd/releases/download/v2.3.0/s5cmd_2.3.0_linux_amd64.deb -O /s5cmd.deb
RUN dpkg -i /s5cmd.deb
RUN rm /s5cmd.deb

# Copy the auto-collaborator source code
COPY AutoCollaborator-master-056815c1e13042d7ae64f692ba8438ebe5128396 /workspace/AutoCollaborator

WORKDIR /workspace/AutoCollaborator

ENTRYPOINT [ "python", "main.py" ]

CMD [ "--port", "8081" ]
