@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
nmake clean
@REM nmake ldf_dev
nmake main_dev
@REM nmake

