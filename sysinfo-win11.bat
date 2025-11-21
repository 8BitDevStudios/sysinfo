@echo off
title System Info
cls

echo ==== CPU ====
powershell -command "Get-CimInstance Win32_Processor | ft Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed"

echo ==== GPU ====
powershell -command "Get-CimInstance Win32_VideoController | ft Name,DriverVersion,AdapterRAM"

echo ==== RAM ====
powershell -command "Get-CimInstance Win32_PhysicalMemory | ft Capacity,Speed,Manufacturer,PartNumber,DeviceLocator"
powershell -command "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory"
powershell -command "(Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory"
powershell -command "Get-CimInstance Win32_PhysicalMemoryArray | ft MaxCapacity,MemoryDevices"

echo ==== MOTHERBOARD ====
powershell -command "Get-CimInstance Win32_BaseBoard | ft Manufacturer,Product,SerialNumber"

echo ==== BIOS ====
powershell -command "Get-CimInstance Win32_BIOS | ft Manufacturer,SMBIOSBIOSVersion,ReleaseDate"

echo ==== STORAGE ====
powershell -command "Get-CimInstance Win32_LogicalDisk | ft DeviceID,VolumeName,Size,FreeSpace"

echo ==== OS ====
powershell -command "Get-CimInstance Win32_OperatingSystem | ft Caption,Version,OSArchitecture,BuildNumber"

echo ==== NETWORK ====
ipconfig /all

echo ==== PROCESS COUNT ====
tasklist | find /c "."

pause
