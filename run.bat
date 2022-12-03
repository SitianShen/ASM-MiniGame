@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
nmake clean
<<<<<<< HEAD
=======
@REM nmake ldf_dev
@REM nmake main_dev
>>>>>>> 977e3333c03cba73d62b684ebc75ffc4560e14a8
nmake

