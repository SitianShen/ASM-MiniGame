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
        course_id       dd      ? ;0,1,2
BASE ends

Subject struct 
        base    BASE  <> 
        
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
carx0                   equ     150;�������ִ���
carx1                   equ     300
carx2                   equ     450
cary                    equ     500
cary_jump               equ     450

;ldf own
 

.data
flag_jump               dd      0
time_jump               dd      5

.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;??????????targets???�A???

.data
base_speed      dd      2 ;?????? ??��?????

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
; ????????�M??
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
; ########################################################## try code



.code

;3 check collision 每一帧调用
;两两枚举所有物体，令那些应该消失的消失：
;同时维护targets数组的数量target_number
;返回值为1代表碰撞
;返回值为0代表没有碰撞 
_check_collision proc uses ebx, @objectOne:BASE, @objectTwo:BASE
        local @objectOnePosX, @objectOnePosY
        local @objectOneLengthX, @objectOneLengthY
        
        local @objectTwoPosX, @objectTwoPosY
        local @objectTwoLengthX, @objectTwoLengthY

        local @objectOneCenterX, @objectTwoCenterY
        local @objectOneCenterY, @objectTwoCenterX

        local @distanceX, @distanceY
        
        local @criticalX, @criticalY

        mov eax, @objectOne.course_id
        .if @objectTwo.course_id != eax
                mov eax, 0
                ; invoke printf, offset szInt, @objectOne.course_id
                ; invoke printf, offset szInt, @objectTwo.course_id
                ret
        .endif

        ;objectOne
        mov eax, @objectOne.posx
        mov @objectOnePosX, eax

        mov eax, @objectOne.posy
        mov @objectOnePosY, eax
        
        mov eax, @objectOne.lengthx
        mov @objectOneLengthX, eax

        mov eax, @objectOne.lengthy
        mov @objectOneLengthY, eax

        ;objectTwo
        mov eax, @objectTwo.posx
        mov @objectTwoPosX, eax

        mov eax, @objectTwo.posy
        mov @objectTwoPosY, eax
        
        mov eax, @objectTwo.lengthx
        mov @objectTwoLengthX, eax

        mov eax, @objectTwo.lengthy
        mov @objectTwoLengthY, eax

        ;获取objectOne.中心X坐标
        mov eax, @objectOneLengthX
        shr eax, 1
        add eax, @objectOnePosX
        mov @objectOneCenterX, eax
        
        ;获取objectOne.中心Y坐标
        mov eax, @objectOneLengthY
        shr eax, 1
        add eax, @objectOnePosY
        mov @objectOneCenterY, eax

        ;获取objectTwo.中心X坐标
        mov eax, @objectTwoLengthX
        shr eax, 1
        add eax, @objectTwoPosX
        mov @objectTwoCenterX, eax
        
        ;获取objectTwo.中心Y坐标
        mov eax, @objectTwoLengthY
        shr eax, 1
        add eax, @objectTwoPosY
        mov @objectTwoCenterY, eax
        
        ;计算X轴距离之差
        mov eax, @objectOneCenterX
        .if @objectTwoCenterX > eax
                mov ebx, @objectTwoCenterX
                sub ebx, eax
                mov @distanceX, ebx
        .elseif
                sub eax, @objectTwoCenterX
                mov @distanceX, eax
        .endif

        ;计算Y轴距离之差
        mov eax, @objectOneCenterY
        .if @objectTwoCenterY > eax
                mov ebx, @objectTwoCenterY
                sub ebx, eax
                mov @distanceY, ebx
        .elseif
                sub eax, @objectTwoCenterY
                mov @distanceY, eax
        .endif

        ;对两个矩形进行碰撞判断
        ;计算临界X, Y
        mov eax, @objectOneLengthX
        add eax, @objectTwoLengthX
        shr eax, 2
        mov @criticalX, eax

        mov eax, @objectOneLengthY
        add eax, @objectTwoLengthY
        shr eax, 2
        mov @criticalY, eax

        ;两中心点构成的三角形处于临界三角形之内
        mov eax, @distanceX
        mov ebx, @distanceY
        .if @criticalX >= eax && @criticalY >= ebx
                mov eax, 1
                ret
        .endif

        mov eax, 0
        ret
_check_collision endp
        
_collision_test proc
        local @objectOne:BASE, @objectTwo:BASE

        mov @objectOne.posx, 1
        mov @objectOne.posy, 1
        mov @objectOne.lengthx, 1
        mov @objectOne.lengthy, 1
        mov @objectOne.alive, 1
        mov @objectOne.DC, 1
        mov @objectOne.rel_v, 1
        mov @objectOne.course_id, 1

        mov @objectTwo.posx, 1
        mov @objectTwo.posy, 1
        mov @objectTwo.lengthx, 1
        mov @objectTwo.lengthy, 1
        mov @objectTwo.alive, 1
        mov @objectTwo.DC, 1
        mov @objectTwo.rel_v, 1
        mov @objectTwo.course_id, 0

        invoke _check_collision,addr @objectOne, addr @objectTwo
        invoke printf, offset debug_int, eax
        ret
_collision_test endp

start:
        ; call    _WinMain
        ; invoke  ExitProcess, NULL
        
        invoke _collision_test
        ret
end     start
; end