.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc

.const
szCollision byte "collision check", 0ah, 0
szCollisionEnd byte "collision end", 0ah, 0
debug_str byte "%s", 0
szBulletWithSOFT byte "bullet hit SOFT", 0ah, 0
szCarWithHard byte "cart hit Hard", 0ah, 0

;sound
szPlaySuccess byte "Play Success", 0ah, 0
szPause byte "Pause", 0
; szOpenDemo equ TEXT("open demo.mp3 alias demoMusic")
; szPlayDemo equ TEXT("play demoMusic")
; szStopDemo equ TEXT("stop demoMusic")
; szCloseDemo equ TEXT("close demoMusic")
; szOpenDemo dw 'o','p','e','n',' ','d','e','m','o','.','m','p','3',' ','a','l','i','a','s',' ','d','e','m','o','M','u','s','i','c',0
; szPlayDemo dw 'p','l','a','y',' ','d','e','m','o','M','u','s','i','c',0
; szStopDemo dw 's','t','o','p',' ','d','e','m','o','M','u','s','i','c',0
; szCloseDemo dw 'c','l','o','s','e',' ','d','e','m','o','M','u','s','i','c',0

.data?
szPlayError byte 1000 dup(?)
wCharptr dd ?

.code

;3 check collision 每一帧调用
;两两枚举所有物体，令那些应该消失的消失：
;同时维护targets数组的数量target_number
;返回值为1代表碰撞
;返回值为0代表没有碰撞 
_check_collision proc uses ebx esi, @objectOne:ptr BASE, @objectTwo:ptr BASE
        local @objectOnePosX, @objectOnePosY
        local @objectOneLengthX, @objectOneLengthY

        local @objectTwoPosX, @objectTwoPosY
        local @objectTwoLengthX, @objectTwoLengthY

        local @objectOneCenterX, @objectTwoCenterY
        local @objectOneCenterY, @objectTwoCenterX

        local @distanceX, @distanceY

        local @criticalX, @criticalY

        mov esi, @objectOne
        assume esi:ptr BASE
        mov eax, [esi].course_id
        and eax, 3

        mov esi, @objectTwo
        assume esi:ptr BASE

        ;course_id不相同，直接判断不会碰撞
        .if [esi].course_id != eax
                mov eax, 0
                ; invoke printf, offset szInt, @objectOne.course_id
                ; invoke printf, offset szInt, @objectTwo.course_id
                ret
        .endif

        mov esi, @objectOne
        assume esi:ptr BASE

        ;objectOne
        mov eax, [esi].posx
        mov @objectOnePosX, eax

        mov eax, [esi].posy
        mov @objectOnePosY, eax
        
        mov eax, [esi].lengthx
        mov @objectOneLengthX, eax

        mov eax, [esi].lengthy
        mov @objectOneLengthY, eax


        mov esi, @objectTwo
        assume esi:ptr BASE

        ;objectTwo
        mov eax, [esi].posx
        mov @objectTwoPosX, eax

        mov eax, [esi].posy
        mov @objectTwoPosY, eax
        
        mov eax, [esi].lengthx
        mov @objectTwoLengthX, eax

        mov eax, [esi].lengthy
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
        .else
                sub eax, @objectTwoCenterX
                mov @distanceX, eax
        .endif

        ;计算Y轴距离之差
        mov eax, @objectOneCenterY
        .if @objectTwoCenterY > eax
                mov ebx, @objectTwoCenterY
                sub ebx, eax
                mov @distanceY, ebx
        .else
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
                ; invoke printf, offset debug_int, @criticalX
                ; invoke printf, offset debug_int, @criticalY
                ; invoke printf, offset debug_int, @distanceX
                ; invoke printf, offset debug_int, @distanceY
                ; invoke printf, offset debug_int, @objectOnePosX
                ; invoke printf, offset debug_int, @objectOnePosY
                ; invoke printf, offset debug_int, @objectTwoPosX
                ; invoke printf, offset debug_int, @objectTwoPosY
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

