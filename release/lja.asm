.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc

.code
;speed =  1 —— 快，2 —— 正常， 3 —— 慢
_next_position proc stdcall ptrBase :ptr BASE
        ; local cur_speed :dword
        ; mov bx, speed
        ; xor ax, ax
        ; mov al, bl
        ; mov cx, base_speed
        ; xor bx, bx
        ; mov bl, cl
        ; mul bl

        ; local @randnum :dword
        ; invoke rand
        ; mov @randnum, eax

        local @TMP :dword
        mov @TMP, 0
        ; invoke printf, offset debug_int, TESTCNT
        inc POSCNT
        mov eax, POSCNT
        .if eax > 1024
                mov POSCNT, 0
        .endif

        mov esi, ptrBase
        assume  esi: ptr BASE
        mov ecx, [esi].course_id
        .if [esi].posy > 300
                mov base_speed, 2
        .endif
        ; .if eax & 10 == 0
        .if ecx == 2 ;正中间跑道
                invoke rand
                mov ecx, eax
                mov eax, base_speed
                add [esi].posy, eax
                and ecx, 100
                .if ecx == 0
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                        sub [esi].posx, eax
                .endif

        .elseif ecx == 1 ;最左边跑道

                mov eax, base_speed
                add [esi].posy, eax

                mov edx, [esi].posy
                ; invoke printf, offset debug_int, [esi].posy
                mov ecx, POSCNT
                and ecx, 3
                .if ecx == 0
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        div ebx
                .endif
                sub [esi].posx, eax

        .elseif ecx == 3 ;最右边跑道
                mov eax, base_speed
                add [esi].posy, eax
                mov ecx, POSCNT
                .if ecx & 3
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        div ebx
                .endif
                add [esi].posx, eax
        
        .elseif ecx == 0 ;左侧风景
                mov eax, base_speed
                add [esi].posy, eax
                mov ecx, POSCNT
                and ecx, 10
                .if ecx < 6
                        mov edx, 0
                        mov ebx, 2
                        mul ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        mul ebx
                .endif
                sub [esi].posx, eax

        .elseif ecx == 4 ;右侧风景
                mov eax, base_speed
                add [esi].posy, eax
                mov ecx, POSCNT
                and ecx, 10
                .if ecx == 0 
                        mov edx, 0
                        mov ebx, 2
                        mul ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        mul ebx
                .endif
                add [esi].posx, eax

        .elseif ecx == 6 ;中间跑道的子弹

                invoke rand
                mov ecx, eax
                mov eax, base_speed
                sub [esi].posy, eax
                ; and ecx, 100
                ; .if ecx == 0
                ;         mov edx, 0
                ;         mov ebx, 2
                ;         div ebx
                ;         add [esi].posx, eax
                ; .endif

        .elseif ecx == 5 ;左边跑道的子弹
                mov eax, base_speed
                sub [esi].posy, eax
                mov ecx, POSCNT
                and ecx, 100
                .if ecx 
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        div ebx
                .endif
                add [esi].posx, eax

        .elseif ecx == 7 ;右边跑道的子弹
                mov eax, base_speed
                sub [esi].posy, eax
                mov ecx, POSCNT
                and ecx, 80
                .if ecx 
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                .else 
                        mov edx, 0
                        mov ebx, 1
                        div ebx
                .endif
                sub [esi].posx, eax

        .endif
        ; .endif
        invoke rand
        ; 增大体积
        and eax, 2
        .if eax == 0
                mov eax, base_speed
                mov edx, 0
                mov ebx, 2
                div ebx
                mov ecx, [esi].course_id
                .if ecx != 5 && ecx != 6 && ecx != 7
                        add [esi].lengthx, eax
                        add [esi].lengthy, eax

                .else 
                        mov @TMP, eax
                        invoke rand
                        mov ecx, eax
                        and ecx, 2
                        .if ecx 
                                mov eax, @TMP
                                sub [esi].lengthx, eax
                                sub [esi].lengthy, eax
                        .endif
                .endif
        .endif
        assume  esi: nothing
        mov base_speed, 2
ret
_next_position endp 

