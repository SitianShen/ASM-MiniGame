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
                and ecx, 100
                .if ecx == 0
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                        add [esi].posx, eax
                .endif

        .elseif ecx == 5 ;左边跑道的子弹
                mov eax, base_speed
                sub [esi].posy, eax
                mov ecx, POSCNT
                and ecx, 1
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
                and ecx, 1
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
                        sub [esi].lengthx, eax
                        sub [esi].lengthy, eax
                .endif
        .endif
        assume  esi: nothing
        mov base_speed, 2
ret
_next_position endp 

_change_all_position proc stdcall       ;遍历所有道具改变位置
        inc POSCNT
        mov eax, POSCNT
        .if eax > 1024
                mov POSCNT, 0
        .endif

        .if speed_acc_time 
                dec speed_acc_time
        .elseif speed_dec_time  
                dec speed_dec_time
        .else
                mov speed, 2
        .endif

        mov eax, speed
        mov edx, 0
        mov ebx, 4
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
        .endif
ret
_targets_bullet_out_of_bound endp

; start:
;         ret
; end start
end
