@echo off
REM This script will check if conda is already installed, and if not, download and install Miniconda, a mini version of Anaconda that includes only conda and its dependencies, and add it to the user path
REM You can change the installation directory, python version, and architecture as needed
set INSTALL_DIR="C:\Users\%USERNAME%\Miniconda3"

REM Check if conda is already installed
echo Checking if conda is already installed...
where conda >nul 2>nul
if %errorlevel% == 0 (
    echo Conda is already installed on this system. No need to install Miniconda.
	CALL conda-start.bat
    exit /b 0
)

REM Download the Miniconda installer from the official website
IF EXIST %~dp0\.cache\Miniconda3.exe (
	echo installer exists, skipping download
) else (
	echo Downloading Miniconda installer...
	bitsadmin /transfer "MinicondaDownload" /priority high https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe %~dp0\.cache\Miniconda3.exe
)
REM Run the installer in silent mode and specify the installation directory and the option to add conda to the user path
echo Installing Miniconda...
%~dp0\.cache\Miniconda3.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%INSTALL_DIR%

REM Delete the installer file
REM del %TEMP%\Miniconda3.exe

REM Check if conda is in the user path
echo Checking if conda is in the user path...
where conda >nul 2>nul
if %errorlevel% == 0 (
    echo Conda is successfully installed and added to the user path.
    CALL conda-start.bat
) else (
    echo Something went wrong. Please check the installation log or submit a ticket at: https://github.com/SayanoAI/RVC-Studio/issues
)