# JetsonTX1
This Readme is intended as a guide for the setup of a Jetson TX1 immediately following a flash via the NVIDIA provided JetPack install tool for the purposes of deploying the dependencies of the MBZIRC project. The directions/customizations for the flashing process are not covered here. This guide assumes that there is an SSD formatted in ext4 attached to the SATA port on-board the Jetson under */dev/sda1*. To confirm this, run *lsblk* in a terminal and the drive should be listed as sda1.

To format the SSD, simply connect it to the SATA port, download the gparted tool, run *sudo gparted* from terminal, a gui should open, then follow the menus and prompts to format the drive into ext4. It is pretty straightforward. 

In order to make the scripts useable run *chmod +x scriptname.sh*

# Clean Up the Jetson
During the flashing process, for some reason the aptitude sources list gets configured multiple times. In order to fix this run the *Cleanupdeb11.py* script provided in the following manner

    sudo python3 Cleanupdeb11.py

There are a number of pieces of software installed during the flashing process that are extraneous and should be removed as space on the eMMC storage is limited. In particular, the unity scope related peripherals and libreoffice components are useless to the project. To remove them run the script *cleanupextras.sh* via terminal

    ./cleanupextras.sh

This should remove all of the useless software and free up space.

# Mount SSD and Create Swapfile
The onboard storage and memory shipped with the development board are not adequate to build OpenCV 3.1.0 compiled against CUDA, so it is necessary to add additional storage and create a swapfile (hence the attached SSD). To do so, first mount the SSD in the following manner via terminal

    sudo mount -t ext4 /dev/sda1 /mnt

This mounts the */dev/sda1* drive to mountpoint */mnt*. 
Now create the swapfile using the script *createSwap.sh* provided in this repo via terminal as follows

    sudo ./createSwapfile.sh -d /mnt -s 8 -a

This creates a swapfile of size 8 GB and sets */etc/fstab* to automount the drive. 8 GB is twice the onboard memory and is more than adequate for the purposes of the project as a whole, however if one feels it necessary to increase the size, simply change the number following the -s flag, in the above case 8, to reflect your desire. To double check that the script properly created the swapfile, either open the gui based system monitor provided on the system and navigate to the Resources tab (should be listed as swap with a green circle that says 8 GB) or run

    swapon -s

# Build OpenCV 3.1.0 against CUDA
Now, for building OpenCV. First, run the script provided in the repo *Opencv3.1.0CUDAdepsinstall.sh* to download and install library dependencies as well as get/unzip the source code.

    ./Opencv3.1.0CUDAdepsinstall.sh

Due to space limitations in the eMMC storage, it is necessary to build OpenCV in the mounted drive. So move the unzipped OpenCV and OpenCV Contrib folders to */mnt* (Note: assumes location in the ~ directory)

    sudo mv opencv-3.1.0 /mnt

    sudo mv opencv_contrib-3.1.0 /mnt

Navigate to the main OpenCV folder 

    cd /mnt/opencv-3.1.0
    
Make the build directory and Navigate to it

    mkdir build && cd build
    
Run the *cmake* configuration

    cmake -DCMAKE_DEBUG_POSTFIX=d -DCMAKE_CXX_FLAGS_RELEASE="-fno-omit-frame-pointer -O3 -DNDEBUG -g" -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_CUDA=ON -DCUDA_ARCH_BIN="5.3" -DCUDA_ARCH_PTX="" -DENABLE_FAST_MATH=1 -DCUDA_FAST_MATH=1 -DWITH_CUBLAS=1 -DENABLE_NEON=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DOPENCV_EXTRA_MODULES_PATH=/mnt/opencv_contrib-3.1.0/modules -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_TBB=ON -DWITH_V4L=ON ..

Then *make* and install it

    make -j4 && sudo make install

See below for help with compile errors

# OpenCV 3.1.0 Compile Bugs Solutions 
If *make* can't find the CUDA libraries while building graphcuts, in */mnt/opencv-3.1.0/modules/cudalegacy/src/graphcuts.cpp* add the following to the first line below includes (should be obvious where to put it)

    || (CUDART_VERSION >= 8000) 

If error with xfeatures2d not being found during make, export the following:

    export xfeatures2d=/mnt/opencv_contrib-3.1.0/modules

If HDF5 not found by *cmake* in */mnt/opencv-3.1.0/modules/python/common.cmake*, append the following to the bottom of the file:

    find_package(HDF5)
 
    include_directories(${HDF5_INCLUDE_DIRS})


If error with undefined character before '<' (or something like that) during make in regards to onlineMIL, move the following from *onlineMIL.hpp* to *onlineMIL.cpp*   

    #define  sign(s)  ((s > 0 ) ? 1 : ((s<0) ? -1 : 0))

If compile still fails with similar error as above while building onlineMIL, put the following in *onlineMIL.hpp* 

    #define CV_SIGN(s)  (((s) > 0) ? 1 : (((s)<0) ? -1 : 0)) 

_Note: If errors occur during configuration (cmake step), it is necessary to delete the CMakeCache.txt file using rm -rf before rerunning cmake_ 

# Install ROS Kinetic Libraries
To install the MBZIRC-specific ROS packages and dependencies, run the *ROS-Kinetic.sh* script provided in the repo.

    ./ROS-Kinetic.sh

This concludes the guide, for questions contact EssarelleATnymDOThushDOTcom 
