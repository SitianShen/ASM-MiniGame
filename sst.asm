.386
.model flat, stdcall
option casemap: none

include global.inc

.code
_Init_car proc uses ebx

    mov ebx, 2
    mov player.base.course_id, ebx
    mov player.base.alive, ebx

    xor ebx, ebx
    mov player.base.rel_v, ebx
    mov player.score, ebx

    mov eax, carx1
    mov player.base.posx, eax

    mov ebx, cary
    mov player.base.posy, ebx

    ret
;??????????????
_Init_car endp

;?????????????????
_Move_process proc uses ebx
        mov eax, flag_jump
        .if (eax == 1)
                .if (time_jump == 0);下降完毕，落地
                        mov ebx, stdtime_jump
                        mov time_jump, ebx

                        mov ebx, 0
                        mov flag_jump, ebx

                        mov eax, cary
                        mov player.base.posy, eax;回到原地
                        ret
                .endif

                .if(time_jump >= 50);高度没到继续跳起
                        mov eax, player.base.posy
                        dec eax
                        mov player.base.posy, eax
                .endif

                .if(time_jump < 50);高度到了，开始降落
                        mov eax, player.base.posy
                        inc eax
                        mov player.base.posy, eax
                .endif

                mov ebx, time_jump
                dec ebx
                mov time_jump, ebx ;时间没到不回原地
        .endif

        mov eax, flag_movleft
        .if (eax == 1)
                .if (time_mov == 0)
                        mov ebx, stdtime_mov
                        mov time_mov, ebx

                        mov ebx, 0
                        mov flag_movleft, ebx

                        ret
                .endif
                ;没移到足够时间（位置，此处设置移动时间和距离匹配）
                mov ebx, player.base.posx
                dec ebx
                mov player.base.posx, ebx

                mov ebx, time_mov
                dec ebx
                mov time_mov, ebx
        .endif

        mov eax, flag_movright
        .if (eax == 1)
                .if (time_mov == 0)
                        mov ebx, stdtime_mov
                        mov time_mov, ebx
                        
                        mov ebx, 0
                        mov flag_movright, ebx
                        ret
                .endif
                ;没移到足够时间（位置，此处设置移动时间和距离匹配）
                mov ebx, player.base.posx
                inc ebx
                mov player.base.posx, ebx

                mov ebx, time_mov
                dec ebx
                mov time_mov, ebx
        .endif
        ret
_Move_process endp


;???
_Action_left proc uses ebx
        mov     ebx, player.base.course_id
        .if (ebx == 1)
                ret
        .endif
        mov     ebx, 1
        mov     flag_movleft, ebx
        ret
_Action_left endp

;???
_Action_right proc uses ebx
        mov     ebx, player.base.course_id
        .if (ebx == 3)
               ret
        .endif
        mov     ebx, 1
        mov     flag_movright, ebx
        ret
_Action_right endp

;???
_Action_jump proc uses ebx
        mov     ebx, 1
        mov     flag_jump, ebx
        ret
_Action_jump endp

_sst_test proc
        invoke _Init_car
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy

        invoke _Action_jump
        invoke printf, offset szInt, player.base.posx
        invoke printf, offset szInt, player.base.posy

        mov esi, 250
        .while( esi > 0)
                invoke _Move_process
                invoke printf, offset szInt, player.base.posx
                invoke printf, offset szInt, player.base.posy
                dec esi
        .endw

        ; invoke _Action_left
        ; invoke printf, offset szInt, player.base.posx
        ; invoke printf, offset szInt, player.base.posy

        ; mov esi, 150
        ; .while( esi > 0)
                ; invoke _Move_process
                ; invoke printf, offset szInt, player.base.posx
                ; invoke printf, offset szInt, player.base.posy
                ; dec esi
        ; .endw   

        ; invoke _Action_right
        ; invoke printf, offset szInt, player.base.posx
        ; invoke printf, offset szInt, player.base.posy

        ; mov esi, 150
        ; .while( esi > 0)
                ; invoke _Move_process
                ; invoke printf, offset szInt, player.base.posx
                ; invoke printf, offset szInt, player.base.posy
                ; dec esi 
        ; .endw
        ret
_sst_test endp

;test
; start:
        ;  invoke  _sst_test
        ;  ret
; end start
end