_change_all_position proc stdcall       ;遍历所有道具改变位置
        ; inc POSCNT
        ; mov eax, POSCNT
        ; .if eax > 1024
        ;         mov POSCNT, 0
        ; .endif

        .if speed_acc_time 
                dec speed_acc_time
        .elseif speed_dec_time  
                dec speed_dec_time
        .else
                mov speed, 2
        .endif

        mov eax, speed
        mov edx, 0
        mov ebx, 0
        mul ebx
        mov ecx, eax
        push ecx
        invoke rand
        pop ecx
        and eax, ecx
        .if eax == 0 
                mov ecx, target_number
                xor eax, eax
                .while eax < ecx
                        push eax
                        mov edx, 0
                        mov ebx, sizeofTargets
                        mul ebx
                        lea esi, targets[eax]
                        assume esi :ptr Targets
                        .if [esi].base.alive == 1
                                invoke _next_position, addr [esi].base
                        .endif
                        assume  esi: nothing
                        pop eax
                        inc eax
                .endw
                ; 移动子弹
                lea esi, bullet
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        invoke _next_position, addr [esi].base
                .endif
                assume  esi: nothing
        .endif
ret
_change_all_position endp
_targets_bullet_out_of_bound proc
        ; 判断道具越界
        mov ecx, target_number
        xor eax, eax
        .while eax < ecx
                push eax
                mov edx, 0
                mov ebx, sizeofTargets
                mul ebx
                lea esi, targets[eax]
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        ; invoke printf, debug_int, [esi].base.posy
                        .if [esi].base.posx <= 10 || [esi].base.posx >= gameW-100 \
                        || [esi].base.posy <= 10 || [esi].base.posy >= gameH-130
                                mov [esi].base.alive, 0
                        .endif
                .endif
                assume esi: nothing
                pop eax
                inc eax
        .endw

        ; 判断子弹越界
        .if bullet.base.alive == 1
                .if bullet.base.posx <= 10 || bullet.base.posx >= gameW-100 \
                || bullet.base.posy <= 10 || bullet.base.posy >= gameW-130
                        mov bullet.base.alive, 0
                .endif
                .if bullet.base.posy < 230
                        mov bullet.base.alive, 0
                .endif
        .endif
ret

_targets_bullet_out_of_bound endp

;聚餐
_hotpot_effect proc stdcall ptrPlayerOne:ptr Subject, ptrPlayerTwo:ptr Subject

        ; Immunity        equ 100 ;免疫期
        ; Exposure        equ 101 ;暴露期
        ; Asymptomatic    equ 102 ;无症状
        ; Infection       equ 103 ;感染期

        ; 显示一个图像


        mov esi, ptrPlayerOne
        assume  esi: ptr Subject 
        mov ecx, ptrPlayerTwo
        assume  ecx: ptr Subject 

        mov [esi].has_hotpot, time_3s
        mov [ecx].has_hotpot, time_3s
        mov eax, [esi].status
        mov ebx, [ecx].status

        .if eax == 101 && ebx == 102
                inc [esi].score
                mov [esi].status, 102
        .elseif eax == 101 && ebx == 103
                dec [esi].base.alive
                mov [esi].status, 103
        .elseif eax == 102 && ebx == 103
                dec [esi].base.alive
                mov [esi].status, 103
        .endif

        assume esi: nothing
        assume ecx: nothing
ret
_hotpot_effect endp


;口罩
_mask_effect proc stdcall ptrPlayerOne:ptr Subject, ptrPlayerTwo:ptr Subject

        mov esi, ptrPlayerTwo
        assume  esi: ptr Subject 
        mov [esi].has_mask, time_3s
        assume esi: nothing

ret
_mask_effect endp


;测温计
_fever_effect proc stdcall ptrPlayerOne:ptr Subject, ptrPlayerTwo:ptr Subject
        
        mov esi, ptrPlayerTwo
        assume  esi: ptr Subject 
        mov [esi].has_fever, time_3s
        assume esi: nothing

ret
_fever_effect endp


_check_player_effect proc stdcall ptrPlayer:ptr Subject
        mov esi, ptrPlayer
        assume  esi: ptr Subject 

        mov eax, [esi].has_hotpot
        .if eax > 0
                dec [esi].has_hotpot
        .endif
        mov eax, [esi].has_mask
        .if eax > 0
                dec [esi].has_mask
        .endif
        mov eax, [esi].has_fever
        .if eax > 0
                dec [esi].has_fever
        .endif
        assume esi: nothing
ret
_check_player_effect endp

_check_all_effect proc stdcall ptrPlayerOne:ptr Subject, ptrPlayerTwo:ptr Subject
        invoke _check_player_effect, ptrPlayerOne
        invoke _check_player_effect, ptrPlayerTwo
ret
_check_all_effect endp

