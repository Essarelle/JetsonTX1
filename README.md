# JetsonTX1

# Compile Bugs Solutions 
in /mnt/opencv-3.1.0/modules/cudalegacy/src/graphcuts.cpp add || (CUDART_VERSION >= 8000) to the first line below includes

if error with xfeatures2d:

    export xfeatures2d=/path/to/opencv_contrib/modules/

in /mnt/opencv-3.1.0/modules/python/common.cmake append:

    find_package(HDF5)
 
    include_directories(${HDF5_INCLUDE_DIRS})

to bottom

move  #define  sign(s)  ((s > 0 ) ? 1 : ((s<0) ? -1 : 0)) from onlineMIL.hpp to onlineMIL.cpp

if compile still fails: place #define CV_SIGN(s)  (((s) > 0) ? 1 : (((s)<0) ? -1 : 0)) in onlineMIL.hpp
