# Simple STM32 Template Project

Toolchain: arm-gcc, CLion, J-Link

## Download arm-gcc

Available at [GNU ARM Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)

The last version that is recognized by CLion 2017.1.1 is /usr/local/gcc-arm-none-eabi-5_4-2016q3/bin/arm-none-eabi-gdb. You will need this version if you want to use
CLion for GDB remote debugging. For any other steps you can download and use the current version.

## Download stm32-cmake project

Clone the _stm32-cmake_ project from GitHub: https://github.com/roamingthings/stm32-cmake

## Download STM32CubeL4

Download STM32CubeMX library for the L4 family from ST:
http://www.st.com/content/st_com/en/products/embedded-software/mcus-embedded-software/stm32-embedded-software/stm32cube-embedded-software/stm32cubel4.html
and unpack it on your system.

## Setup CLion

### Configure Toolchain

In CLion Preferences _Build, Execution, Deployment -> Toolchains_

**Custom GDB:** _Path to ARM gdb_ `/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin/arm-none-eabi-gdb` 

### Configure CMake

In CLion Preferences _Build, Execute, Deployment -> CMake_

**CMake options:** -DSTM32_CHIP=STM32L476RG -DCMAKE_TOOLCHAIN_FILE=_stm32-cmake_/cmake/gcc_stm32.cmake -DSTM32Cube_DIR=_STM32CubeL4_ -DTOOLCHAIN_PREFIX=/usr/local/gcc-arm-none-eabi-6-2017-q1-update 
**Environment:** _Empty_
**Generation path:** build

### Setup GDB

_Edit Configurations_

Add a new _GDB Remote Debug_ configuration

**'target remote' args:** _tcp:localhost:2331_  
**Symbol file:** _<PATH-TO-PROJECT>/build/blinky476.elf_

### Setup external tools

In CLion Preferences _Tools -> External Tools_

Flash target

**Program:** _`/usr/local/gcc-arm-none-eabi/bin/arm-none-eabi-gdb`_  
**Parameters:** _`-x conf/gdb_load --batch`_  
**Working Directory:** _`$ProjectFileDir$`_  

Start J-Link GDB Server

**Program:** _`/Applications/SEGGER/JLink_V614b/JLinkGDBServer`_  
**Parameters:** _`-device STM32L476RG -speed 1000 -if SWD`_  
**Working Directory:** _`$ProjectFileDir$`_  

## Wire J-Link to Nucleo / ST-Link

| J-Link | Signal | Nucleo CN4 | Signal     |
|--------|--------|------------|------------|
| 1	     | VTref  | 1          | VDD_Target |
| 4      | GND    | 3          | GND        |
| 7      | TMS    | 4          | SWDIO      |
| 9      | TCK    | 2          | SWCKL      |
| 13     | TDO    | 6          | SWO        |
| 15     | Reset  | 5          | NRST       |

VDD_Target also has to be connected to `3V3` on pin 4 of CN6.