;状态的自动转换
_change_status proc stdcall ptrPlayerOne:ptr Subject, ptrPlayerTwo:ptr Subject

        mov eax, change_two_status_cnt
        .if eax == 0 
                mov esi, ptrPlayerOne
                assume  esi: ptr Subject 
                mov ecx, ptrPlayerTwo
                assume  ecx: ptr Subject 
                
                mov [esi].status, 101
                mov [ecx].status, 101
                mov change_two_status_cnt, time_5s
        .else
                dec change_two_status_cnt
        .endif

ret
_change_status endp


_change_all_position_symbiotic proc stdcall       ; 双人模式遍历所有道具改变位置

        ; inc POSCNT
        ; mov eax, POSCNT
        ; .if eax > 1024
        ;         mov POSCNT, 0
        ; .endif
        inc TESTCNT

        mov eax, speed
        mov edx, 0
        mov ebx, 0
        mul ebx
        mov ecx, eax
        push ecx
        invoke rand
        pop ecx
        and eax, ecx
        .if eax == 0 

                mov ecx, target_number_one
                xor eax, eax
                .while eax < ecx
                        push eax
                        mov edx, 0
                        mov ebx, sizeofTargets
                        mul ebx
                        lea esi, targetsOne[eax]
                        assume esi :ptr Targets
                        .if [esi].base.alive == 1
                                invoke _next_position, addr [esi].base
                        .endif
                        assume  esi: nothing
                        pop eax
                        inc eax
                .endw

                mov ecx, target_number_two
                xor eax, eax
                .while eax < ecx
                        push eax
                        mov edx, 0
                        mov ebx, sizeofTargets
                        mul ebx
                        lea esi, targetsTwo[eax]
                        assume esi :ptr Targets
                        .if [esi].base.alive == 1
                                invoke _next_position, addr [esi].base
                        .endif
                        assume  esi: nothing
                        pop eax
                        inc eax
                .endw
                ; 移动子弹
                lea esi, bulletOne
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        invoke _next_position, addr [esi].base
                .endif
                assume  esi: nothing

                lea esi, bulletTwo
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        invoke _next_position, addr [esi].base
                .endif
                assume  esi: nothing
        .endif
ret
_change_all_position_symbiotic endp

_targets_bullet_out_of_bound_symbiotic proc
        ; 判断道具越界
        mov ecx, target_number_one
        xor eax, eax
        .while eax < ecx
                push eax
                mov edx, 0
                mov ebx, sizeofTargets
                mul ebx
                lea esi, targetsOne[eax]
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        ; invoke printf, debug_int, [esi].base.posy
                        .if [esi].base.posx <= 10 || [esi].base.posx >= gameW-100 \
                        || [esi].base.posy <= 10 || [esi].base.posy >= gameH-130
                                mov [esi].base.alive, 0
                        .endif
                .endif
                assume esi: nothing
                pop eax
                inc eax
        .endw

        mov ecx, target_number_two
        xor eax, eax
        .while eax < ecx
                push eax
                mov edx, 0
                mov ebx, sizeofTargets
                mul ebx
                lea esi, targetsTwo[eax]
                assume esi :ptr Targets
                .if [esi].base.alive == 1
                        ; invoke printf, debug_int, [esi].base.posy
                        .if [esi].base.posx <= 10 || [esi].base.posx >= gameW-100 \
                        || [esi].base.posy <= 10 || [esi].base.posy >= gameH-130
                                mov [esi].base.alive, 0
                        .endif
                .endif
                assume esi: nothing
                pop eax
                inc eax
        .endw

        ; 判断子弹越界
        .if bulletOne.base.alive == 1
                .if bulletOne.base.posx <= 10 || bulletOne.base.posx >= gameW-100 \
                || bulletOne.base.posy <= 10 || bulletOne.base.posy >= gameW-130
                        mov bulletOne.base.alive, 0
                .endif
                .if bulletOne.base.posy < 230
                        mov bulletOne.base.alive, 0
                .endif
        .endif
        
        .if bulletTwo.base.alive == 1
                .if bulletTwo.base.posx <= 10 || bulletTwo.base.posx >= gameW-100 \
                || bulletTwo.base.posy <= 10 || bulletTwo.base.posy >= gameW-130
                        mov bulletTwo.base.alive, 0
                .endif
                .if bulletTwo.base.posy < 230
                        mov bulletTwo.base.alive, 0
                .endif
        .endif
ret

_targets_bullet_out_of_bound_symbiotic endp






; start:
;         ret
; end start
end
