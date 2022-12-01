.386
.model flat, stdcall
option casemap: none

include         windows.inc
include         gdi32.inc
include         user32.inc
include         kernel32.inc
include         Msimg32.inc
includelib      gdi32.lib
includelib      user32.lib
includelib      kernel32.lib
includelib      Msimg32.lib

includelib msvcrt.lib
include msvcrt.inc
scanf proto c:dword,:vararg
printf proto c:dword,:vararg

BASE struct
        posx    dd      ?
        posy    dd      ?
        lengthx dd      ?
        lengthy dd      ?
        alive   dd      ?
        DC      dd      ?  ;物体图片句柄
        rel_v   dd      ?  ;相对移动速度（倍率）
BASE ends


Subject struct 
        base    BASE  <> 
        course_id       dd      ? ;0,1,2
        score   dd      ?
Subject ends

.data?
player          Subject <>              ;人物

carx0           equ     150
carx1           equ     300
carx2           equ     450
cary            equ     500
cary_jump       equ     450

.data
flag_jump       dd      0
time_jump       dd      5

szInt       db      '%d', 0ah, 0

.code
;小车的初始化
_Init_car proc uses ebx
    mov ebx, 1
    mov player.course_id, ebx
    mov player.base.alive, ebx
    xor ebx, ebx
    mov player.base.rel_v, ebx
    mov player.score, ebx
    mov eax, carx1
    mov player.base.posx, eax
    mov ebx, cary
    mov player.base.posy, ebx
    ret
;句柄初始化成什么？
_Init_car endp

;每一帧刷新都要调用一次_Jump_maintain
_Jump_maintain proc uses ebx
        mov eax, flag_jump
        .if (eax == 1)
                .if (time_jump == 0)
                        mov ebx, 5
                        mov time_jump, ebx
                        xor ebx, ebx
                        mov flag_jump, ebx

                        mov eax, cary
                        mov player.base.posy, eax
                        ret
                .endif
                mov ebx, time_jump
                dec ebx
                mov time_jump, ebx
        .endif
        ret
_Jump_maintain endp

;左移
_Action_left proc uses ebx
        mov     ebx, player.course_id
        .if (ebx == 0)
                ret
        .elseif (ebx==1)
                mov eax, carx0
                mov player.base.posx, eax
        .else
                mov eax, carx1
                mov player.base.posx, eax
        .endif
        ret
_Action_left endp

;右移
_Action_right proc uses ebx
        mov     ebx, player.course_id
        .if (ebx == 2)
               ret
        .elseif (ebx==1)
               mov eax, carx2
               mov player.base.posx, eax
        .else
               mov eax, carx1
               mov player.base.posx, eax
        .endif
        ret
_Action_right endp

;跳跃
_Action_jump proc uses ebx
        mov     ebx, 1
        mov     flag_jump, ebx
        mov     eax, cary_jump
        mov     player.base.posy, eax
        ret
_Action_jump endp

_sst_test proc
        invoke _Init_car
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy

        invoke _Action_jump
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy

        mov esi, 10
        .while( esi > 0)
                invoke _Jump_maintain
                invoke printf, offset szInt, player.base.posx
                invoke printf, offset szInt, player.base.posy
                dec esi
        .endw

        invoke _Action_left
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy

        invoke _Action_right
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy
        ret
_sst_test endp

;test
start:
        invoke  _sst_test
        ret
end start