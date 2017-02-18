# JetsonTX1
This Readme is intended as a guide for the setup of a Jetson TX1 immediately following a flash via the NVIDIA provided JetPack install tool for the purposes of deploying the dependencies of the MBZIRC project. The directions/customizations for the flashing process are not covered here. This guide assumes that there is an SSD partitioned into three separate parts formatted in ext4 attached to the SATA port on-board the Jetson under */dev/sda1*, */dev/sda2*, and */dev/sda1* respectively. These will be for the /home, /usr, and /opt dirs. To confirm this, run *lsblk* in a terminal and the drive should be listed.

To format the SSD, simply connect it to the SATA port, download the gparted tool, run *sudo gparted* from terminal, a gui should open, then follow the menus and prompts to format the drive into ext4. It is pretty straightforward. 

In order to make the scripts useable run *chmod +x scriptname.sh*

# Clean Up the Jetson
During the flashing process, for some reason the aptitude sources list gets configured multiple times. In order to fix this run the *Cleanupdeb11.py* script provided in the following manner

    sudo python3 Cleanupdeb11.py

There are a number of pieces of software installed during the flashing process that are extraneous and should be removed. In particular, the unity scope related peripherals and libreoffice components are useless to the project. To remove them run the script *cleanupextras.sh* via terminal

    ./cleanupextras.sh

This should remove all of the useless software and free up space.

# Create Swapfile 
Now create the swapfile using the script *createSwap.sh* provided in this repo via terminal as follows

    sudo ./createSwapfile.sh -d /home -s 8 -a

This creates a swapfile of size 8 GB and sets */etc/fstab* to automount the drive. 8 GB is twice the onboard memory and is more than adequate for the purposes of the project as a whole, however if one feels it necessary to increase the size, simply change the number following the -s flag, in the above case 8, to reflect your desire. To double check that the script properly created the swapfile, either open the gui based system monitor provided on the system and navigate to the Resources tab (should be listed as swap with a green circle that says 8 GB) or run

    swapon -s

# Build OpenCV 3.2 against CUDA
Now, for building OpenCV. First, run the script provided in the repo *Opencv3.2CUDAdepsinstall.sh* to download and install library dependencies as well as get/unzip the source code.

    ./Opencv3.2CUDAdepsinstall.sh

Navigate to the main OpenCV folder 

    cd ~/opencv
    
Make the build directory and Navigate to it

    mkdir build && cd build
    
Run the *cmake* configuration

    cmake -DCMAKE_DEBUG_POSTFIX=d -DCMAKE_CXX_FLAGS_RELEASE="-fno-omit-frame-pointer -O3 -DNDEBUG -g" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_CUDA=ON -DCUDA_ARCH_BIN="5.3" -DCUDA_ARCH_PTX="" -DENABLE_FAST_MATH=1 -DCUDA_FAST_MATH=1 -DWITH_CUBLAS=1 -DENABLE_NEON=OFF -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DOPENCV_EXTRA_MODULES_PATH=$HOME/opencv_contrib/modules -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_TBB=ON -DWITH_V4L=ON ..

Then *make* and install it

    make -j4 && sudo make install

# Install ROS Kinetic Libraries
To install the MBZIRC-specific ROS packages and dependencies, run the *ROS-Kinetic.sh* script provided in the repo.

    ./ROS-Kinetic.sh

# Fix USB Autosuspend and add udev rules 
Run the script *fixautosuspend.sh* to fix autosuspend rule


    ./fixautosuspend.sh

Then add the udev rules via the *createudevrules.sh* script

    ./createudevrules.sh

# Configure Environment & Build Project

Add this to your .bashrc file. **Note MBZIRC_DIR should be set to where you have the MBZIRC workspace.**

    export MBZIRC_DIR="${HOME}/cmsvt_mbzirc"
    export SITL_GAZEBO_PATH="${MBZIRC_DIR}/src/sitl_gazebo"

    source /opt/ros/kinetic/setup.bash
    source /usr/share/gazebo-7/setup.sh
    ROS_PACKAGE_PATH=~/cmsvt_mbzirc:$ROS_PACKAGE_PATH
    source "${MBZIRC_DIR}/devel/setup.bash"

    if [[ $GAZEBO_RESOURCE_PATH != *"${SITL_GAZEBO_PATH}"* ]]
    then
      export GAZEBO_RESOURCE_PATH="${SITL_GAZEBO_PATH}:${GAZEBO_RESOURCE_PATH}"
    fi
    if [[ $GAZEBO_PLUGIN_PATH != *"${SITL_GAZEBO_PATH}/build"* ]]
    then
      export GAZEBO_PLUGIN_PATH="${SITL_GAZEBO_PATH}/build:${GAZEBO_PLUGIN_PATH}"
    fi
    if [[ $GAZEBO_MODEL_PATH != *"${SITL_GAZEBO_PATH}/models"* ]]
    then
      export GAZEBO_MODEL_PATH="${SITL_GAZEBO_PATH}/models:${GAZEBO_MODEL_PATH}"
    fi

Navigate to your development directory, then download and deploy the MBZIRC project via the *MBZIRCsetup.sh* script

    ./MBZIRCsetup.sh

# Check On Board Camera with GStreamer Pipeline
To check if the on board camera is working run the following

    gst-launch-1.0 nvcamerasrc fpsRange="30.0 30.0" ! 'video/x-raw(memory:NVMM), width=(int)1920, height=(int)1080, format=(string)I420, framerate=(fraction)30/1' ! nvtee ! nvvidconv flip-method=2 ! 'video/x-raw(memory:NVMM), format=(string)I420' ! nvoverlaysink -e

This concludes the guide, for questions contact EssarelleATnymDOThushDOTcom 