_collision_Player_with_MONEY_1 proc uses esi, moneyOne:ptr Targets
        ;音效
        invoke _collision_Player_with_MONEY_1_SOUND

        ;得到MONEY_1结构体
        mov esi, moneyOne
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;金币消失
        mov [esi].base.alive, 0
        
        ;TODO 得分增加
        lea esi, player
        assume esi:ptr Subject

        add [esi].score, MONEY_1_SCORE
        invoke printf, offset debug_int, [esi].score
        
        ret
_collision_Player_with_MONEY_1 endp


_collision_Player_with_MONEY_2 proc uses esi,  moneyTwo:ptr Targets
        ;得到MONEY_2结构体
        mov esi, moneyTwo
        assume esi :ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;MONEY_2消失
        mov [esi].base.alive, 0
        
        ;TODO 得分增加
        lea esi, player
        assume esi:ptr Subject
        
        add [esi].score, MONEY_2_SCORE
        invoke printf, offset debug_int, [esi].score

        ret
_collision_Player_with_MONEY_2 endp


_collision_Player_with_ACC proc uses esi,  ACC_target:ptr Targets
        ;音效
        invoke _collision_Player_with_ACC_SOUND

        ;得到ACC结构体
        mov esi, ACC_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;ACC消失
        mov [esi].base.alive, 0

        ;TODO 加速
        .if speed == slow_level
                mov speed, normal_level
        .elseif speed == normal_level
                mov speed, fast_level
        .endif
        
        ;更新道具时间
        ;加速时间拉满，减速时间归0
        mov speed_acc_time, speed_item_time
        mov speed_dec_time, 0

        ret
_collision_Player_with_ACC endp


_collision_Player_with_DEC proc uses esi,  DEC_target:ptr Targets
        ;音效
        invoke _collision_Player_with_DEC_SOUND

        ;得到DEC结构体
        mov esi, DEC_target
        assume esi:ptr Targets
        
        ; invoke printf, offset debug_int, [esi].typeid

        ;DEC消失
        mov [esi].base.alive, 0

        ;TODO 减速
        .if speed == normal_level
                mov speed, slow_level
        .elseif speed == fast_level
                mov speed, normal_level
        .endif

        ;更新道具时间
        ;减速时间拉满，加速时间归0
        mov speed_dec_time, speed_item_time
        mov speed_acc_time, 0

        ret
_collision_Player_with_DEC endp 


_collision_Player_with_HARD proc uses esi,  HARD_target:ptr Targets
 
        ;音效
        invoke _collision_Player_with_HARD_SOUND
        
        ;得到HARD结构体
        mov esi, HARD_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid
        ; invoke printf, offset debug_int, [esi].base.posx
        ; invoke printf, offset debug_int, [esi].base.posy


        ;HARD消失
        mov [esi].base.alive, 0

        ;TODO 游戏结束
        lea esi, player
        assume esi:ptr Subject
        
        ; mov [esi].base.alive, 0
        dec [esi].base.alive
        ; invoke printf, offset debug_int, [esi].base.posx
        ; invoke printf, offset debug_int, [esi].base.posy
        invoke printf, offset debug_str, offset szCarWithHard

        ret
_collision_Player_with_HARD endp


_collision_Player_with_SOFT proc uses esi,  SOFT_target:ptr Targets
        ;音效
        invoke _collision_Player_with_SOFT_SOUND
        
        ;得到SOFT结构体
        mov esi, SOFT_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;SOFT消失
        mov [esi].base.alive, 0

        ;TODO 扣分
        lea esi, player
        assume esi:ptr Subject

        .if [esi].score == 0
                mov [esi].score, 0
        .elseif
                add [esi].score, OBST_SOFT_SCORE
        .endif
        invoke printf, offset debug_int, [esi].score

        ret
_collision_Player_with_SOFT endp


