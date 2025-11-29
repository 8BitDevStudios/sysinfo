# sysinfo – System Info Tool

Batch based hardware and system information scripts for Windows.
Includes two versions for Windows 10 and Windows 11.

## Features

* Collects detailed hardware and system information
* CPU details (cores, threads, clock speed)
* GPU details (name, driver, VRAM)
* RAM details (capacity, speed, slots, manufacturer)
* Motherboard and BIOS information
* Storage devices and free space
* Operating system details
* Network configuration
* Process count
* Built-in PC Power Rating (0–10) for Windows 11
* Integer-accurate RAM and VRAM reporting
* No external dependencies

## System Info Breakdown

### CPU: NumberOfCores vs NumberOfLogicalProcessors

* NumberOfCores: Physical CPU cores.
* NumberOfLogicalProcessors: Threads (hyperthreading increases this number).

Example:
A 6-core CPU with hyperthreading will show 6 cores and 12 logical processors.

### RAM Reporting

Windows reports RAM in bytes. The script converts it to gigabytes.
If the system has very low RAM (for example, 128 MB), the script displays 1 GB so users do not see 0 GB.

### VRAM Reporting

Integrated GPUs often use shared system memory, so reported VRAM can appear low.
A minimum of 1 GB is shown to avoid confusing output.

### Power Rating System

The Windows 11 version calculates a simple performance score from CPU threads, CPU clock, RAM, and VRAM.
The result is mapped to a rating between 0 and 10.

Scoring logic:

* CPU score = (threads × 2) + (clock MHz ÷ 1000)
* RAM score = total RAM in GB (minimum 1)
* VRAM score = VRAM in GB × 2 (minimum 1)

## Versions

### sysinfo-win10.bat

Uses WMIC, which is available on Windows 10.

### sysinfo-win11.bat

Uses modern PowerShell CIM commands because WMIC was removed in Windows 11.
Includes the Power Rating and improved RAM/VRAM detection.

## Installation

```bash
git clone https://github.com/8BitDevStudios/sysinfo
cd sysinfo
```
