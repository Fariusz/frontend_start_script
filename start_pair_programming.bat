@echo off & title %~nx0 & color 9F


:::
::: _____ _____ _____  _   _ _____ ______  ___   _   _ _____       
:::/  __ \  _  |  __ \| \ | |_   _|___  / / _ \ | \ | |_   _|      
:::| /  \/ | | | |  \/|  \| | | |    / / / /_\ \|  \| | | |        
:::| |   | | | | | __ | . ` | | |   / /  |  _  || . ` | | |        
:::| \__/\ \_/ / |_\ \| |\  |_| |_./ /___| | | || |\  | | |        
::: \____/\___/ \____/\_| \_/\___/\_____/\_| |_/\_| \_/ \_/        
:::                                                                
:::                                                                
::: _____ _   _ ______  _____  ___  ____________ _____ _   _ _____ 
:::|  _  | \ | || ___ \|  _  |/ _ \ | ___ \  _  \_   _| \ | |  __ \
:::| | | |  \| || |_/ /| | | / /_\ \| |_/ / | | | | | |  \| | |  \/
:::| | | | . ` || ___ \| | | |  _  ||    /| | | | | | | . ` | | __ 
:::\ \_/ / |\  || |_/ /\ \_/ / | | || |\ \| |/ / _| |_| |\  | |_\ \
::: \___/\_| \_/\____/  \___/\_| |_/\_| \_|___/  \___/\_| \_/\____/
:::                                                                
:::                                                                
:::                                                                                                                        
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A

echo    Setuping pair-programming environment
echo.
echo.
echo [31m  IMPORTANT!
echo    DON'T USE MOUSE, KEYBOARD UNTIL THE SCRIPT ENDS
echo.
echo.   
echo    [30m
echo   PREREQUISITES
echo    1. Python
echo    2. Visual Studio Code
echo.   
echo.
echo   How it works:
echo    1. Checks for Python
echo    2. Checks for VSC
echo    3. Checks for Live Share
echo    4. Run VSC
echo    5. Run session server
echo    6. Adds servers and terminals
echo    7. Invite others using link in clipboard

timeout /NOBREAK 5
echo.
echo.

goto :DOES_PYTHON_EXIST

:DOES_PYTHON_EXIST
python -V | find /v "Python" >NUL 2>NUL && (goto :PYTHON_DOES_NOT_EXIST)
python -V | find "Python"    >NUL 2>NUL && (goto :PYTHON_DOES_EXIST)
goto :EOF

:PYTHON_DOES_NOT_EXIST
echo    Python is not installed on your system, closing...
goto :EOF

:PYTHON_DOES_EXIST
for /f "delims=" %%V in ('python -V') do @set ver=%%V
echo    %ver% is installed...
		
timeout /T 1 /NOBREAK > nul

goto :DOES_VSC_EXIST

:DOES_VSC_EXIST
code -v | find "recognized" >NUL 2>NUL && (goto :VSC_DOES_NOT_EXIST)
code -v | find "x64"    >NUL 2>NUL && (goto :VSC_DOES_EXIST)
goto :EOF

:VSC_DOES_NOT_EXIST
echo    VSC is not installed on your system, closing...
goto :EOF

:VSC_DOES_EXIST
echo    VSC is installed

timeout /T 1 /NOBREAK > nul

code --list-extensions | find /i "ms-vsliveshare.vsliveshare" >nul

set result=%errorlevel%

if %result% == 0 (
    echo    LiveShare is installed
) else (
    echo    LiveShare is not installed, installing...
    start "" code --install-extension ms-vsliveshare.vsliveshare
)

timeout /T 1 /NOBREAK > nul

start "" code .

timeout /T /NOBREAK > nul

pip freeze | find /i "pyautogui" >nul

set result=%errorlevel%

if %result% == 0 (
    echo    Pyautogui is installed
) else (
    echo    Pyautogui is not installed, installing...
    pip install pyautogui
)

timeout /T 1 /NOBREAK > nul

echo.
echo.
echo [31m   Running python script, don't touch mouse and keyboard now!

timeout /NOBREAK 45

py .\session_launcher_script.py