_collision_bullet_with_SOFT proc uses esi,  SOFT_target:ptr Targets
        ;音效
        invoke _collision_bullet_with_SOFT_SOUND
        
        ;得到SOFT结构体
        mov esi, SOFT_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;SOFT消失
        mov [esi].base.alive, 0

        ;bullet消失
        mov bullet.base.alive, 0

        ret
_collision_bullet_with_SOFT endp


_two_two_enum proc uses ebx

        ; ============== declare ==============
        ;一些和target有关的局部变量
        local @new_target_number

        local @new_target_number_index
        local @newTargetByteOffset
        ; local @new_targets[1000]:Targets ;这个RE了？？？，如果程序卡顿了，大概率RE了
        local @target_number_index
        local @targetByteOffset

        ; 碰撞逻辑
        local @collisionFlag

        ; invoke printf, offset debug_str, offset szCollision
        ; ============== init ==============
        ; Old
        mov @targetByteOffset, 0
        mov @target_number_index, 0

        ; New
        mov @new_target_number, 0
        mov @new_target_number_index, 0
        mov @newTargetByteOffset, 0

        .while TRUE
                ; 循环次数判定
                mov eax, @target_number_index
                .break .if target_number == eax

                ; invoke printf, offset debug_int, eax
                ; invoke printf, offset debug_int, @targetByteOffset
                
                ; 得到结构体
                mov eax, @targetByteOffset
                lea esi, targets[eax]
                assume esi:ptr Targets

                ; invoke printf, offset debug_int, [esi].typeid
                
                ; 判断逻辑
                .if [esi].typeid == MONEY_1
                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base 
                                mov @collisionFlag, eax
                        .endif
                        
                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_1, esi
                                
                        .endif
                .elseif [esi].typeid == MONEY_2
                        ; invoke printf, offset debug_int, [esi].typeid
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_2, esi
                        .endif

                .elseif [esi].typeid == PROP_ACC_SELF
                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag
                        
                        .if @collisionFlag == 1
                                invoke _collision_Player_with_ACC, esi
                        .endif

                .elseif [esi].typeid == PROP_DEC_SELF

                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag


                        .if @collisionFlag == 1
                                invoke _collision_Player_with_DEC, esi
                        .endif
                        
                .elseif [esi].typeid == OBST_HARD

                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_HARD, esi
                        .endif
                .elseif [esi].typeid == OBST_SOFT

                        mov @collisionFlag, 0

                        .if bullet.base.alive == 1
                                invoke _check_collision, addr bullet.base, addr [esi].base
                                mov @collisionFlag, eax
                                ; invoke printf, offset debug_int, @collisionFlag
                                ; invoke printf, offset debug_int, bullet.base.course_id
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_bullet_with_SOFT, esi
                        .else
                                .if flag_jump == 1 
                                        mov @collisionFlag, 0
                                .else
                                        invoke _check_collision, addr player.base, addr [esi].base
                                        mov @collisionFlag, eax    
                                .endif
                                
                                .if @collisionFlag == 1
                                        invoke _collision_Player_with_SOFT, esi
                                .endif
                        .endif
                .endif

                ;获取要附带的结构体地址
                mov eax, @targetByteOffset
                lea esi, targets[eax]
                assume esi:ptr Targets

                ; invoke printf, offset debug_int, [esi].base.alive
                
                ;覆盖targets
                .if [esi].base.alive == 1
                        ; invoke printf, offset debug_int, [esi].typeid
                        mov eax, @new_target_number_index
                        .if eax != @target_number_index
                                
                                ;获取要覆盖的结构体地址
                                mov eax, @newTargetByteOffset
                                lea ebx, targets[eax]
                                assume ebx :ptr Targets

                                ;覆盖
                                mov eax, [esi].base.posx
                                mov [ebx].base.posx, eax

                                mov eax, [esi].base.posy
                                mov [ebx].base.posy, eax
                                
                                mov eax, [esi].base.lengthx
                                mov [ebx].base.lengthx, eax

                                mov eax, [esi].base.lengthy
                                mov [ebx].base.lengthy, eax

                                mov eax, [esi].base.alive
                                mov [ebx].base.alive, eax

                                mov eax, [esi].base.DC
                                mov [ebx].base.DC, eax

                                mov eax, [esi].base.rel_v
                                mov [ebx].base.rel_v, eax

                                mov eax, [esi].base.course_id
                                mov [ebx].base.course_id, eax

                                mov eax, [esi].typeid
                                mov [ebx].typeid, eax
                        .endif
                        
                        ;递增offset
                        mov eax, sizeofTargets
                        add eax, @newTargetByteOffset
                        mov @newTargetByteOffset, eax

                        ;递增number和index
                        inc @new_target_number
                        inc @new_target_number_index
                .endif
                
                
                
                ;递增offset
                mov eax, sizeofTargets
                add eax, @targetByteOffset
                mov @targetByteOffset, eax

                ;递增index
                inc @target_number_index
        .endw

        ;修改target_number
        mov eax, @new_target_number
        ; inc eax
        mov target_number, eax

        ; invoke printf, offset debug_int, @new_target_number
        ; invoke printf, offset debug_str, offset szCollisionEnd

        ret
