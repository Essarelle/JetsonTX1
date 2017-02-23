#!/bin/bash
# THIS ASSUMES YOUR .bashrc IS SETUP ACCORDINGLY
# Clone repo (manually enter github creds)
cd ~
git clone https://github.com/cmsvt/cmsvt_mbzirc.git

# Build sitl models
cd cmsvt_mbzirc/
#cd scripts/
#./build_sitl_gazebo.sh
#cd ..

# Dependency management
wstool merge -t src cmsvt_mbzirc.rosinstall
wstool update -t src

# Build swift nav dependencies
cd src/libsbp/
git checkout tags/v0.52.4
cd c
mkdir build && cd build
cmake ..
make
sudo make install

# Catkin Build project
cd ~/cmsvt_mbzirc
#catkin config --blacklist mbzirc_gazebo
catkin build -c

# Generate Hexacopter Models (only needed for sim)
#./scripts/generate_hexacopter_models.sh

