# Simple STM32 Template Project

Toolchain: arm-gcc, CLion, J-Link

## Download arm-gcc

Available at [GNU ARM Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)

The last version that is recognized by CLion 2016.3.5 is 5-2016-q3-update. You will need this version if you want to use
CLion for GDB remote debugging. For any other steps you can download and use the current version.

## Setup CLion

### Configure Toolchain

In CLion Preferences _Build, Execution, Deployment -> Toolchains_

**Custom GDB:** _Path to ARM gdb_ `/usr/local/gcc-arm-none-eabi-5_4-2016q3/bin/arm-none-eabi-gdb` 

### Configure CMake

In CLion Preferences _Build, Execute, Deployment -> CMake_

**CMake options:** -DCMAKE_TOOLCHAIN_FILE=conf/toolchains/STM32L476RGTx.cmake  
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

## Wire J-Link to Nucleo / ST-Linka\

| J-Link | Signal | Nucleo CN4 | Signal     |
|--------|--------|------------|------------|
| 1	     | VTref  | 1          | VDD_Target |
| 4      | GND    | 3          | GND        |
| 7      | TMS    | 4          | SWDIO      |
| 9      | TCK    | 2          | SWCKL      |
| 13     | TDO    | 6          | SWO        |
| 15     | Reset  | 5          | NRST       |

VDD_Target also has to be connected to `3V3` on pin 4 of CN6.