_two_two_enum endp

_two_two_enum_test proc
        ;给bullet赋值
        lea esi, bullet
        assume esi :ptr Subject

        mov [esi].base.posx, 1
        mov [esi].base.posy, 1
        mov [esi].base.lengthx, 1
        mov [esi].base.lengthy, 1
        mov [esi].base.alive, 1
        mov [esi].base.DC, 1
        mov [esi].base.rel_v, 1
        mov [esi].base.course_id, 1
        mov [esi].score, 1


        ; invoke printf, offset debug_int, [esi].base.posx
        ;给player赋值
        lea esi, player
        assume esi :ptr Subject

        mov [esi].base.posx, 1
        mov [esi].base.posy, 1
        mov [esi].base.lengthx, 1
        mov [esi].base.lengthy, 1
        mov [esi].base.alive, 1
        mov [esi].base.DC, 1
        mov [esi].base.rel_v, 1
        mov [esi].base.course_id, 1
        mov [esi].score, 1

        ;第零个targets
        lea esi, targets[0]
        assume esi :ptr Targets

        mov [esi].base.posx, 1
        mov [esi].base.posy, 1
        mov [esi].base.lengthx, 1
        mov [esi].base.lengthy, 1
        mov [esi].base.alive, 1
        mov [esi].base.DC, 1
        mov [esi].base.rel_v, 1
        mov [esi].base.course_id, 0
        mov [esi].typeid, MONEY_1

        ; invoke _two_two_enum
        ; .if [esi].typeid == MONEY_1
        ;         invoke printf, offset szInt, targets[0].typeid
        ; .endif
        
        ; invoke printf, offset debug_int, [esi].base.posx
        ; invoke printf, offset debug_int, [esi].typeid

        ; 第一个targets
        lea esi, targets[sizeofTargets]
        assume esi :ptr Targets

        mov [esi].base.posx, 1
        mov [esi].base.posy, 2
        mov [esi].base.lengthx, 3
        mov [esi].base.lengthy, 4
        mov [esi].base.alive, 1
        mov [esi].base.DC, 1
        mov [esi].base.rel_v, 1
        mov [esi].base.course_id, 0
        mov [esi].typeid, MONEY_2

        mov target_number, 2

        ; invoke printf, offset debug_int, target_number
        ; invoke printf, offset debug_int, [esi].typeid
        ; invoke printf, offset debug_int, [esi].base.posx
        ; invoke printf, offset debug_int, sizeofTargets
        invoke _two_two_enum

        ; invoke printf, offset debug_int, target_number

        ret
_two_two_enum_test endp


