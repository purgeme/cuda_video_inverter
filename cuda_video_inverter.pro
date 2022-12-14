######################################################################
# Automatically generated by qmake (3.1) Sun Nov 6 16:47:02 2022
######################################################################

TEMPLATE = app
TARGET = cuda_video_inverter
INCLUDEPATH += .

DESTDIR=build/bin
OBJECTS_DIR=build
MOC_DIR=build

CUDA_DIR = /opt/cuda
INCLUDEPATH += $$CUDA_DIR/include
INCLUDEPATH += /usr/include/opencv4
CUDA_SOURCES += ./cuda_inverter.cu
CUDA_OBJECTS_DIR = $$OBJECTS_DIR
CUDA_LIBS = -lcudart -lcuda
CUDA_INC = $$join(INCLUDEPATH,'" -I"','-I"','"')
OPENCV_LIBS = -lopencv_core -lopencv_videoio -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs

OTHER_FILES += $$CUDA_SOURCES

QMAKE_LIBDIR += $$CUDA_DIR/lib
QMAKE_LIBDIR += $$CUDA_DIR/lib64
LIBS += $$OPENCV_LIBS
LIBS += $$CUDA_LIBS

cuda_d.input = CUDA_SOURCES
cuda_d.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.o
cuda_d.commands = $$CUDA_DIR/bin/nvcc $$NVCC_OPTIONS $$CUDA_INC -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
# cuda_d.commands = /usr/bin/nvcc $$NVCC_OPTIONS $$CUDA_INC -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
cuda_d.dependency_type = TYPE_C
QMAKE_EXTRA_COMPILERS += cuda_d

QT += widgets

# Input
HEADERS += mainwindow.h cuda.h
SOURCES += main.cpp mainwindow.cpp
