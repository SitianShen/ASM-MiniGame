.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc

.code

;zzl part #################################################################
_Init_bullet proc
        mov bullet.base.alive, 0
        ret
_Init_bullet endp

_initAll proc
        invoke _Init_car
        invoke _Init_bullet
        mov target_number, 0
        ret
_initAll endp

_random_object_gene proc
        local @id, @offs
        mov esi, offset targets
        mov ecx, target_number
        .while ecx != 0 
                dec ecx
                add esi, sizeofTargets
        .endw
        mov @offs, esi

        invoke rand
        mov @id, eax
        and eax, 7

        mov esi, @offs
        assume esi: ptr Targets
        .if eax == 0
                mov ebx, object_DC.env1
                mov [esi].typeid, OBJ_ENV
        .elseif eax == 1
                mov ebx, object_DC.env2
                mov [esi].typeid, OBJ_ENV
        .elseif eax == 2
                mov ebx, object_DC.env3
                mov [esi].typeid, OBJ_ENV
        .elseif eax == 3
                mov ebx, object_DC.sobs
                mov [esi].typeid, OBST_SOFT
        .elseif eax == 4
                mov ebx, object_DC.hobs
                mov [esi].typeid, OBST_HARD
        .elseif eax == 5
                mov ebx, object_DC.accp
                mov [esi].typeid, PROP_ACC_SELF
        .elseif eax == 6
                mov ebx, object_DC.decp
                mov [esi].typeid, PROP_DEC_SELF
        .elseif eax == 7
                mov ebx, object_DC.coin
                mov [esi].typeid, MONEY_1
        .endif
        mov [esi].base.DC, ebx

        mov eax, @id
        and eax, 7
        .if eax <= 2 
                invoke rand
                and eax, 4
        .else
                invoke rand
                and eax, 3
                .while eax == 0
                        invoke rand
                        and eax, 3
                .endw
        .endif
        mov esi, @offs
        assume esi: ptr Targets
        mov [esi].base.course_id, eax

        mov [esi].base.alive, 1
        mov [esi].base.lengthx, obj_init_lx
        mov [esi].base.lengthy, obj_init_ly
        mov eax, [esi].base.course_id
        mov [esi].base.posy, remote_y
        .if eax == 0
                mov [esi].base.posx, remote_x0
        .elseif eax == 1
                mov [esi].base.posx, remote_x5
        .elseif eax == 2
                mov [esi].base.posx, remote_x6
        .elseif eax == 3
                mov [esi].base.posx, remote_x7
        .elseif eax == 4
                mov [esi].base.posx, remote_x4
        .endif

        mov eax, target_number
        inc eax
        mov target_number, eax

        ret
_random_object_gene endp


_set_char_pos proc
        mov button_play.base.posx, 200
        mov button_play.base.posy, 235
        mov button_play.base.lengthx, button_play_LX
        mov button_play.base.lengthy, button_play_LY

        mov button_start.base.posx, 170
        mov button_start.base.posy, 340
        mov button_start.base.lengthx, button_start_LX
        mov button_start.base.lengthy, button_start_LY

        mov button_back.base.posx, 70
        mov button_back.base.posy, 180
        mov button_back.base.lengthx, button_back_LX/2
        mov button_back.base.lengthy, button_back_LY/2

        mov button_exit.base.posx, 80
        mov button_exit.base.posy, 260
        mov button_exit.base.lengthx, button_exit_LX/2
        mov button_exit.base.lengthy, button_exit_LY/2
        ret
_set_char_pos endp

_load_button proc button:ptr Button, p1, p2
        local @hDC, @pic
        invoke  GetDC, hWinMain
        mov     @hDC, eax

        mov ebx, button
        assume ebx :ptr Button
        invoke  CreateCompatibleDC, @hDC
        mov     [ebx].DC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     [ebx].DC_, eax

        invoke  LoadBitmap, hInstance, p1
        mov @pic, eax
        invoke SelectObject, [ebx].DC, @pic
        invoke DeleteObject, @pic
        
        invoke  LoadBitmap, hInstance, p2
        mov @pic, eax
        invoke SelectObject, [ebx].DC_, @pic
        invoke DeleteObject, @pic
        ret
_load_button endp

_load_common_pic proc DC, p1
        local   @hDC, @pic

        invoke  GetDC, hWinMain
        mov     @hDC, eax
        
        mov esi, DC
        assume esi :ptr dword
        invoke  CreateCompatibleDC, @hDC
        mov     [esi], eax

        invoke  LoadBitmap, hInstance, p1
        mov     @pic, eax ;load back
        
        invoke  SelectObject, [esi], @pic
        invoke  DeleteObject,  @pic
        ret
_load_common_pic endp

_createAll proc 
        local   @hDC, @hDCCircle, @hDCMask
        local   @hBmpBack, @hBmpObj1, @hBmpObj2, @hBmpObj3
        local   @hBmpGS, @hBmpGI
        local   @brush

        invoke  GetDC, hWinMain
        mov     @hDC, eax

        invoke  CreateCompatibleDC, @hDC
        mov     hDCGame, eax
        invoke  CreateCompatibleBitmap, @hDC, gameH, gameW
        mov     @hBmpBack, eax
        invoke  SelectObject, hDCGame, @hBmpBack ; set draw area to DC
        invoke  DeleteObject, @hBmpBack
;backgrounds
        invoke  _load_common_pic, addr backGround.DC_b, IDB_BACKG_BEGINING
        invoke  _load_common_pic, addr backGround.DC_i, IDB_BACKG_INTRO
        invoke  _load_common_pic, addr backGround.DC_pu, IDB_BACKG_PLAYU
        invoke  _load_common_pic, addr backGround.DC_pd, IDB_BACKG_PLAYD
        invoke  _load_common_pic, addr backGround.DC_e, IDB_BACKG_END
