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
rand proto c
srand proto c:dword, :vararg
time proto c

BASE struct
        posx    dd      ?
        posy    dd      ?
        lengthx dd      ?
        lengthy dd      ?
        alive   dd      ?
        DC      dd      ?  ;物体图片句柄
        rel_v   dd      ?  ;相对移动速度（倍率）
        course_id       dd     ?
BASE ends

Subject struct 
        base    BASE  <> 
        score   dd      ?
Subject ends

MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 ;给自己加速
PROP_DEC_SELF           equ 2001 ;给自己减速
OBST_HARD               equ 3000 ;硬障碍
OBST_SOFT               equ 3001 ;软障碍
Targets struct
        base    BASE  <> 
        typeid  dd      ?
Targets ends

.data?
player          Subject <>              ;人物
bullet          Subject <>              ;子弹
env_objecet_1   BASE    <>              ;三个环境物体 1
env_objecet_2   BASE    <>              ;三个环境物体 2
env_objecet_3   BASE    <>              ;三个环境物体 3
targets         Targets  1000 dup(<>)   ;物体

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

.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;物体数量（targets数组长度）

.data
base_speed      dd      2 ;基准速度 单位为像素
speed            dd      4 ;每次更新移动y方向的像素
POSCNT          dd      0; NEXTPOS的计数器
hello sbyte 'hello', 0ah, 0

;when you store something-> offset targets + (id%MAX_TARGET_NUMBER) 循环队列




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
; 缓存的钟面背景
hDCBack         dd      ?
; 缓存的游戏画面
hDCGame         dd      ?
; 游戏目标1
hDCObj1         dd      ?
; 缓存的叠加上指针的钟面
; hDCClock        dd      ?

dwNowBack       dd      ?
; dwNowObj1       dd      ?
; dwNowCircle     dd      ?

.const
szClassName     db      'run away from covid-19', 0
; _dwPara180      dw      180
; dwRadius        dw      100/2
; szMenuBack1     db      '使用背景1(&A)', 0
; szMenuBack2     db      '使用背景2(&B)', 0
; szMenuCircle1   db      '使用边框1(&C)', 0
; szMenuCircle2   db      '使用边框2(&D)', 0
; szMenuExit      db      '退出(&X)', 0
debug_int       db      '%d', 0ah, 0
; ########################################################## try code

; BASE struct
;         posx    dd      ?
;         posy    dd      ?
;         lengthx dd      ?
;         lengthy dd      ?
;         alive   dd      ?
;         DC      dd      ?  ;物体图片句柄
;         rel_v   dd      ?  ;相对移动速度（倍率）
;         course_id       dd     ?
; BASE ends

.code

NextPos proc stdcall ptrBase :ptr BASE
        ; local cur_speed :dword
        ; mov bx, speed
        ; xor ax, ax
        ; mov al, bl
        ; mov cx, base_speed
        ; xor bx, bx
        ; mov bl, cl
        ; mul bl
        inc POSCNT
        mov esi, ptrBase
        assume  esi: ptr BASE

        mov ecx, [esi].course_id
        .if ecx == 2 ;正中间跑道
                mov eax, speed
                add [esi].posy, eax

        .elseif ecx == 1 ;最左边跑道
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 4
                div ebx
                sub [esi].posx, eax

        .elseif cx == 3 ;最右边跑道
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 4
                div ebx
                add [esi].posx, eax
        
        .elseif cx == 0 ;左侧风景
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 2
                div ebx
                sub [esi].posx, eax

        .elseif cx == 4 ;右侧风景
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 2
                div ebx
                add [esi].posx, eax

        .elseif cx == 6 ;中间跑道的子弹
                mov eax, speed
                sub [esi].posy, eax

        .elseif cx == 5 ;左边跑道的子弹
                mov eax, speed
                sub [esi].posy, eax
                mov edx, 0
                mov ebx, 4
                div ebx
                add [esi].posx, eax

        .elseif cx == 7 ;右边跑道的子弹
                mov eax, speed
                sub [esi].posy, eax
                mov edx, 0
                mov ebx, 4
                div ebx
                sub [esi].posx, eax

        .endif
        mov eax, POSCNT

        .if eax & 0001h
                .if cx != 5 && cx != 6 && cx != 7
                        inc [esi].lengthx
                        inc [esi].lengthy
                .else 
                        dec [esi].lengthx
                        dec [esi].lengthy
                .endif
        .endif
        assume  esi: nothing
ret
NextPos endp 

ChangeAllPos proc stdcall       ;遍历所有道具改变位置
        mov ebx, target_number
        xor eax, eax
        .while eax < target_number
                lea esi, targets[eax]
                invoke NextPos, esi
        .endw
ret
ChangeAllPos endp

end