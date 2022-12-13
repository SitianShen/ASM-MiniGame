.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc

.code

_Init_car proc uses ebx

    mov ebx, 2
    mov player.base.course_id, ebx
    mov player.base.alive, 1

    xor ebx, ebx
    mov player.base.rel_v, ebx
    mov player.score, ebx

    mov eax, carx1
    mov player.base.posx, eax

    mov ebx, cary
    mov player.base.posy, ebx

    mov player.base.lengthx, carLX
    mov player.base.lengthy, carLY

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

                .if(time_jump >= 25);高度没到继续跳起
                        mov eax, player.base.posy
                        sub eax, 5
                        mov player.base.posy, eax
                .endif

                .if(time_jump < 25);高度到了，开始降落
                        mov eax, player.base.posy
                        add eax, 5
                        mov player.base.posy, eax
                .endif

                mov ebx, time_jump
                dec ebx
                mov time_jump, ebx ;时间没到不回原地
        .endif

        ;ecx存放targetX
        mov eax, flag_movleft
        .if (eax == 1)
                mov eax, player.base.course_id
                .if(eax==2)
                        mov ecx, carx1
                .elseif(eax==1)
                        mov ecx, carx0
                .endif

                .if(ecx < player.base.posx)
                        mov eax, move_speed
                        sub player.base.posx, eax
                .endif

                .if(ecx > player.base.posx)
                        mov eax, move_speed
                        add player.base.posx, eax
                .endif
        .endif

        mov eax, flag_movright
        .if (eax == 1)
                mov eax, player.base.course_id
                .if(eax==2)
                        mov ecx, carx1
                .elseif(eax==3)
                        mov ecx, carx2
                .endif

                .if(ecx < player.base.posx)
                        mov eax, move_speed
                        sub player.base.posx, eax
                .endif

                .if(ecx > player.base.posx)
                        mov eax, move_speed
                        add player.base.posx, eax
                .endif
        .endif
        ret
_Move_process endp


;???
_Action_left proc uses ebx
        mov     ebx, player.base.course_id
        .if (ebx == 1)
                ret
        .endif
        dec     ebx
        mov     player.base.course_id, ebx

        mov     flag_movleft, 1
        ret
_Action_left endp

;???
_Action_right proc uses ebx
        mov     ebx, player.base.course_id
        .if (ebx == 3)
               ret
        .endif
        inc     ebx
        mov     player.base.course_id, ebx

        mov     flag_movright, 1
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

;==================== 共生模式 ==========================

_Init_car_symbiotic proc uses ebx esi, mainPlayer:ptr Subject
        mov esi, mainPlayer
        assume esi:ptr Subject
        
        ;============= base结构体初始化 ==============
        mov ebx, 2
        mov [esi].base.course_id, ebx
        mov [esi].base.alive, 3

        xor ebx, ebx
        mov [esi].base.rel_v, ebx
        mov [esi].score, ebx

        mov eax, carx1
        mov [esi].base.posx, eax

        mov ebx, cary
        mov [esi].base.posy, ebx

        mov [esi].base.lengthx, carLX
        mov [esi].base.lengthy, carLY

        ;其余变量初始化
        mov [esi].score, 0                      ;分数起始为0
        mov [esi].status, Exposure              ;初始化为暴露期
        mov [esi].has_hotpot, 0                 ;不聚餐
        mov [esi].has_mask, 0                   ;不带口罩
        mov [esi].has_fever, 0                  ;不发热
        mov [esi].flag_movleft, 0               ;
        mov [esi].flag_movright,0               ;
        mov [esi].flag_jump,  0                 ;
        mov [esi].time_jump, 50                 ;
        mov [esi].time_mov,  10                 ;

        ret
_Init_car_symbiotic endp