_Open_ALL_SOUND proc
        invoke mciSendString, offset szOpenJump, NULL, 0, NULL
        invoke mciSendString, offset szOpenMoneyOne, NULL, 0, NULL
        ; invoke mciSendString, offset szOpenMoneyTwo, NULL, 0, NULL
        invoke mciSendString, offset szOpenACC, NULL, 0, NULL
        invoke mciSendString, offset szOpenDEC, NULL, 0, NULL
        invoke mciSendString, offset szOpenHARD, NULL, 0, NULL
        invoke mciSendString, offset szOpenSOFT, NULL, 0, NULL
        invoke mciSendString, offset szOpenBulletHitSOFT, NULL, 0, NULL
        invoke mciSendString, offset szOpenLaunch, NULL, 0, NULL
        invoke mciSendString, offset szOpenCarMove, NULL, 0, NULL

        invoke mciSendString, offset szOpenBGM, NULL, 0, NULL
        invoke mciSendString, offset szOpenEnd, NULL, 0, NULL
        invoke mciSendString, offset szOpenGameover, NULL, 0, NULL
        invoke mciSendString, offset szOpenBeginBGM, NULL, 0, NULL
        ret
_Open_ALL_SOUND endp

_Close_ALL_SOUND proc
        invoke mciSendString, offset szCloseJump, NULL, 0, NULL
        invoke mciSendString, offset szCloseMoneyOne, NULL, 0, NULL
        ; invoke mciSendString, offset szCloseMoneyTwo, NULL, 0, NULL
        invoke mciSendString, offset szCloseACC, NULL, 0, NULL
        invoke mciSendString, offset szCloseDEC, NULL, 0, NULL
        invoke mciSendString, offset szCloseHARD, NULL, 0, NULL
        invoke mciSendString, offset szCloseSOFT, NULL, 0, NULL
        invoke mciSendString, offset szCloseBulletHitSOFT, NULL, 0, NULL
        invoke mciSendString, offset szCloseLaunch, NULL, 0, NULL
        invoke mciSendString, offset szCloseCarMove, NULL, 0, NULL

        invoke mciSendString, offset szCloseBGM, NULL, 0, NULL
        invoke mciSendString, offset szCloseEnd, NULL, 0, NULL
        invoke mciSendString, offset szCloseGameover, NULL, 0, NULL
        invoke mciSendString, offset szCloseBeginBGM, NULL, 0, NULL
        ret
_Close_ALL_SOUND endp
        
;==================== no stop =================
_Jump_SOUND proc
        invoke mciSendString, offset szPlayJump, NULL, 0, NULL
        ret
_Jump_SOUND endp

_collision_Player_with_MONEY_1_SOUND proc
        invoke mciSendString, offset szPlayMoneyOne, NULL, 0, NULL
        ; invoke mciGetErrorString, eax, offset szPlayError, sizeof szPlayError
        ; invoke printf, offset debug_str, offset szPlayError
        ret
_collision_Player_with_MONEY_1_SOUND endp


_collision_Player_with_MONEY_2_SOUND proc
        invoke mciSendString, offset szPlayMoneyTwo, NULL, 0, NULL       
        ret
_collision_Player_with_MONEY_2_SOUND endp


_collision_Player_with_ACC_SOUND proc
        invoke mciSendString, offset szPlayACC, NULL, 0, NULL    
        ret
_collision_Player_with_ACC_SOUND endp

_collision_Player_with_DEC_SOUND proc   
        invoke mciSendString, offset szPlayDEC, NULL, 0, NULL 
        ret
_collision_Player_with_DEC_SOUND endp

_collision_Player_with_HARD_SOUND proc
        invoke mciSendString, offset szPlayHARD, NULL, 0, NULL       
        ret
_collision_Player_with_HARD_SOUND endp


_collision_Player_with_SOFT_SOUND proc
        invoke mciSendString, offset szPlaySOFT, NULL, 0, NULL         
        ret
_collision_Player_with_SOFT_SOUND endp

_collision_bullet_with_SOFT_SOUND proc
        invoke mciSendString, offset szPlayBulletHitSOFT, NULL, 0, NULL       
        ret
_collision_bullet_with_SOFT_SOUND endp

;BGM
_BGM_SOUND proc
        invoke mciSendString, offset szPlayBGM, NULL, 0, NULL       
        ret
