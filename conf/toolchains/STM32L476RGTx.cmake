set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
# On macOS you have to set CMAKE_FIND_ROOT_PATH in order to find the gcc tools
set(CMAKE_FIND_ROOT_PATH "/usr/local/gcc-arm-none-eabi-6-2017-q1-update")

# specify the cross compiler
find_program(C_COMPILER arm-none-eabi-gcc)
if(NOT C_COMPILER)
    message(FATAL_ERROR "could not find arm-none-eabi-gcc compiler")
endif()
set(CMAKE_C_COMPILER ${C_COMPILER})
set(CMAKE_C_COMPILER_FORCED 1)

find_program(CXX_COMPILER arm-none-eabi-g++)
if(NOT CXX_COMPILER)
    message(FATAL_ERROR "could not find arm-none-eabi-g++ compiler")
endif()
set(CMAKE_CXX_COMPILER ${CXX_COMPILER})
set(CMAKE_CXX_COMPILER_FORCED 1)

#####
# optional compiler tools
foreach(tool gdb gdbtui)
    string(TOUPPER ${tool} TOOL)
    find_program(${TOOL} arm-none-eabi-${tool})
    if(NOT ${TOOL})
        message(STATUS "could not find ${tool}")
    endif()
endforeach()

set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/conf/STM32L476RGTx_FLASH.ld)

#Uncomment for software floating point
#set(COMMON_FLAGS "-mcpu=cortex-m4 -mthumb -mlittle-endian -mthumb-interwork -ggdb -Wall -Wextra -Warray-bounds -mfloat-abi=soft -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0")
set(COMMON_FLAGS "-mcpu=cortex-m4 -mthumb -mlittle-endian -mthumb-interwork -ggdb -Wall -Wextra -Warray-bounds -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0")
