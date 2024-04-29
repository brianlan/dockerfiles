# FROM ubuntu:16.04 
FROM osrf/ros:noetic-desktop-full

RUN apt update
RUN apt-get install -y apt-transport-https ca-certificates vim

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN rm /etc/apt/sources.list
# RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse" > /etc/apt/sources.list'
# RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list'
# RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list'
# RUN sh -c 'echo "deb http://security.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list'

RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list'
RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list'
RUN sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list'
RUN sh -c 'echo "deb http://security.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list'

RUN apt-get update && apt-get install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y wget zip libpcap-dev x11-xserver-utils python3-pip git libparmetis-dev python3-tk ros-noetic-pybind11-catkin

RUN pip3 install easydict scipy numpy==1.22.1 tqdm open3d s3cmd==2.3.0 bitstring==4.0.1 -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN pip3 install torch==1.7.1+cpu -f https://download.pytorch.org/whl/torch_stable.html

RUN git clone https://github.com/eric-wieser/ros_numpy /usr/local/src/ros_numpy
RUN cd /usr/local/src/ros_numpy && python3 setup.py install

# RUN pip3 install pyyaml -i https://pypi.tuna.tsinghua.edu.cn/simple some-package
RUN sed -i 's/for (Eigen::Index ni = 0; ni < relative_coordinates.cols (); ni++)/for (int ni = 0; ni < relative_coordinates.cols (); ni++)/' /usr/include/pcl-1.10/pcl/filters/voxel_grid.h
RUN sed -i '12i\#define EIGEN_PI 3.141592654' /usr/include/eigen3/unsupported/Eigen/src/EulerAngles/EulerSystem.h

RUN wget -O /usr/local/src/gtsam.zip https://github.com/borglab/gtsam/archive/4.0.0-alpha2.zip

RUN cd /usr/local/src && unzip gtsam.zip
RUN cd /usr/local/src/gtsam-4.0.0-alpha2/ && mkdir build && cd build && cmake .. && make install -j16