;�������� env obj
        invoke  _load_common_pic, addr object_DC.env1, IDB_OBJ1
        invoke  _load_common_pic, addr object_DC.env2, IDB_OBJ2
        invoke  _load_common_pic, addr object_DC.env3, IDB_OBJ3
        invoke  _load_common_pic, addr object_DC.sobs, IDB_PROP_ABSTSOFT
        invoke  _load_common_pic, addr object_DC.hobs, IDB_PROP_ABSTHARD
        invoke  _load_common_pic, addr object_DC.accp, IDB_PROP_ACC
        invoke  _load_common_pic, addr object_DC.decp, IDB_PROP_DEC
        invoke  _load_common_pic, addr object_DC.coin, IDB_PROP_MONEY
;��ʼ�����ؼ� button
        invoke _load_button, addr button_play,  IDB_BUTTON_PLAY_1,  IDB_BUTTON_PLAY_2
        invoke _load_button, addr button_start, IDB_BUTTON_START_1, IDB_BUTTON_START_2
        invoke _load_button, addr button_exit,  IDB_BUTTON_EXIT_1,  IDB_BUTTON_EXIT_2
        invoke _load_button, addr button_back,  IDB_BUTTON_BACK_1,  IDB_BUTTON_BACK_2

        invoke _set_char_pos
;set car
        invoke  _load_common_pic, addr player.base.DC, IDB_PLAYER
        invoke  _Init_car

;set prop

        invoke  ReleaseDC, hWinMain, @hDC
        ret 
_createAll endp

_deleteAll       proc

        invoke  DeleteDC, hDCBack
        invoke  DeleteDC, hDCGame
        ret
_deleteAll       endp

_Quit           proc
        
        invoke  KillTimer, hWinMain, ID_TIMER
        invoke  DestroyWindow, hWinMain
        invoke  PostQuitMessage, NULL
        invoke  _deleteAll
        ; invoke  DestroyMenu, hMenu
        ret
_Quit           endp

_draw_button proc button:ptr Button, hWnd, LX, LY
        local @mouse:POINT
        local @window:RECT
        local @chooseDC

        invoke	GetCursorPos,addr @mouse
        invoke  ScreenToClient, hWnd, addr @mouse

        mov esi, button
        assume esi :ptr Button
        
        mov eax, [esi].base.posx
        mov ebx, [esi].base.posy

        mov edx, [esi].DC
        mov [esi].is_click, 0
        .if (eax <= @mouse.x) && (ebx <= @mouse.y)
                add eax, [esi].base.lengthx
                add ebx, [esi].base.lengthy
                .if (eax >= @mouse.x) && (ebx >= @mouse.y)
                        mov edx, [esi].DC_
                        mov [esi].is_click, 1
                .endif
        .endif
        invoke  TransparentBlt, 
                hDCGame, 
                [esi].base.posx, [esi].base.posy, [esi].base.lengthx, [esi].base.lengthy, 
                edx, 0, 0, LX, LY, 16777215      
        ret
_draw_button endp

_move_object proc hWnd
        local @mouse:POINT
        local @window:RECT

        .if player.base.alive == 0 && cur_interface == in_game
                mov cur_interface, in_over
        .endif

        mov eax, cur_interface
        .if eax == in_begining 
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_b, 0, 0, 1000, 1000, SRCCOPY
                invoke  _draw_button, addr button_play, hWnd, button_play_LX, button_play_LY
                invoke  _draw_button, addr button_start, hWnd, button_start_LX, button_start_LY
        .elseif eax == in_game
                invoke _Move_process

                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_pd, 0, 0, 1000, 1000, SRCCOPY

;draw obj
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
                                push ecx
                                invoke  TransparentBlt, 
                                        hDCGame, 
                                        [esi].base.posx, [esi].base.posy, 
                                        [esi].base.lengthx, [esi].base.lengthy, 
                                        [esi].base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                                pop ecx
                        .endif
                        pop eax
                        inc eax
                .endw
;draw car
                invoke  TransparentBlt, hDCGame, player.base.posx, player.base.posy, player.base.lengthx, player.base.lengthy, player.base.DC, 0, 0, PLAYER_LX, PLAYER_LY, 16777215

                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_pu, 0, 0, 1000, 1000, 16777215
        
        .elseif eax == in_intro
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_i, 0, 0, 1000, 1000, SRCCOPY
                invoke  _draw_button, addr button_back, hWnd, button_back_LX, button_back_LY
        .elseif eax == in_over
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_e, 0, 0, 1000, 1000, SRCCOPY
                invoke  _draw_button, addr button_exit, hWnd, button_exit_LX, button_exit_LY

        .endif
;         mov eax, object1H
;         mov ebx, object1W
;         inc eax
;         inc ebx
;         cmp eax, object1H_end
;         jl continue
;         cmp ebx, object1W_end
;         jl continue
;         mov eax, object1H_begin
;         mov ebx, object1W_begin
; continue:
;         mov object1H, eax
;         mov object1W, ebx
;         ; invoke  StretchBlt, hDCGame, 100, 100, eax, ebx, 
;         ;                     hDCObj1, 0,  0,  object1H_init, object1W_init, SRCCOPY
;         invoke  TransparentBlt, hDCGame, 10, 10, eax, ebx, 
;                                 env_objecet_3.DC, 0,  0,  object1H_init, object1W_init, 16777215
        ret
_move_object endp



; start:
;         ; call    _WinMain
;         ; invoke  ExitProcess, NULL
        
;         ; invoke _collision_test
;         ; invoke _two_two_enum_test
;         ret
; end     start
end