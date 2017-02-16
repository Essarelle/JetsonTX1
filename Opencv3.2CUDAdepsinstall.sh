#!/bin/bash
# NVIDIA Jetson TX1
# Install opencv 3.2 dependencies with cuda support, opengl support as well as various others
cd ~
# build tools and basic dependencies
sudo apt-get install build-essential flex bison autotools-dev automake liborc-dev autopoint libtool
sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libavresample-dev
sudo apt-get install autotrace curl enscript libav-tools gimp gnuplot grads devhelp nasm libxine2-dev libxine2 libavutil-dev libjasper-dev libeigen3-dev

# GStreamer libraries 
sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-0 libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-ugly gstreamer1.0-plugins-good

# python dependencies
sudo apt-get install python2.7-dev python3-dev libpython3.5-dev
sudo apt-get install python-dev python-numpy python-scipy python-appdirs python-mako python-markupsafe python-pytools python3-appdirs python3-pytools
sudo apt-get install  python3-pil python3-matplotlib python3-numpy python-matplotlib python-skimage python-pip python-sklearn
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Protocol Buffer libraries
sudo apt-get install python-protobuf protobuf-compiler protobuf-c-compiler libprotobuf-dev libprotoc-dev

# OpenGL amd glog libraries
sudo apt-get install libgtkglext1 libgtkglext1-dev
sudo apt-get install qtbase5-dev libgoogle-glog-dev

# Video4Linux libraries
sudo apt-get install libv4l-dev v4l-utils qv4l2 v4l2ucp

# gphoto and neon libraries
sudo apt-get install libgphoto2-dev libavcodec-extra libneon27 libneon27-dev libopenexr-dev

# hdf5 libraries
sudo apt-get install libjhdf5-java libjhdf5-jni libhdf5-cpp-11 libhdf5-dev hdf5-tools h5utils hdf5-helpers

# miscellaneous dependencies libraries
sudo apt-get install libitpp-dev libfann-dev libfann-doc libgeotiff-epsg  python-genshi gpsd libdlna-dev libatlas-base-dev
sudo apt-get install libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

# download and unzip opencv & opencv_contrib
cd $HOME
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
