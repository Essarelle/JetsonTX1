#!/bin/bash
# Install Robot Operating System (ROS) on Ubuntu 16.04 Mate
# Information from:
# http://wiki.ros.org/kinetic/Installation/UbuntuXenial


# Setup Locale
sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
# Setup sources.lst
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Setup keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
# Installation
sudo apt-get update
sudo apt-get install ros-kinetic-ros-base -y
# Installation of MBZIRC-specific ros-kinetic-package
# You can additionally install a specific ROS package by adding a line like so:
# sudo apt-get install ros-kinetic-PACKAGE
sudo apt-get install ros-kinetic-navigation
sudo apt-get install python-pip python-scipy python-opencv python-matplotlib python-serial python-empy python-wxgtk3.0 python-lxml python-pexpect python-catkin-tools python3-pyside ccache gawk git libprotobuf-dev libprotoc-dev protobuf-compiler libeigen3-dev libgazebo7-dev qtcreator pyqt5-dev-tools python-qt5 ros-kinetic-mavros ros-kinetic-mavros-extras ros-kinetic-mavros-msgs ros-kinetic-octomap ros-kinetic-octomap-ros ros-kinetic-octomap-msgs ros-kinetic-octomap-rviz-plugins

pip install numpy scipy empy catkin_pkg rospkg defusedxml catkin_tools

# To find available packages:
# apt-cache search ros-kinetic
# 
# Initialize rosdep
sudo apt-get install python-rosdep -y
# ssl certificates can get messed up on TX1 for some reason
sudo c_rehash /etc/ssl/certs
# Initialize rosdep
sudo rosdep init
# To find available packages, use:
rosdep update
# Environment Setup
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
# Install rosinstall
sudo apt-get install python-rosinstall -y
