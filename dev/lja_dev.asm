.386
.model flat, stdcall
option casemap: none

include global_dev.inc

extrn player:Subject         
extrn bullet:Subject             
extrn targets:dword ;不知道会不会有bug，本地调试很正常

;zzl own
extrn button_play:Button      
extrn button_start:Button      
extrn button_back:Button      
extrn button_exit:Button       
extrn backGround:BackGround       
extrn object_DC:Object_DC        

extrn hInstance:dword       
extrn hWinMain:dword      
extrn hDCBack:dword         
extrn hDCGame:dword         
extrn hDCObj1:dword        
extrn dwNowBack:dword     

extrn flag_jump:dword               
extrn flag_movleft:dword          
extrn flag_movright:dword           
extrn stdtime_jump:dword            
extrn time_jump:dword              
extrn stdtime_mov:dword             
extrn time_mov:dword             
extrn cur_interface:dword     

extrn target_number:dword       
extrn speed:dword

extrn object1H:dword   
extrn object1W:dword      
extrn object_move_v:dword   
extrn POSCNT:dword          ; NEXTPOS的计数器

.code
;speed = 2 —— 正常， 4 —— 快速， 8 —— 超快速
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
        ; .if eax & 10 == 0
        .if ecx == 2 ;正中间跑道
                invoke rand
                mov ecx, eax
                mov eax, speed
                add [esi].posy, eax
                and ecx, 100
                .if ecx == 0
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                        sub [esi].posx, eax
                .endif

        .elseif ecx == 1 ;最左边跑道

                mov eax, speed
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
                mov eax, speed
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
                mov eax, speed
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
                mov eax, speed
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
                mov eax, speed
                sub [esi].posy, eax
                and ecx, 100
                .if ecx == 0
                        mov edx, 0
                        mov ebx, 2
                        div ebx
                        add [esi].posx, eax
                .endif

        .elseif ecx == 5 ;左边跑道的子弹
                mov eax, speed
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
                mov eax, speed
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
        and eax, 8
        .if eax == 0
                mov eax, speed
                mov edx, 0
                mov ebx, 2
                div ebx
                .if ecx != 5 && ecx != 6 && ecx != 7
                        add [esi].lengthx, eax
                        add [esi].lengthy, eax

                .else 
                        sub [esi].lengthx, eax
                        sub [esi].lengthy, eax
                .endif
        .endif
        assume  esi: nothing
ret
_next_position endp 

_change_all_position proc stdcall       ;遍历所有道具改变位置
        inc POSCNT
        mov eax, POSCNT
        .if eax > 1024
                mov POSCNT, 0
        .endif
        invoke rand
        and eax, 8
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
                        || [esi].base.posy <= 10 || [esi].base.posy >= gameH-200
                                mov [esi].base.alive, 0
                        .endif
                .endif
                assume esi: nothing
                pop eax
                inc eax
        .endw

        ; 判断子弹越界
        .if bullet.base.alive == 1
                .if bullet.base.posx <= 380 || bullet.base.posx >= gameW-100 \
                || bullet.base.posy <= 380 || bullet.base.posy >= gameW-200
                        mov bullet.base.alive, 0
                .endif
        .endif
ret
_targets_bullet_out_of_bound endp

end