_BGM_SOUND endp

_Stop_BGM_SOUND proc
        invoke mciSendString, offset szStopBGM, NULL, 0, NULL    
        ret
_Stop_BGM_SOUND endp

;Launch
_Launch_SOUND proc
        invoke mciSendString, offset szPlayLaunch, NULL, 0, NULL     
        ret
_Launch_SOUND endp

;CarMove
_CarMove_SOUND proc
        invoke mciSendString, offset szPlayCarMove, NULL, 0, NULL         
        ret        
_CarMove_SOUND endp

;==================== no stop =================

;====================== have stop ==================

;END
_END_SOUND proc 
        invoke mciSendString, offset szPlayEnd, NULL, 0, NULL       
        ret
_END_SOUND endp

_Stop_END_SOUND proc
        invoke mciSendString, offset szStopEnd, NULL, 0, NULL    
        ret
_Stop_END_SOUND endp

;Gameover
_Gameover_SOUND proc
        invoke mciSendString, offset szPlayGameover, NULL, 0, NULL         
        ret
_Gameover_SOUND endp

_Stop_Gameover_SOUND proc
        invoke mciSendString, offset szStopGameover, NULL, 0, NULL   
        ret
_Stop_Gameover_SOUND endp

;BeginBGM
_BeginBGM_SOUND proc
        invoke mciSendString, offset szPlayBeginBGM, NULL, 0, NULL         
        ret
_BeginBGM_SOUND endp

_Stop_BeginBGM_SOUND proc
        invoke mciSendString, offset szStopBeginBGM, NULL, 0, NULL   
        ret
_Stop_BeginBGM_SOUND endp

;====================== have stop ==================





_collision_SOUND_test proc
        ; invoke mciSendString, offset szOpenDemo, NULL, 0, NULL
        ; invoke mciSendString, offset szPlayDemo, NULL, 0, NULL
        ; invoke mciSendString, offset szCloseDemo, NULL, 0, NULL
        ; invoke mciGetErrorString, eax, offset szPlayError, sizeof szPlayError
        ; invoke printf, offset debug_str, offset szPlayError
        ; invoke printf, offset debug_int, eax
        ; invoke printf, offset debug_str, offset szPlaySuccess
        

        ; invoke _BGM_SOUND
        ; invoke _END_SOUND
        ; invoke _Jump_SOUND
        invoke _collision_Player_with_MONEY_1_SOUND
        ; invoke _collision_Player_with_MONEY_1_SOUND
        ; invoke system, offset szPause
        ret
_collision_SOUND_test endp

_Player_get_item proc Player_new:ptr Subject, itemId:dword
        
_Player_get_item endp


