# JetsonTX1
This Readme is intended as a guide for the setup of a Jetson TX1 immediately following a flash via the NVIDIA provided JetPack install tool for the purposes of deploying the dependencies of the MBZIRC project. The directions/customizations for the flashing process are not covered here. This guide assumes that there is an SSD formatted in ext4 attached to the SATA port on-board the Jetson under */dev/sda1*. To confirm this, run *lsblk* in a terminal and the drive should be listed as sda1.

To format the SSD, simply connect it to the SATA port, download the gparted tool, run *sudo gparted* from terminal, a gui should open, then follow the menus and prompts to format the drive into ext4. It is pretty straightforward. 

# Clean Up the Jetson
During the flashing process, for some reason the aptitude sources list gets configured multiple times. In order to fix this run the *Cleanupdeb11.py* script provided in the following manner

    sudo python3 Cleanupdeb11.py

There are a number of pieces of software installed during the flashing process that are extraneous and should be removed as space on the eMMC storage is limited. In particular, the unity scope related peripherals and libreoffice components are useless to the project. To remove them run the script *cleanupextras.sh* 

    ./cleanupextras.sh

This should remove all of the useless software and free up space.

# OpenCV 3.1.0 Compile Bugs Solutions 
If cmake can't find cuda libraries, in */mnt/opencv-3.1.0/modules/cudalegacy/src/graphcuts.cpp* add the following to the first line below includes (should be obvious where to put it)

    || (CUDART_VERSION >= 8000) 

If error with xfeatures2d not being found during make, export the following:

    export xfeatures2d=/mnt/opencv_contrib-3.1.0/modules

If HDF5 not found by cmake in */mnt/opencv-3.1.0/modules/python/common.cmake*, append the following to the bottom of the file:

    find_package(HDF5)
 
    include_directories(${HDF5_INCLUDE_DIRS})


If error with undefined character before '<' (or something like that) during make in regards to onlineMIL, move the following from *onlineMIL.hpp* to *onlineMIL.cpp*   

    #define  sign(s)  ((s > 0 ) ? 1 : ((s<0) ? -1 : 0))

If compile still fails with similar error as above while building onlineMIL, put the following in *onlineMIL.hpp* 

    #define CV_SIGN(s)  (((s) > 0) ? 1 : (((s)<0) ? -1 : 0)) 


