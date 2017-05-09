#!/bin/sh
cmake -DSTM32_CHIP=STM32L476RG \
    -DCMAKE_TOOLCHAIN_FILE=$STM32_CMAKE_HOME/stm32-cmake/cmake/gcc_stm32.cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DSTM32Cube_DIR=$STM32CUBE_HOME/STM32Cube_FW_L4_V1.7.0 \
    -DTOOLCHAIN_PREFIX=/usr/local/gcc-arm-none-eabi-6-2017-q1-update \
    .
