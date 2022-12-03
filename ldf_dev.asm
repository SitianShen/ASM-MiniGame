.386
.model flat, stdcall
option casemap: none

include global.inc

; extrn player:Subject         
; extrn bullet:Subject             
; extrn targets

; ;zzl own
; extrn button_play:Button      
; extrn button_start:Button      
; extrn button_back:Button      
; extrn button_exit:Button       
; extrn backGround:BackGround       
; extrn object_DC:Object_DC        

; extrn hInstance:dd       
; extrn hWinMain:dd      
; extrn hDCBack:dd         
; extrn hDCGame:dd         
; extrn hDCObj1:dd        
; extrn dwNowBack:dd     

; extrn flag_jump:dd               
; extrn flag_movleft:dd          
; extrn flag_movright:dd           
; extrn stdtime_jump:dd            
; extrn time_jump:dd              
; extrn stdtime_mov:dd             
; extrn time_mov:dd             
; extrn cur_interface:dd     

; extrn target_number:dd       
; extrn speed:dd     

.const
szCollision byte "collision check", 0ah, 0
szCollisionEnd byte "collision end", 0ah, 0
debug_str byte "%s", 0

.code

;3 check collision 每一帧调用
;两两枚举所有物体，令那些应该消失的消失：
;同时维护targets数组的数量target_number
;返回值为1代表碰撞
;返回值为0代表没有碰撞 
_check_collision proc uses ebx, @objectOne:ptr BASE, @objectTwo:ptr BASE
        local @objectOnePosX, @objectOnePosY
        local @objectOneLengthX, @objectOneLengthY

        local @objectTwoPosX, @objectTwoPosY
        local @objectTwoLengthX, @objectTwoLengthY

        local @objectOneCenterX, @objectTwoCenterY
        local @objectOneCenterY, @objectTwoCenterX

        local @distanceX, @distanceY

        local @criticalX, @criticalY

        mov esi, @objectOne
        assume esi: ptr BASE
        mov eax, [esi].course_id

        mov esi, @objectTwo
        assume esi: ptr BASE

        .if [esi].course_id != eax
                mov eax, 0
                ; invoke printf, offset szInt, @objectOne.course_id
                ; invoke printf, offset szInt, @objectTwo.course_id
                ret
        .endif

        ;objectOne
        mov eax, [esi].posx
        mov @objectOnePosX, eax

        mov eax, [esi].posy
        mov @objectOnePosY, eax
        
        mov eax, [esi].lengthx
        mov @objectOneLengthX, eax

        mov eax, [esi].lengthy
        mov @objectOneLengthY, eax

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

_collision_Player_with_MONEY_1 proc moneyOne:ptr Targets
        ;得到MONEY_1结构体
        mov esi, moneyOne
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;金币消失
        mov [esi].base.alive, 0
        
        ;TODO 得分增加

        ret
_collision_Player_with_MONEY_1 endp


_collision_Player_with_MONEY_2 proc moneyTwo:ptr Targets
        ;得到MONEY_2结构体
        mov esi, moneyTwo
        assume esi :ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;MONEY_2消失
        mov [esi].base.alive, 0
        
        ;TODO 得分增加
        lea esi, player


        ret
_collision_Player_with_MONEY_2 endp


_collision_Player_with_ACC proc ACC_target:ptr Targets
        ;得到ACC结构体
        mov esi, ACC_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;ACC消失
        mov [esi].base.alive, 0

        ;TODO 加速

        ret
_collision_Player_with_ACC endp


_collision_Player_with_DEC proc DEC_target:ptr Targets
        ;得到DEC结构体
        mov esi, DEC_target
        assume esi:ptr Targets
        
        ; invoke printf, offset debug_int, [esi].typeid

        ;DEC消失
        mov [esi].base.alive, 0

        ;TODO 减速

        ret
_collision_Player_with_DEC endp 


