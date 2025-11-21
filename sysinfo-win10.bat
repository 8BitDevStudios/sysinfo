@echo off
title System Info
cls

echo ==== CPU ====
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed

echo ==== GPU ====
wmic path win32_VideoController get Name,DriverVersion,AdapterRAM

echo ==== RAM ====
wmic memorychip get Capacity,Speed,Manufacturer,PartNumber,DeviceLocator
wmic computersystem get TotalPhysicalMemory
wmic OS get FreePhysicalMemory
wmic memphysical get MaxCapacity,MemoryDevices

echo ==== MOTHERBOARD ====
wmic baseboard get Manufacturer,Product,SerialNumber

echo ==== BIOS ====
wmic bios get Manufacturer,SMBIOSBIOSVersion,ReleaseDate

echo ==== STORAGE ====
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace

echo ==== OS ====
wmic os get Caption,Version,OSArchitecture,BuildNumber

echo ==== NETWORK ====
ipconfig /all

echo ==== PROCESS COUNT ====
tasklist | find /c "."

pause
