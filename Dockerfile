FROM osrf/ros:noetic-desktop-full

MAINTAINER Rajiv Bharadwaj <rajivbh@umich.edu>
LABEL Description="ROS-Noetic Desktop Full (Ubuntu 20.04)"

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN apt-get update && apt-get install -y \
    locales \
    lsb-release \
    mesa-utils \
    git \
    subversion \
    nano \
    xterm \
    wget \
    curl \
    htop \
    xauth \
    glmark2 \
    gnupg2 \
    libssl-dev \
    build-essential \
    dbus-x11 \
    software-properties-common \
    gdb valgrind zsh tmux && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Python Essentials
RUN apt-add-repository universe
RUN apt-get update && apt-get install -y python3-pip python build-essential && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/bin/yes | pip3 install --upgrade pip
RUN /usr/bin/yes | pip3 install --upgrade virtualenv
RUN /usr/bin/yes | pip3 install --ignore-installed --upgrade numpy protobuf
RUN /usr/bin/yes | pip3 install --upgrade setuptools

# Locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Configure ROS
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.bashrc
RUN echo "source /opt/ros/noetic/setup.zsh" >> /root/.zshrc
RUN echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.zshrc
