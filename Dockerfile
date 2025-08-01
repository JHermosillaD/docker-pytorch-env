FROM pytorch/pytorch:2.7.1-cuda11.8-cudnn9-runtime
LABEL maintainer="Jesus Hermosilla <hermosilladiaz@gmail.com>"

# System packages
RUN apt-get update && apt-get install -y \
    git \
    udev \
    wget \
    htop \
    curl \
    gnupg \
    unzip \
    emacs \
    byobu \
    ffmpeg \
    libsm6 \
    libxss1 \
    libice6 \
    graphviz \
    libxext6 \
    libgomp1 \
    v4l-utils \
    libgtk-3-0 \
    libxrender1 \
    python3-pip \
    python3-dev \
    libglib2.0-0 \
    libfontconfig1 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Python requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Setup terminal
RUN echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> ~/.bashrc && \
    echo 'alias ls="ls --color=auto"' >> ~/.bashrc && \
    echo 'alias ll="ls -alF --color=auto"' >> ~/.bashrc && \
    echo 'alias grep="grep --color=auto"' >> ~/.bashrc

# Working directory
WORKDIR /workspace