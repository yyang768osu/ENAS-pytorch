FROM nvidia/cuda:9.1-cudnn7-devel

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN apt-get update && \
    apt-get install -y git wget && \
    apt-get clean

RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-4.5.11-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.5.11-Linux-x86_64.sh

ARG python_version=3.7

RUN conda install -y python=${python_version} && \
    conda install -y pytorch caffe python-lmdb torchvision tqdm scipy imageio pygraphviz && \
    conda clean -yt

RUN pip --no-cache-dir install --upgrade pip && \
    pip install tensorboardX



