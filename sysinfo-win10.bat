@echo off
title sysinfo
cls

where wmic >nul 2>&1
if %errorlevel%==0 (set use_wmic=1) else (set use_wmic=0)

if "%use_wmic%"=="1" (
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
) else (
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
)

echo ==== NETWORK ====
ipconfig /all

echo ==== PROCESS COUNT ====
tasklist | find /c "."

echo ==== POWER RATING ====

for /f "usebackq" %%a in (`powershell -command "(Get-CimInstance Win32_Processor).NumberOfLogicalProcessors"`) do set cpu_threads=%%a
for /f "usebackq" %%a in (`powershell -command "(Get-CimInstance Win32_Processor).MaxClockSpeed"`) do set cpu_clock=%%a
for /f "usebackq" %%a in (`powershell -command "[math]::Max(1,[math]::Floor((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB))"`) do set ram_gb=%%a
for /f "usebackq" %%a in (`powershell -command "[math]::Max(1,[math]::Floor(((Get-CimInstance Win32_VideoController | Select-Object -First 1).AdapterRAM) / 1GB))"`) do set vram_gb=%%a

set /a cpu_score=cpu_threads*2 + cpu_clock/1000
set /a ram_score=ram_gb
set /a vram_score=vram_gb*2
set /a total_score=cpu_score+ram_score+vram_score

if %total_score% gtr 40 set rating=10
if %total_score% leq 40 if %total_score% gtr 35 set rating=9
if %total_score% leq 35 if %total_score% gtr 30 set rating=8
if %total_score% leq 30 if %total_score% gtr 25 set rating=7
if %total_score% leq 25 if %total_score% gtr 20 set rating=6
if %total_score% leq 20 if %total_score% gtr 15 set rating=5
if %total_score% leq 15 if %total_score% gtr 10 set rating=4
if %total_score% leq 10 if %total_score% gtr 7 set rating=3
if %total_score% leq 7 if %total_score% gtr 4 set rating=2
if %total_score% leq 4 if %total_score% gtr 1 set rating=1
if %total_score% leq 1 set rating=0

echo CPU threads: %cpu_threads%
echo CPU clock: %cpu_clock% MHz
echo RAM: %ram_gb% GB
echo VRAM: %vram_gb% GB
echo Power Rating: %rating% / 10

echo.
echo Press any key to exit...
pause >nul
