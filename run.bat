@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%;%cd%\global;
set lib=%Masm32Dir%\lib;%lib%;
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%;


nmake clean
<<<<<<< HEAD
@REM nmake main && main.exe
=======
<<<<<<< HEAD
<<<<<<< HEAD
@REM nmake main
@REM nmake ldf_dev && ldf_dev.exe
=======
>>>>>>> f48b71083e3ff5877dc5fd7b1c7cf75ee878cf66
=======
@REM nmake main && main.exe
nmake ldf_dev && ldf_dev.exe
=======
>>>>>>> 3c95ebace92cc0e349cffaf5accc2d8fbdf77c7c
nmake main
>>>>>>> e448f98c3b7d552f7667eb345fc061ee4aaeb050
@REM nmake ldf_dev && ldf_dev.exe
nmake sst_dev && sst_dev.exe
@REM nmake zzl_dev && zzl_dev.exe
@REM nmake lja_dev && lja_dev.exe