_Move_process_symbiotic proc uses ebx esi eax ecx, mainPlayer:ptr Subject
        mov esi, mainPlayer
        assume esi:ptr Subject
        
        mov eax, [esi].flag_jump
        .if (eax == 1)
                .if [esi].time_jump == 0;下降完毕，落地
                        mov ebx, stdtime_jump
                        mov [esi].time_jump, ebx

                        mov ebx, 0
                        mov [esi].flag_jump, ebx

                        mov eax, cary
                        mov [esi].base.posy, eax;回到原地
                        ret
                .endif

                .if [esi].time_jump >= 25;高度没到继续跳起
                        mov eax, [esi].base.posy
                        sub eax, 5
                        mov [esi].base.posy, eax
                .endif

                .if [esi].time_jump < 25;高度到了，开始降落
                        mov eax, [esi].base.posy
                        add eax, 5
                        mov [esi].base.posy, eax
                .endif

                mov ebx, [esi].time_jump
                dec ebx
                mov [esi].time_jump, ebx ;时间没到不回原地
        .endif

        ;ecx存放targetX
        mov eax, [esi].flag_movleft
        .if (eax == 1)
                mov eax, [esi].base.course_id
                .if(eax==2)
                        mov ecx, carx1
                .elseif(eax==1)
                        mov ecx, carx0
                .endif

                .if ecx < [esi].base.posx
                        mov eax, move_speed
                        sub [esi].base.posx, eax
                .endif

                .if ecx > player.base.posx
                        mov eax, move_speed
                        add [esi].base.posx, eax
                .endif
        .endif

        mov eax, [esi].flag_movright
        .if (eax == 1)
                mov eax, [esi].base.course_id
                .if(eax==2)
                        mov ecx, carx1
                .elseif(eax==3)
                        mov ecx, carx2
                .endif

                .if ecx < [esi].base.posx
                        mov eax, move_speed
                        sub [esi].base.posx, eax
                .endif

                .if ecx > [esi].base.posx
                        mov eax, move_speed
                        add [esi].base.posx, eax
                .endif
        .endif
        ret
_Move_process_symbiotic endp


_Action_left_symbiotic proc uses ebx esi, mainPlayer:ptr Subject
        mov esi, mainPlayer
        assume esi:ptr Subject
        ; invoke printf, offset debug_int, [esi].base.course_id
        mov     ebx, [esi].base.course_id
        .if (ebx == 1)
                ret
        .endif
        dec     ebx
        mov     [esi].base.course_id, ebx

        mov     [esi].flag_movleft, 1
        ret
_Action_left_symbiotic endp

_Action_right_symbiotic proc uses ebx esi, mainPlayer:ptr Subject
        mov esi, mainPlayer
        assume esi:ptr Subject
        ; invoke printf, offset debug_int, [esi].base.course_id
        mov     ebx, [esi].base.course_id
        .if (ebx == 3)
               ret
        .endif
        inc     ebx
        mov     [esi].base.course_id, ebx

        mov     [esi].flag_movright, 1
        ret
_Action_right_symbiotic endp

_Action_jump_symbiotic proc uses ebx esi, mainPlayer:ptr Subject
        mov esi, mainPlayer
        assume esi:ptr Subject
        
        mov     ebx, 1
        mov     [esi].flag_jump, ebx
        ret
_Action_jump_symbiotic endp


_sst_test_symbiotic proc
        invoke _Init_car_symbiotic, addr playerOne
        invoke printf, offset szInt, playerOne.base.posx
        invoke printf, offset szInt, playerOne.base.posy

        invoke _Action_jump_symbiotic, addr playerOne
        invoke printf, offset szInt, playerOne.base.posx
        invoke printf, offset szInt, playerOne.base.posy

        mov esi, 5
        .while( esi > 0)
                invoke _Move_process_symbiotic, addr playerOne
                invoke printf, offset szInt, playerOne.base.posx
                invoke printf, offset szInt, playerOne.base.posy
                dec esi
        .endw

        ret
_sst_test_symbiotic endp

;================= 共生模式 ================

; test

; start:
;         ;  invoke  _sst_test
;         invoke _sst_test_symbiotic
;         ret
; end start
end