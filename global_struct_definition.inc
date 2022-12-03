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
srand proto c:dword,:vararg
time proto c:dword,:vararg
rand proto c

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
        DC_pu   dd     ?
        DC_pd   dd     ?
        DC_i    dd      ?
        DC_e    dd      ?
BackGround ends

Object_DC struct
        env1    dd      ?
        env2    dd      ?
        env3    dd      ?
        sobs    dd      ?
        hobs    dd      ?
        accp    dd      ?
        decp    dd      ?
        coin    dd      ?
Object_DC ends