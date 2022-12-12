@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%;%cd%\global
set lib=%Masm32Dir%\lib;%lib%;
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
@REM 不能递归

set Win10Kits=C:\Program Files (x86)\Windows Kits\10
set include=%Win10Kits%\Include;%include%
set lib=%Win10Kits%\Lib;%lib%
set path=%Win10Kits%\bin;%Win10Kits%;%PATH%

@REM for /f "delims=" %%i in ('dir /ad/b/s "%Win10Kits%"') do (
@REM     echo %%i
@REM )



@REM @echo off
@REM for /d %%i in (c:\*) do echo %%i
@REM pause


@REM FOR /D %Win10Kits%\Lib %%i in (*) do (
@REM     set include=%include%;%%i
@REM )

@REM FOR /D %Win10Kits%\Lib %%i in (*) do (
@REM     set include=%include%;%%i
@REM )

set MSVC=D:\Community\VC\Tools\MSVC\14.16.27023
set include=%MSVC%\include;%include%;
set lib=%MSVC%\Lib;%lib%
set path=%MSVC%\bin;%MSVC%;%PATH%

@REM FOR /D %MSVC%\Include %%i in (*) do (
@REM     set include=%include%;%%i
@REM )

@REM FOR /D %MSVC%\Lib %%i in (*) do (
@REM     set include=%include%;%%i
@REM )

@REM FOR /D %MSVC%\Lib %%i in (*) do (
@REM     set include=%include%;%%i
@REM )

nmake clean
@REM nmake main
@REM cl.exe /c ldf_gif.cpp
@REM Link /subsystem:console ldf_gif.obj
@REM nmake ldf_dev && ldf_dev.exe
@REM nmake sst_dev && sst_dev.exe
@REM nmake zzl_dev && zzl_dev.exe
@REM nmake lja_dev && lja_dev.exe