_collision_Player_with_HARD proc HARD_target:ptr Targets 
        ;得到HARD结构体
        mov esi, HARD_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;HARD消失
        mov [esi].base.alive, 0

        ;TODO 游戏结束

        ret
_collision_Player_with_HARD endp


_collision_Player_with_SOFT proc SOFT_target:ptr Targets
        ;得到SOFT结构体
        mov esi, SOFT_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;SOFT消失
        mov [esi].base.alive, 0

        ;TODO 扣分
        ret
_collision_Player_with_SOFT endp


_collision_bullet_with_HARD proc HARD_target:ptr Targets
        ;得到HARD结构体
        mov esi, HARD_target
        assume esi:ptr Targets

        ; invoke printf, offset debug_int, [esi].typeid

        ;HARD消失
        mov [esi].base.alive, 0
        
        ;得到bullet结构体
        lea esi, bullet
        assume esi:ptr Targets

        ;bullet消失
        mov [esi].base.alive, 0

        ret
_collision_bullet_with_HARD endp


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

        invoke printf, offset debug_str, offset szCollision
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
                        invoke _check_collision, addr player.base, addr [esi].base 
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_1, esi
                        .endif

                .elseif [esi].typeid == MONEY_2
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_MONEY_2, esi
                        .endif

                .elseif [esi].typeid == PROP_ACC_SELF
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag
                        
                        .if @collisionFlag == 1
                                invoke _collision_Player_with_ACC, esi
                        .endif

                .elseif [esi].typeid == PROP_DEC_SELF
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag


                        .if @collisionFlag == 1
                                invoke _collision_Player_with_DEC, esi
                        .endif
                        
                .elseif [esi].typeid == OBST_HARD
                        invoke _check_collision, addr bullet.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_bullet_with_HARD, esi
                        .else
                                invoke _check_collision, addr player.base, addr [esi].base
                                mov @collisionFlag, eax
                                .if @collisionFlag == 1
                                        invoke _collision_bullet_with_HARD, esi
                                .endif
                        .endif

                .elseif [esi].typeid == OBST_SOFT
                        invoke _check_collision, addr player.base, addr [esi].base
                        mov @collisionFlag, eax

                        ; invoke printf, offset debug_int, [esi].typeid
                        ; invoke printf, offset debug_int, @collisionFlag

                        .if @collisionFlag == 1
                                invoke _collision_Player_with_SOFT, esi
                        .endif
                .endif

                ;获取要附带的结构体地址
                mov eax, @targetByteOffset
                lea esi, targets[eax]
                assume esi:ptr Targets

                ; invoke printf, offset debug_int, [esi].base.alive
                
                ;覆盖targets
                .if [esi].base.alive == 1
                        invoke printf, offset debug_int, [esi].typeid
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
        invoke printf, offset debug_str, offset szCollisionEnd
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
        mov [esi].base.posy, 1
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

_targets_bullet_out_of_bound proc
        ; 判断道具越界
        mov ebx, target_number
        xor eax, eax
        .while eax < ebx
                push eax
                mov edx, 0
                mov ebx, sizeofTargets
                mul ebx
                .if targets[eax].base.alive == 1
                        .if targets[eax].base.posx <= 10 || targets[eax].base.posx >= gameW-10 \
                        || targets[eax].base.posy <= 10 || targets[eax].base.posy <= gameH-10
                                mov targets[eax].base.alive, 0
                        .endif
                .endif
                pop eax
                inc eax
        .endw

        ; 判断子弹越界
        .if bullet.base.alive == 1
                .if bullet.base.posx <= 10 || bullet.base.posx >= gameW-10 \
                || bullet.base.posy <= 10 || bullet.base.posy <= gameH-10
                        mov bullet.base.alive, 0
                .endif
        .endif
ret
_targets_bullet_out_of_bound endp




start:
        ; call    _WinMain
        ; invoke  ExitProcess, NULL
        
        ; invoke _collision_test
        invoke _two_two_enum_test
        ret
end     start
; end