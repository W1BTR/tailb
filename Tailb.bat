@echo off
if "%~1"=="" exit /b 1
if not exist "%~1" exit /b 2
if "%~1"=="clean" (
    del /f /q "%temp%\*.compare"
    echo Cleaned up temporary compare files.
    exit /b 0
)
set file=%~1
:finduid
set uid=%random%%random%%random%%random%%random%%random%%random%
if exist "%temp%\%uid%.compare" goto finduid
call :Display
copy /y "%file%" "%temp%\%uid%.compare" >nul 2>nul
:Monitor
comp /M "%file%" "%temp%\%uid%.compare" >nul 2>nul
if %errorlevel%==1 (
    call :Display
    copy /y "%file%" "%temp%\%uid%.compare" >nul 2>nul
    goto monitor
)
choice /c QR /t 2 /d R >nul
if %errorlevel%==1 (
    del /f /q "%temp%\%uid%.compare"
    exit /b
)
goto monitor



:Display
cls
type "%file%""
exit /b