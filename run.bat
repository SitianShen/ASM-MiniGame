@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%;%cd%\global
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%


nmake clean

<<<<<<< HEAD
nmake main
=======
nmake main && main.exe
>>>>>>> db40e4ee2ac8105326c0b693e763c975a601fda2
@REM nmake ldf_dev && ldf_dev.exe
@REM nmake sst_dev && sst_dev.exe
@REM nmake zzl_dev && zzl_dev.exe
@REM nmake lja_dev && lja_dev.exe



