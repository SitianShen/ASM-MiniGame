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
        DC      dd      ?  ;?????????
        rel_v   dd      ?  ;???????????????
BASE ends

Subject struct 
        base    BASE  <> 
        course_id       dd      ? ;0,1,2
        score           dd      ?
Subject ends

MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 ;?????????
PROP_DEC_SELF           equ 2001 ;?????????
OBST_HARD               equ 3000 ;????
OBST_SOFT               equ 3001 ;?????
Targets struct
        base    BASE  <> 
        typeid  dd      ?
Targets ends

.data?
player          Subject <>              ;????
bullet          Subject <>              ;???
env_objecet_1   BASE    <>              ;???????????? 1
env_objecet_2   BASE    <>              ;???????????? 2
env_objecet_3   BASE    <>              ;???????????? 3
targets         Targets  1000 dup(<>)   ;????

;zzl own
game_start              BASE <>
game_intro              BASE <>
game_start_chosen       BASE <>
game_intro_chosen       BASE <>
.data
choose_start            equ 1 
choose_intro            equ 2 
choose_which_char            dd  0

in_begining             equ 0
in_game                 equ 1
cur_interface           dd  0

;sst
carx0                   equ     150;坐标数字待定
carx1                   equ     300
carx2                   equ     450
cary                    equ     500
cary_jump               equ     450

.data
flag_jump               dd      0
time_jump               dd      5

.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;??????????targets???鳤???

.data
base_speed      dd      2 ;?????? ??λ?????

;when you store something-> offset targets + (id%MAX_TARGET_NUMBER) ???????




; ########################################################## try code
ID_TIMER        equ     1
IDB_BACKG       equ     100
IDB_OBJ1        equ     101
IDB_OBJ2        equ     102
IDB_OBJ3        equ     103
IDB_ICON        equ     200
IDB_GAMESTART   equ     301
IDB_GAMEINTRO   equ     302
IDB_GAMESTARTC  equ     303
IDB_GAMEINTROC  equ     304


gameH           equ     548
gameW           equ     650
charH           equ     400
charW           equ     400
object1H_init   equ     400
object1W_init   equ     600
object1H_begin  equ     57
object1W_begin  equ     86
object1H_end    equ     57*3
object1W_end    equ     86*3

.data


object1H         dd     57
object1W         dd     86
object_move_v    dd     2


.data?
hInstance       dd      ?
hWinMain        dd      ?
; hCursorMain     dd      ?
; hCursorMove     dd      ?
; hMenu           dd      ?
; hBmpBack        dd      ?
; hBmpClock       dd      ?
; ????????汳??
hDCBack         dd      ?
; ????????????
hDCGame         dd      ?
; ??????1
hDCObj1         dd      ?
; ??????????????????
; hDCClock        dd      ?

dwNowBack       dd      ?
; dwNowObj1       dd      ?
; dwNowCircle     dd      ?

.const
szClassName     db      'run away from covid-19', 0
; _dwPara180      dw      180
; dwRadius        dw      100/2
; szMenuBack1     db      '??????1(&A)', 0
; szMenuBack2     db      '??????2(&B)', 0
; szMenuCircle1   db      '?????1(&C)', 0
; szMenuCircle2   db      '?????2(&D)', 0
; szMenuExit      db      '???(&X)', 0
debug_int       db      '%d', 0ah, 0
szInt db "%d", 0ah, 0
; ########################################################## try code

.code
;小车的初始化
_Init_car proc uses ebx
    mov ebx, 2
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
        .if (ebx == 1)
                ret
        .elseif (ebx==2)
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
        .if (ebx == 3)
               ret
        .elseif (ebx==2)
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
; start:
;         invoke  _sst_test
;         ret
; end start
end