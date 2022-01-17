# Emulating generic RISC-V 32bit machine on VexRiscv Briey SoC

## Requirements

1. GNU RISC-V toolchains (tested on Crosstool-NG)
2. Briey Simulator from [SpinalHDL/VexRiscv](https://github.com/SpinalHDL/VexRiscv)
3. Linux OS (tested on Ubuntu 20.04)


## How to build toolchain

Clone the Crosstool-NG and build.

```
$ git clone https://github.com/crosstool-ng/crosstool-ng
$ ./configure --enable-local
$ make

$ ./ct-ng menuconfig
```

Change the following configs:

```
CT_EXPERIMENTAL=y
CT_ARCH_RISCV=y
CT_ARCH_64=y
CT_ARCH_ARCH=rv32ima
CT_ARCH_ABI=ilp32
CT_MULTILIB=y
CT_DEBUG_GDB=y
```

Build the GNU toolchain for RISC-V.

```
$ ./ct-ng build
```

A toolchain is installed at ~/x-tools/riscv64-unknown-elf directory.


## How to build

Add path of toolchain that is described above section.

```
$ export PATH=~/x-tools/riscv64-unknown-elf:$PATH
```

For release build:

```
$ make
```

For debug build:

```
$ make DEBUG=1
```

If success to build, executable file RTOSDemo.axf in ./build directory.


## How to run

1. Run Briey Simulator
2. Enable OpenOCD for Vexriscv
3. Load the ELF file through GDB

## How to debug with gdb

```
$ riscv64-unknown-elf-gdb build/RTOSDemo.axf

(gdb) target remote localhost:1234
(gdb) break main
Breakpoint 1 at 0x80000110

(gdb) c
Continuing.

Breakpoint 1, 0x80000110 in main ()
```


## Description

This demo just prints Tx/Rx message of queue to serial port, use no
other hardware and use only primary core (currently hart 0).
Other cores are simply going to wfi state and execute nothing else.