_two_two_enum_symbiotic proc mainPlayer:ptr Subject, mainTargets:dword
        ; ============== declare ==============
        ;一些和target有关的局部变量
        local @new_target_number

        local @new_target_number_index
        local @newTargetByteOffset
        ; local @new_targets[1000]:Targets ;这个RE了？？？，如果程序卡顿了，大概率RE了
        local @target_number_index
        local @targetByteOffset

        ; 碰撞逻辑
        local @collisionFlag

        ; invoke printf, offset debug_str, offset szCollision
        ; ============== init ==============
        ; Old
        mov @targetByteOffset, 0
        mov @target_number_index, 0

        ; New
        mov @new_target_number, 0
        mov @new_target_number_index, 0
        mov @newTargetByteOffset, 0

        .while TRUE
                ; 循环次数判定
                mov eax, @target_number_index
                .break .if target_number == eax

                ; invoke printf, offset debug_int, eax
                ; invoke printf, offset debug_int, @targetByteOffset
                
                ; 得到结构体
                mov eax, @targetByteOffset
                lea esi, targets[eax]
                assume esi:ptr Targets

                ; invoke printf, offset debug_int, [esi].typeid
                
                ; 判断逻辑
                .if [esi].typeid == MONEY_1
                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base 
                                mov @collisionFlag, eax
                        .endif
                        
                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_1, esi
                                
                        .endif
                .elseif [esi].typeid == MONEY_2
                        ; invoke printf, offset debug_int, [esi].typeid
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_2, esi
                        .endif

                .elseif [esi].typeid == PROP_ACC_SELF
                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag
                        
                        .if @collisionFlag == 1
                                invoke _collision_Player_with_ACC, esi
                        .endif

                .elseif [esi].typeid == PROP_DEC_SELF

                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag


                        .if @collisionFlag == 1
                                invoke _collision_Player_with_DEC, esi
                        .endif
                        
                .elseif [esi].typeid == OBST_HARD

                        .if flag_jump == 1
                                mov @collisionFlag, 0
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_HARD, esi
                        .endif
                .elseif [esi].typeid == OBST_SOFT

                        mov @collisionFlag, 0

                        .if bullet.base.alive == 1
                                invoke _check_collision, addr bullet.base, addr [esi].base
                                mov @collisionFlag, eax
                                ; invoke printf, offset debug_int, @collisionFlag
                                ; invoke printf, offset debug_int, bullet.base.course_id
                        .endif

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_bullet_with_SOFT, esi
                        .else
                                .if flag_jump == 1 
                                        mov @collisionFlag, 0
                                .else
                                        invoke _check_collision, addr player.base, addr [esi].base
                                        mov @collisionFlag, eax    
                                .endif
                                
                                .if @collisionFlag == 1
                                        invoke _collision_Player_with_SOFT, esi
                                .endif
                        .endif
                .endif

                ;获取要附带的结构体地址
                mov eax, @targetByteOffset
                lea esi, targets[eax]
                assume esi:ptr Targets

                ; invoke printf, offset debug_int, [esi].base.alive
                
                ;覆盖targets
                .if [esi].base.alive == 1
                        ; invoke printf, offset debug_int, [esi].typeid
                        mov eax, @new_target_number_index
                        .if eax != @target_number_index
                                
                                ;获取要覆盖的结构体地址
                                mov eax, @newTargetByteOffset
                                lea ebx, targets[eax]
                                assume ebx :ptr Targets

                                ;覆盖
                                mov eax, [esi].base.posx
                                mov [ebx].base.posx, eax

                                mov eax, [esi].base.posy
                                mov [ebx].base.posy, eax
                                
                                mov eax, [esi].base.lengthx
                                mov [ebx].base.lengthx, eax

                                mov eax, [esi].base.lengthy
                                mov [ebx].base.lengthy, eax

                                mov eax, [esi].base.alive
                                mov [ebx].base.alive, eax

                                mov eax, [esi].base.DC
                                mov [ebx].base.DC, eax

                                mov eax, [esi].base.rel_v
                                mov [ebx].base.rel_v, eax

                                mov eax, [esi].base.course_id
                                mov [ebx].base.course_id, eax

                                mov eax, [esi].typeid
                                mov [ebx].typeid, eax
                        .endif
                        
                        ;递增offset
                        mov eax, sizeofTargets
                        add eax, @newTargetByteOffset
                        mov @newTargetByteOffset, eax

                        ;递增number和index
                        inc @new_target_number
                        inc @new_target_number_index
                .endif
                
                
                
                ;递增offset
                mov eax, sizeofTargets
                add eax, @targetByteOffset
                mov @targetByteOffset, eax

                ;递增index
                inc @target_number_index
        .endw

        ;修改target_number
        mov eax, @new_target_number
        ; inc eax
        mov target_number, eax

        ; invoke printf, offset debug_int, @new_target_number
        ; invoke printf, offset debug_str, offset szCollisionEnd

        ret
_two_two_enum_symbiotic endp

start:
        ; call    _WinMain
        ; invoke  ExitProcess, NULL
        ; invoke _Open_ALL_SOUND
        
        ; invoke _collision_test
        ; invoke _collision_SOUND_test

        ; invoke _Close_ALL_SOUND
        invoke printHelloWorld
        ret
end     start
; end