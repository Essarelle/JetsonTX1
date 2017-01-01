# JetsonTX1

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

If compile still fails with similar error while building onlineMIL, put the following in *onlineMIL.hpp* 

    #define CV_SIGN(s)  (((s) > 0) ? 1 : (((s)<0) ? -1 : 0)) 


