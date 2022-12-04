@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%;%cd%\global
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%


nmake clean
@REM nmake ldf_dev
@REM nmake sst_dev
@REM nmake zzl_dev
@REM nmake lja_dev

nmake main

