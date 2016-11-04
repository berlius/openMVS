FROM ubuntu:16.04

MAINTAINER berlius <berlius52@yahoo.com>


# Dependencies 

RUN apt-get update && apt-get install -y \
    git \
    mercurial \
    cmake \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libglu1-mesa-dev \
    libboost-iostreams-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-serialization-dev \
    libopencv-dev \
    libcgal-dev \
    libcgal-qt5-dev \
    libatlas-base-dev \
    libsuitesparse-dev 


# Eigen

RUN hg clone https://bitbucket.org/eigen/eigen#3.2
RUN mkdir eigen_build && cd eigen_build
RUN cmake . ../eigen
RUN make -j$(nproc)  && make install && cd ..


# Ceres

RUN git clone https://ceres-solver.googlesource.com/ceres-solver ceres-solver
RUN mkdir ceres_Build && cd ceres_Build
RUN cmake . ../ceres-solver/ -DMINIGLOG=ON -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF
RUN make -j$(nbproc) && make install && cd ..


# VCGLib 

git clone https://github.com/cdcseacave/VCG.git vcglib


# OpenMVS 

RUN git clone https://github.com/cdcseacave/openMVS.git openMVS
RUN mkdir openMVS_Build && cd openMVS_Build 
RUN cmake . ../openMVS -DCMAKE_BUILD_TYPE=RELEASE -DVCG_DIR="../vcglib" 
RUN make -j$(nproc)  && make install

WORKDIR "/root"
CMD ["/bin/bash"]

