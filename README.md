# sysinfo - System Info Tool

Batch based hardware and system information scripts for Windows.  
Includes two versions for Windows 10 and Windows 11.

## Features

- Collects detailed hardware and system information
- CPU, GPU, RAM (size, speed, slots), motherboard, BIOS
- Storage devices and free space
- Operating system details
- Network configuration
- Process count
- No external dependencies

## Versions

### sysinfo-win10.bat
Uses WMIC, which is included on Windows 10 by default.

### sysinfo-win11.bat
Uses PowerShell CIM commands because WMIC was removed from Windows 11.

## Installation

```bash
git clone https://github.com/8BitDevStudios/sysinfo
cd sysinfo
