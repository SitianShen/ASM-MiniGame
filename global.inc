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

;=====================================================
; sst functions
_Init_car proto;小车初始化
_Move_process proto;每帧更新都要调用，实现连续性移动或跳起
_Action_left proto;
_Action_right proto;
_Action_jump proto;
_sst_test proto

; ldf functions
_check_collision proto :ptr BASE,:ptr BASE
_collision_test proto

_collision_Player_with_MONEY_1 proto :ptr Targets
_collision_Player_with_MONEY_2 proto :ptr Targets
_collision_Player_with_ACC proto :ptr Targets
_collision_Player_with_DEC proto :ptr Targets
_collision_Player_with_HARD proto :ptr Targets
_collision_Player_with_SOFT proto :ptr Targets
_collision_bullet_with_HARD proto :ptr Targets
_two_two_enum proto
_two_two_enum_test proto
_targets_bullet_out_of_bound proto
; lja functions
_next_position proto :ptr BASE         ;每个道具移动
_change_all_position proto      ;遍历所有道具，使之移动
;=====================================================

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

Button struct 
        base     BASE <>
        DC       dd      ?  
        DC_      dd      ? ;chosen
        is_click dd      ?
Button ends

BackGround struct
        DC_b    dd      ?
        DC_p    dd      ?
        DC_i    dd      ?
        DC_e    dd      ?
BackGround ends
        

.data?
player          Subject <>              ;????
bullet          Subject <>              ;???
env_objecet_1   BASE    <>              ;???????????? 1
env_objecet_2   BASE    <>              ;???????????? 2
env_objecet_3   BASE    <>              ;???????????? 3
targets         Targets  1000 dup(<>)   ;????

;zzl own
button_play       Button <>
button_start      Button <>
button_back       Button <>
button_exit       Button <>
backGround        BackGround <>

.data
choose_start equ 0
choose_intro equ 1
choose_which_char dd 0

in_begining             equ 0
in_game                 equ 1
in_intro                equ 2
in_over                 equ 3
cur_interface           dd  0

;sst own
carx0                   equ     200;?????????
carx1                   equ     300
carx2                   equ     400
cary                    equ     500

.data
flag_jump               dd      0
flag_movleft            dd      0
flag_movright           dd      0
stdtime_jump            dd      100
time_jump               dd      100
stdtime_mov             dd      50
time_mov                dd      50

.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;??????????targets???锟紸???

.data
speed      dd      4 ;?????? ??锟斤拷?????

;when you store something-> offset targets + (id%MAX_TARGET_NUMBER) ???????


; ########################################################## try code
ID_TIMER        equ     1
IDB_BACKG_BEGINING       equ     99
IDB_BACKG_INTRO          equ     98
IDB_BACKG_PLAY           equ     97
IDB_BACKG_END            equ     96
IDB_BACKG       equ     100
IDB_OBJ1        equ     101
IDB_OBJ2        equ     102
IDB_OBJ3        equ     103
IDB_ICON        equ     200
IDB_GAMESTART   equ     301
IDB_GAMEINTRO   equ     302
IDB_GAMESTARTC  equ     303
IDB_GAMEINTROC  equ     304

IDB_BUTTON_BACK_1  equ 305
IDB_BUTTON_BACK_2  equ 306
button_back_LX     equ 320
button_back_LY     equ 140

IDB_BUTTON_EXIT_1  equ 307
IDB_BUTTON_EXIT_2  equ 308
button_exit_LX     equ 200
button_exit_LY     equ 84

IDB_BUTTON_PLAY_1  equ 309
IDB_BUTTON_PLAY_2  equ 310
button_play_LX     equ 200
button_play_LY     equ 85

IDB_BUTTON_START_1 equ 311
IDB_BUTTON_START_2 equ 312
button_start_LX     equ 265
button_start_LY     equ 83

PROP_LX equ 500
PROP_LY equ 500
IDB_PROP_MONEY      equ 313
IDB_PROP_ABSTSOFT   equ 314
IDB_PROP_ABSTHARD   equ 315
IDB_PROP_ACC        equ 316
IDB_PROP_DEC        equ 317
IDB_PROP_BULLETL    equ 318
IDB_PROP_BULLETM    equ 319
IDB_PROP_BULLETR     equ 320



gameH           equ     600
gameW           equ     600
charH           equ     400
charW           equ     400
sizeofTargets   equ     sizeof Targets
.data


object1H         dd     57
object1W         dd     86
object_move_v    dd     2
POSCNT          dd      0; NEXTPOS的计数器


.data?
hInstance       dd      ?
hWinMain        dd      ?
; hCursorMain     dd      ?
; hCursorMove     dd      ?
; hMenu           dd      ?
; hBmpBack        dd      ?
; hBmpClock       dd      ?
; ????????锟組??
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
szInt       db      '%d', 0ah, 0

; ########################################################## try code