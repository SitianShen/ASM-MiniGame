.386
.model flat, stdcall
option casemap: none

include global.inc
.code
;speed = 4 —— 正常， 8 —— 快速， 12 —— 超快速
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
                mov ebx, 1
                div ebx
                sub [esi].posx, eax

        .elseif ecx == 3 ;最右边跑道
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 1
                div ebx
                add [esi].posx, eax
        
        .elseif ecx == 0 ;左侧风景
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 2
                mul ebx
                sub [esi].posx, eax

        .elseif ecx == 4 ;右侧风景
                mov eax, speed
                add [esi].posy, eax
                mov edx, 0
                mov ebx, 2
                mul ebx
                add [esi].posx, eax

        .elseif ecx == 6 ;中间跑道的子弹
                mov eax, speed
                sub [esi].posy, eax

        .elseif ecx == 5 ;左边跑道的子弹
                mov eax, speed
                sub [esi].posy, eax
                mov edx, 0
                mov ebx, 1
                div ebx
                add [esi].posx, eax

        .elseif ecx == 7 ;右边跑道的子弹
                mov eax, speed
                sub [esi].posy, eax
                mov edx, 0
                mov ebx, 1
                div ebx
                sub [esi].posx, eax

        .endif
        mov eax, POSCNT

        .if eax & 0001h
                mov eax, speed
                mov edx, 0
                mov ebx, 4
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
NextPos endp 

ChangeAllPos proc stdcall       ;遍历所有道具改变位置
        mov ebx, target_number
        xor eax, eax
        .while eax < target_number
                lea esi, targets[eax]
                invoke NextPos, esi
                inc eax
        .endw
ret
ChangeAllPos endp

end