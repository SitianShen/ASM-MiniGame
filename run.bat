@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%;%cd%\global;
set lib=%Masm32Dir%\lib;%lib%;
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%;


nmake clean
<<<<<<< HEAD
@REM nmake main
nmake ldf_dev && ldf_dev.exe
=======
nmake main
@REM nmake ldf_dev && ldf_dev.exe
>>>>>>> d2899d3bd86f2278953672d6b29824ea03b5ebf7
@REM nmake sst_dev && sst_dev.exe
@REM nmake zzl_dev && zzl_dev.exe
@REM nmake lja_dev && lja_dev.exe



