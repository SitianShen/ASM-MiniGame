@echo off

set Masm32Dir=D:\Masm32
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%

rc %1.rc
ml /c /coff %1.asm ldf.asm sst.asm lja.asm
Link /subsystem:console %1.obj %1.res ldf.obj sst.obj lja.obj
