project(blinky476 C ASM)
cmake_minimum_required(VERSION 3.5.0)
set(CMAKE_VERBOSE_MAKEFILE on)

file(GLOB_RECURSE USER_SOURCES "Src/*.c")
file(GLOB_RECURSE HAL_SOURCES "Drivers/STM32L4xx_HAL_Driver/Src/*.c")

add_library(HAL ${HAL_SOURCES})
add_library(CMSIS
        Src/system_stm32l4xx.c
        startup/startup_stm32l476xx.s)

include_directories(Inc)
include_directories(Drivers/STM32L4xx_HAL_Driver/Inc)
include_directories(Drivers/CMSIS/Include)
include_directories(Drivers/CMSIS/Device/ST/STM32L4xx/Include)

add_definitions(-DSTM32L476xx)
add_definitions(-DSTM32L4XX)
add_definitions(-DUSE_STDPERIPH_DRIVER)

add_executable(${PROJECT_NAME}.elf ${USER_SOURCES} ${LINKER_SCRIPT})

target_link_libraries(${PROJECT_NAME}.elf HAL CMSIS)

SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -std=c++11")
SET(CMAKE_C_FLAGS "${COMMON_FLAGS} -std=gnu99")

if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DDEBUG -O0")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDEBUG -O0")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O1")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O1")
endif(CMAKE_BUILD_TYPE MATCHES Debug)

set(CMAKE_EXE_LINKER_FLAGS "-Wl,-gc-sections,-M=${PROJECT_NAME}.map -T${LINKER_SCRIPT}")

set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMAND ${GDB} -x \"${CMAKE_CURRENT_LIST_DIR}/conf/gdb_load\" --batch
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")