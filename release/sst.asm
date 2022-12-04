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

        mov eax, flag_movleft
        .if (eax == 1)
                .if (time_mov == 0)
                        mov ebx, stdtime_mov
                        mov time_mov, ebx

                        mov ebx, 0
                        mov flag_movleft, ebx

                        ret
                .endif
                ;没移到足够时间（位置，此处设置移动时间和距离匹
                mov ebx, player.base.posx
                sub ebx, 5
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
                        
                        mov flag_movright, 0
                        ret
                .endif
                ;没移到足够时间（位置，此处设置移动时间和距离匹
                mov ebx, player.base.posx
                add ebx, 5
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

;test
; start:
        ;  invoke  _sst_test
        ;  ret
; end start
end