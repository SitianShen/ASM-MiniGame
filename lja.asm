.386
.model flat, stdcall
option casemap: none

include global.inc
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