.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc

.code

;zzl part #################################################################
_save_game proc @player_ptr, @targets_ptr, @target_number_ptr, @fileName
        local @hFile, @tmp
        invoke CreateFile, @fileName, GENERIC_WRITE, 0, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
        mov @hFile, eax
        invoke WriteFile, @hFile, @player_ptr,  sizeof Subject, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp   
        invoke WriteFile, @hFile, @targets_ptr, 1000*sizeof Targets, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp   
        invoke WriteFile, @hFile, @target_number_ptr, sizeof dword, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp   
        invoke CloseHandle, @hFile
        ret
_save_game endp
_load_game proc @player_ptr, @targets_ptr, @target_number_ptr, @fileName
        local @hFile, @tmp
        invoke CreateFile, @fileName, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
        .if eax == INVALID_HANDLE_VALUE
                invoke printf, offset debug_int, 999   
                mov eax, 1
                ret
        .endif
        mov @hFile, eax
        invoke ReadFile, @hFile, @player_ptr,  sizeof Subject, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp   
        invoke ReadFile, @hFile, @targets_ptr, 1000*sizeof Targets, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp   
        invoke ReadFile, @hFile, @target_number_ptr, sizeof dword, addr @tmp, NULL
        ; invoke printf, offset debug_int, @tmp  
        invoke _typeid_to_picHandle, @targets_ptr, @target_number_ptr
        invoke CloseHandle, @hFile
        xor eax, eax
        ret
_load_game endp
_init_2p_players proc cur_player
        mov esi, cur_player
        assume esi: ptr Subject
        
        mov [esi].base.course_id, 2
        mov [esi].base.alive, 3
        mov [esi].score, 0

        mov [esi].base.rel_v, 0

        mov eax, carx1
        mov [esi].base.posx, eax

        mov ebx, cary
        mov [esi].base.posy, ebx

        mov [esi].base.lengthx, carLX
        mov [esi].base.lengthy, carLY
        ret
_init_2p_players endp

_init_2p_mode proc
        invoke _Init_car_symbiotic, offset playerOne
        invoke _Init_car_symbiotic, offset playerTwo
        mov target_number_one, 0
        mov target_number_two, 0
        mov playerList.curid, 0
        mov playerList2.curid, 0
        mov playerList.choose_confirm, 0
        mov playerList2.choose_confirm, 0
        
        ret
_init_2p_mode endp

_shot_bullet proc
        mov eax, bullet.base.alive
        .if eax == 1
                ret
        .endif
        mov eax, player.base.course_id
        add eax, 4 
        .if eax == 5
                mov ebx, object_DC.bltL
        .elseif eax == 6
                mov ebx, object_DC.bltM
        .elseif eax == 7
                mov ebx, object_DC.bltR
        .endif
        mov bullet.base.course_id, eax
        mov bullet.base.DC, ebx
        mov bullet.base.lengthx, bullet_init_lx
        mov bullet.base.lengthy, bullet_init_ly
        mov eax, player.base.posx
        add eax, carLX/2
        mov bullet.base.posx, eax
        mov eax, player.base.posy
        add eax, carLY/2
        mov bullet.base.posy, eax
        mov bullet.base.alive, 1
        ret
_shot_bullet endp
_Init_bullet proc
        mov bullet.base.alive, 0
        ret
_Init_bullet endp

_initAll proc
        invoke _Init_car
        mov player.score, 0
        mov player.base.alive, 3
        invoke _Init_bullet
        mov target_number, 0
        ret
_initAll endp

_random_object_gene proc @targets_ptr: ptr dword, @target_number_ptr: ptr dword
        local @id, @offs
        mov esi, @targets_ptr
        mov edi, @target_number_ptr
        mov ecx, [edi]
        .while ecx != 0 
                dec ecx
                add esi, sizeofTargets
        .endw
        mov @offs, esi

        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        and eax, 31

        .if eax > 26
                mov eax, 2
        .endif
        .if eax > 19
                mov eax, 1
        .endif
        .if eax > 12
                mov eax, 0
        .endif
        .if eax > 11
                mov eax, 7
        .endif
        .if eax > 9
                mov eax, 3
        .endif

        .if eax > 7
                mov eax, 4
        .endif

        mov @id, eax


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
                mov [esi].base.posx, remote_x1
        .elseif eax == 2
                mov [esi].base.posx, remote_x2
        .elseif eax == 3
                mov [esi].base.posx, remote_x3
        .elseif eax == 4
                mov [esi].base.posx, remote_x4
        .endif

        mov esi, @target_number_ptr
        assume esi:ptr dword
        inc [esi]

        ret
_random_object_gene endp


_random_object_gene_2p proc @targets_ptr: ptr dword, @target_number_ptr: ptr dword
        local @id, @offs
        mov esi, @targets_ptr
        mov edi, @target_number_ptr
        mov ecx, [edi]
        .while ecx != 0 
                dec ecx
                add esi, sizeofTargets
        .endw
        mov @offs, esi

        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        invoke rand
        and eax, 31

        .if eax > 26
                mov eax, 2
        .endif
        .if eax > 20
                mov eax, 1
        .endif
        .if eax > 14
                mov eax, 0
        .endif

        .if eax > 12
                mov eax, 3
        .endif

        .if eax > 10
                mov eax, 4
        .endif

        .if eax > 8
                mov eax, 5
        .endif

        mov @id, eax


        mov esi, @offs
        assume esi: ptr Targets
        .if eax == 0
                mov ebx, object_DC.env1
                mov [esi].typeid, env1
        .elseif eax == 1
                mov ebx, object_DC.env2
                mov [esi].typeid, env2
        .elseif eax == 2
                mov ebx, object_DC.env3
                mov [esi].typeid, env3
        .elseif eax == 3
                mov ebx, object_DC.medicine
                mov [esi].typeid, medicine
        .elseif eax == 4
                mov ebx, object_DC.redVirus
                mov [esi].typeid, redVirus
        .elseif eax == 5
                mov ebx, object_DC.greenVirus
                mov [esi].typeid, greenVirus
        .elseif eax == 6
                mov ebx, object_DC.hotPot
                mov [esi].typeid, hotPot
        .elseif eax == 7
                mov ebx, object_DC.n95mask
                mov [esi].typeid, n95mask
        .elseif eax == 8
                mov ebx, object_DC.temperature
                mov [esi].typeid, temperature
        .endif
        mov [esi].base.DC, ebx

        mov eax, @id
        ; and eax, 7
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
                mov [esi].base.posx, remote_x1
        .elseif eax == 2
                mov [esi].base.posx, remote_x2
        .elseif eax == 3
                mov [esi].base.posx, remote_x3
        .elseif eax == 4
                mov [esi].base.posx, remote_x4
        .endif

        mov esi, @target_number_ptr
        assume esi:ptr dword
        inc [esi]

        ret
_random_object_gene_2p endp


_set_char_pos proc
        mov button_play.base.posx, 100
        mov button_play.base.posy, 235
        mov button_play.base.lengthx, button_play_LX
        mov button_play.base.lengthy, button_play_LY

        mov button_start.base.posx, 300
        mov button_start.base.posy, 235
        mov button_start.base.lengthx, button_start_LX
        mov button_start.base.lengthy, button_start_LY

        mov button_back.base.posx, 410
        mov button_back.base.posy, 480
        mov button_back.base.lengthx, button_back_LX/2
        mov button_back.base.lengthy, button_back_LY/2

        mov button_exit.base.posx, 80
        mov button_exit.base.posy, 260
        mov button_exit.base.lengthx, button_exit_LX/2
        mov button_exit.base.lengthy, button_exit_LY/2


        mov button_retry.base.posx, 200
        mov button_retry.base.posy, 260
        mov button_retry.base.lengthx, button_retry_LX/2
        mov button_retry.base.lengthy, button_retry_LY/2

        mov button_pause.base.posx, 200
        mov button_pause.base.posy, 20
        mov button_pause.base.lengthx, button_pause_LX/2
        mov button_pause.base.lengthy, button_pause_LY/2

        mov button_2p_play.base.posx, 100
        mov button_2p_play.base.posy, 335
        mov button_2p_play.base.lengthx, button_2p_play_LX
        mov button_2p_play.base.lengthy, button_2p_play_LY

        mov button_load.base.posx, 300
        mov button_load.base.posy, 335
        mov button_load.base.lengthx, button_2p_load_LX
        mov button_load.base.lengthy, button_2p_load_LY

        
        mov button_save.base.posx, 222
        mov button_save.base.posy, 165
        mov button_save.base.lengthx, button_pause_rel_LX/3*2
        mov button_save.base.lengthy, button_pause_rel_LY/3*2
        
        mov button_continue.base.posx, 222
        mov button_continue.base.posy, 243
        mov button_continue.base.lengthx, button_pause_rel_LX/3*2
        mov button_continue.base.lengthy, button_pause_rel_LY/3*2
        
        mov button_changeR.base.posx, 222
        mov button_changeR.base.posy, 322
        mov button_changeR.base.lengthx, button_pause_rel_LX/3*2
        mov button_changeR.base.lengthy, button_pause_rel_LY/3*2

        mov button_left.base.posx, 410
        mov button_left.base.posy, 400
        mov button_left.base.lengthx, button_lr_LX
        mov button_left.base.lengthy, button_lr_LY

        mov button_right.base.posx, 490
        mov button_right.base.posy, 400
        mov button_right.base.lengthx, button_lr_LX
        mov button_right.base.lengthy, button_lr_LY
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

_load_pic_list proc stratptr, start, len
        mov esi, stratptr
        assume esi:ptr dword
        mov ecx, 0
        .while ecx < len
                push esi
                push ecx

                mov eax, start
                add eax, ecx
                invoke _load_common_pic, esi, eax

                pop ecx
                pop esi
                add esi, 4
                add ecx, 1
        .endw
        ret
_load_pic_list endp
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

        invoke  CreateCompatibleDC, @hDC
        mov     hDCGame2, eax
        invoke  CreateCompatibleBitmap, @hDC, gameH, gameW
        mov     @hBmpBack, eax
        invoke  SelectObject, hDCGame2, @hBmpBack ; set draw area to DC
        invoke  DeleteObject, @hBmpBack
;backgrounds
        invoke  _load_common_pic, addr backGround.DC_b, IDB_BACKG_BEGINING
        invoke  _load_common_pic, addr backGround.DC_i, IDB_BACKG_INTRO
        invoke  _load_common_pic, addr backGround.DC_i2, IDB_BACKG_INTRO2
        invoke  _load_common_pic, addr backGround.DC_i3, IDB_BACKG_INTRO3
        invoke  _load_common_pic, addr backGround.DC_pu, IDB_BACKG_PLAYU
        invoke  _load_common_pic, addr backGround.DC_pd, IDB_BACKG_PLAYD
        invoke  _load_common_pic, addr backGround.DC_e, IDB_BACKG_END
        invoke  _load_common_pic, addr backGround.DC_2p_c, IDB_BACKG_2p_CHOOSE
        invoke  _load_common_pic, addr backGround.DC_2p_cc, IDB_BACKG_2p_CHOOSECONFIRM
;�������� env obj
;set prop
        invoke  _load_common_pic, addr object_DC.env1, IDB_OBJ1
        invoke  _load_common_pic, addr object_DC.env2, IDB_OBJ2
        invoke  _load_common_pic, addr object_DC.env3, IDB_OBJ3
        invoke  _load_common_pic, addr object_DC.sobs, IDB_PROP_ABSTSOFT
        invoke  _load_common_pic, addr object_DC.hobs, IDB_PROP_ABSTHARD
        invoke  _load_common_pic, addr object_DC.accp, IDB_PROP_ACC
        invoke  _load_common_pic, addr object_DC.decp, IDB_PROP_DEC
        invoke  _load_common_pic, addr object_DC.coin, IDB_PROP_MONEY
        invoke  _load_common_pic, addr object_DC.hp_p, IDB_HPP
        invoke  _load_common_pic, addr object_DC.bltL, IDB_PROP_BULLETL
        invoke  _load_common_pic, addr object_DC.bltM, IDB_PROP_BULLETM
        invoke  _load_common_pic, addr object_DC.bltR, IDB_PROP_BULLETR  ;
;2p new 
        invoke  _load_common_pic, addr object_DC.medicine, IDB_medicine  
        invoke  _load_common_pic, addr object_DC.redVirus, IDB_redVirus  
        invoke  _load_common_pic, addr object_DC.greenVirus, IDB_greenVirus  
        invoke  _load_common_pic, addr object_DC.hotPot, IDB_hotPot  
        invoke  _load_common_pic, addr object_DC.n95mask, IDB_n95mask  
        invoke  _load_common_pic, addr object_DC.temperature, IDB_temperature 
        invoke  _load_common_pic, addr object_DC.eathotpot, IDB_eathotpot
;special effect   
        invoke  _load_common_pic, addr object_DC.soft_inf, IDB_SPE_SOFT_INFECT
        invoke  _load_common_pic, addr object_DC.infected, IDB_SPE_INFECT  
        invoke  _load_common_pic, addr object_DC.cant_inf, IDB_SPE_CANT_INFECT  
;pause window
        invoke  _load_common_pic, addr object_DC.pauw, IDB_PAUSE_WINDOW      

;��ʼ�����ؼ� button
        invoke _load_button, addr button_play,  IDB_BUTTON_PLAY_1,  IDB_BUTTON_PLAY_2
        invoke _load_button, addr button_start, IDB_BUTTON_START_1, IDB_BUTTON_START_2
        invoke _load_button, addr button_exit,  IDB_BUTTON_EXIT_1,  IDB_BUTTON_EXIT_2
        invoke _load_button, addr button_back,  IDB_BUTTON_BACK_1,  IDB_BUTTON_BACK_2
        invoke _load_button, addr button_retry,  IDB_BUTTON_RETRY_1,  IDB_BUTTON_RETRY_2
        invoke _load_button, addr button_pause,  IDB_BUTTON_PAUSE_1,  IDB_BUTTON_PAUSE_2
        invoke _load_button, addr button_2p_play,IDB_BUTTON_2p_PLAY_1,  IDB_BUTTON_2p_PLAY_2
        invoke _load_button, addr button_load, IDB_BUTTON_2p_LOAD_1,  IDB_BUTTON_2p_LOAD_2
        invoke _load_button, addr button_save, IDB_BUTTON_SAVE_1,  IDB_BUTTON_SAVE_2
        invoke _load_button, addr button_continue, IDB_BUTTON_CONTINUE_1,  IDB_BUTTON_CONTINUE_2
        invoke _load_button, addr button_changeR, IDB_BUTTON_CHANGER_1,  IDB_BUTTON_CHANGER_2
        invoke _load_button, addr button_left, IDB_BUTTON_LEFT_1,  IDB_BUTTON_LEFT_2
        invoke _load_button, addr button_right, IDB_BUTTON_RIGHT_1,  IDB_BUTTON_RIGHT_2
        invoke _set_char_pos
;set car
        invoke  _load_common_pic, addr player.base.DC, IDB_PLAYER
        invoke  _Init_car
;load digital
        invoke _load_pic_list, offset digitals_DC, IDB_DIG0, 10

;load pic cars for choise
        invoke _load_pic_list, offset playerList.DC, IDB_PLAYER1_1, player_pic_number*2
        invoke _load_pic_list, offset playerList2.DC, IDB_PLAYER1_1, player_pic_number*2

        mov playerList.curid, 0
;end
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

_check_button proc button:ptr Button, hWnd
        local @mouse:POINT
        local @window:RECT
        local @result
        invoke	GetCursorPos,addr @mouse
        invoke  ScreenToClient, hWnd, addr @mouse

        mov esi, button
        assume esi :ptr Button

        mov eax, [esi].base.posx
        mov ebx, [esi].base.posy

        mov @result, 0
        .if (eax <= @mouse.x) && (ebx <= @mouse.y)
                add eax, [esi].base.lengthx
                add ebx, [esi].base.lengthy
                .if (eax >= @mouse.x) && (ebx >= @mouse.y)
                        mov @result, 1
                .endif
        .endif
        mov eax, @result
        ret
_check_button endp

_draw_button proc button:ptr Button, hWnd, LX, LY, hDCGame_ptr
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
                hDCGame_ptr, 
                [esi].base.posx, [esi].base.posy, [esi].base.lengthx, [esi].base.lengthy, 
                edx, 0, 0, LX, LY, 16777215 
        ret
_draw_button endp

_show_score proc hDCGame_ptr, @player
        local @digit

        mov ecx, scoreBoard_lst_X
        mov edx, scoreBoard_lst_Y
        
        mov esi, @player
        assume esi: ptr Subject
        mov eax, [esi].score
        .repeat
                push ecx
                push edx

                xor edx, edx
                mov ecx, 10
                div ecx
                mov @digit, edx

                pop edx
                pop ecx
                push ecx
                push edx
                push eax

                mov esi, @digit
                invoke  TransparentBlt, 
                        hDCGame_ptr, ecx, edx, scoreBoard_dig_LX, scoreBoard_dig_LY, 
                        [digitals_DC+4*esi], 0, 0, DIG_LX, DIG_LY, 16777215

                pop eax
                pop edx
                pop ecx

                sub ecx, scoreBoard_each_LX
        .until eax <= 0   
        ret
_show_score endp

_show_lifes proc hDCGame_ptr, player_addr
        local @digit

        mov esi, player_addr
        assume esi:ptr Subject

        mov ecx, res_live_X
        mov edx, res_live_Y
        
        mov eax, [esi].base.alive
        .repeat
                push ecx
                push edx

                xor edx, edx
                mov ecx, 10
                div ecx
                mov @digit, edx

                pop edx
                pop ecx
                push ecx
                push edx
                push eax

                mov esi, @digit
                invoke  TransparentBlt, 
                        hDCGame_ptr, ecx, edx, res_live_LX, res_live_LY, 
                        [digitals_DC+4*esi], 0, 0, DIG_LX, DIG_LY, 16777215

                pop eax
                pop edx
                pop ecx

                sub ecx, res_live_LX
        .until eax <= 0 

        ret
_show_lifes endp

_draw_final_score proc hDCGame_ptr
        local @digit

        mov ecx, fscoreBoard_lst_X
        mov edx, fscoreBoard_lst_Y
        
        mov eax, player.score
        .repeat
                push ecx
                push edx

                xor edx, edx
                mov ecx, 10
                div ecx
                mov @digit, edx

                pop edx
                pop ecx
                push ecx
                push edx
                push eax

                mov esi, @digit
                invoke  TransparentBlt, 
                        hDCGame_ptr, ecx, edx, fscoreBoard_dig_LX, fscoreBoard_dig_LY, 
                        [digitals_DC+4*esi], 0, 0, DIG_LX, DIG_LY, 16777215

                pop eax
                pop edx
                pop ecx

                sub ecx, scoreBoard_each_LX
        .until eax <= 0      
        ret
_draw_final_score endp

_draw_player_choose proc hDCGame_ptr
        local @choise

        lea esi, offset playerList.DC
        mov edi, playerList.curid
        mov eax, hDCGame_ptr
        .if eax == hDCGame2
                lea esi, offset playerList2.DC
                mov edi, playerList2.curid
        .endif
        mov @choise, edi
        assume esi:ptr dword

        mov eax, player_pic_choose_X
        mov ebx, player_pic_choose_Y

        mov ecx, 0
        .while ecx < player_pic_number*2
                push esi
                push ecx
                push ebx
                push eax

                .if ecx == @choise
                        add esi, 4
                .endif

                invoke  TransparentBlt, 
                        hDCGame_ptr, eax, ebx, player_pic_choose_LX, player_pic_choose_LX, 
                        [esi], 0, 0, PROP_LX, PROP_LY, 16777215

                pop eax
                pop ebx
                pop ecx
                pop esi

                add esi, 4*2
                add ecx, 1
                add eax, player_pic_choose_each_LX
        .endw
        ret
_draw_player_choose endp

_draw_object proc hWnd, hDCGame_ptr, player_addr: ptr Subject, @targets_ptr: ptr Targets, @target_number
        
        
        local @mouse:POINT
        local @window:RECT

        .if player.base.alive == 0 && cur_interface == in_game
                invoke _Stop_BGM_SOUND
                invoke _Gameover_SOUND
                invoke _Stop_Gameover_SOUND
                invoke _END_SOUND
                mov cur_interface, in_over
        .endif

        mov eax, cur_interface
        .if eax == in_begining 
                mov eax, hWnd
                .if eax == hWinMain
                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_b, 0, 0, 1000, 1000, SRCCOPY
                        invoke  _draw_button, addr button_play, hWnd, button_play_LX, button_play_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_2p_play, hWnd, button_2p_play_LX, button_2p_play_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_start, hWnd, button_start_LX, button_start_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_load, hWnd, button_2p_load_LX, button_2p_load_LY, hDCGame_ptr
                .endif
        .elseif eax == in_game
                mov eax, hWnd
                .if eax == hWinMain
                        invoke _Move_process

                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_pd, 0, 0, 1000, 1000, SRCCOPY
        ;draw pause
                        invoke  _draw_button, addr button_pause, hWnd, button_pause_LX, button_pause_LY, hDCGame_ptr
        ;draw hp

                        invoke  TransparentBlt, 
                                hDCGame_ptr, 
                                HP_place_X, HP_place_Y,
                                HP_place_LX, HP_place_LY, 
                                object_DC.hp_p, 0, 0, PROP_LX, PROP_LY, 16777215

                        invoke _show_lifes, hDCGame_ptr, player_addr
        ;draw obj 1
                        mov ecx, target_number
                        xor eax, eax
                        .while eax < ecx
                                push eax
                                mov edx, 0
                                mov ebx, sizeofTargets
                                mul ebx
                                lea esi, targets[eax]
                                assume esi :ptr Targets
                                push edx
                                mov edx, [esi].base.posy
                                .if [esi].base.alive == 1 && edx<cary
                                        push ecx
                                        mov edx, [esi].base.posy
                                        .if edx > remote_y+10
                                                invoke  TransparentBlt, 
                                                        hDCGame_ptr, 
                                                        [esi].base.posx, [esi].base.posy, 
                                                        [esi].base.lengthx, [esi].base.lengthy, 
                                                        [esi].base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                                        .endif
                                        pop ecx
                                .endif
                                pop edx
                                pop eax
                                inc eax
                        .endw
        ;draw car
                        invoke  TransparentBlt, hDCGame_ptr, player.base.posx, player.base.posy, player.base.lengthx, player.base.lengthy, player.base.DC, 0, 0, PLAYER_LX, PLAYER_LY, 16777215

        ;draw obj 1
                        mov ecx, target_number
                        xor eax, eax
                        .while eax < ecx
                                push eax
                                mov edx, 0
                                mov ebx, sizeofTargets
                                mul ebx
                                lea esi, targets[eax]
                                assume esi :ptr Targets
                                push edx
                                mov edx, [esi].base.posy
                                .if [esi].base.alive == 1 && edx>cary
                                        push ecx
                                        invoke  TransparentBlt, 
                                                hDCGame_ptr, 
                                                [esi].base.posx, [esi].base.posy, 
                                                [esi].base.lengthx, [esi].base.lengthy, 
                                                [esi].base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                                        pop ecx
                                .endif
                                pop edx
                                pop eax
                                inc eax
                        .endw
        ;draw bullet
                        mov eax, bullet.base.alive
                        .if eax == 1
                                invoke  TransparentBlt, 
                                        hDCGame_ptr, 
                                        bullet.base.posx, bullet.base.posy, 
                                        bullet.base.lengthx, bullet.base.lengthy, 
                                        bullet.base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                        .endif

                        ; invoke        GetLastError
                        ; invoke printf, offset debug_int, eax   

                        invoke _show_score, hDCGame_ptr, addr player
                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_pu, 0, 0, 1000, 1000, 16777215
                .endif
        .elseif eax == in_intro
                mov eax, hWnd
                .if eax == hWinMain
                        mov eax, intro_id
                        .if eax == 0
                                invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_i, 0, 0, 1000, 1000, SRCCOPY
                        .elseif eax == 1
                                invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_i2, 0, 0, 1000, 1000, SRCCOPY
                        .elseif  eax == 2
                                invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_i3, 0, 0, 1000, 1000, SRCCOPY
                        .endif

                        invoke  _draw_button, addr button_back, hWnd, button_back_LX, button_back_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_left, hWnd, button_lr_LX, button_lr_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_right, hWnd, button_lr_LX, button_lr_LY, hDCGame_ptr

                .endif
        .elseif eax == in_over
                mov eax, hWnd
                .if eax == hWinMain
                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_e, 0, 0, 1000, 1000, SRCCOPY
                        invoke  _draw_button, addr button_exit, hWnd, button_exit_LX, button_exit_LY, hDCGame_ptr
                        invoke  _draw_final_score, hDCGame_ptr
                        invoke  _draw_button, addr button_retry, hWnd, button_retry_LX, button_retry_LY, hDCGame_ptr
                .endif
        .elseif eax == in_2p_choose
                xor edx, edx
                mov eax, hDCGame_ptr
                .if eax == hDCGame
                        mov eax, playerList.choose_confirm
                        .if eax == 1
                                mov edx, 1
                        .endif
                .endif
                mov eax, hDCGame_ptr
                .if eax == hDCGame2
                        mov eax, playerList2.choose_confirm
                        .if eax == 1
                                mov edx, 1
                        .endif
                .endif
                .if edx == 1
                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_2p_cc, 0, 0, 1000, 1000, SRCCOPY
                .else
                        invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_2p_c, 0, 0, 1000, 1000, SRCCOPY
                        invoke _draw_player_choose, hDCGame_ptr
                .endif
        .elseif eax == in_2p_game || eax == in_2p_pause
                

                invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_pd, 0, 0, 1000, 1000, SRCCOPY
;draw pause
                invoke  _draw_button, addr button_pause, hWnd, button_pause_LX, button_pause_LY, hDCGame_ptr

;draw obj 1
                mov ecx, @target_number
                mov esi, @targets_ptr
                assume esi :ptr Targets
                
                xor eax, eax
                .while eax < ecx
                        push eax
                        push ecx
                        push esi

                        mov edx, [esi].base.posy
                        .if [esi].base.alive == 1 && edx<cary
                                mov edx, [esi].base.posy
                                .if edx > remote_y+10
                                        invoke  TransparentBlt, 
                                                hDCGame_ptr, 
                                                [esi].base.posx, [esi].base.posy, 
                                                [esi].base.lengthx, [esi].base.lengthy, 
                                                [esi].base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                                .endif
                        .endif

                        pop esi
                        pop ecx
                        pop eax

                        inc eax
                        add esi, sizeofTargets
                .endw

; draw car     
                mov esi, player_addr
                assume esi: ptr Subject
                mov edx, 0
                .if [esi].status == Immunity
                        mov edx, object_DC.cant_inf
                .elseif [esi].status == Asymptomatic
                        mov edx, object_DC.soft_inf
                .elseif [esi].status == Infection
                        mov edx, object_DC.infected
                .endif
                .if [esi].status != Exposure
                        invoke  TransparentBlt, hDCGame_ptr, 
                                [esi].base.posx, [esi].base.posy, [esi].base.lengthx, [esi].base.lengthy, 
                                edx, 0, 0, PLAYER_LX, PLAYER_LY, 16777215                        
                .endif

                

                mov esi, player_addr
                assume esi: ptr Subject
                invoke  TransparentBlt, hDCGame_ptr, [esi].base.posx, [esi].base.posy, [esi].base.lengthx, [esi].base.lengthy, [esi].base.DC, 0, 0, PLAYER_LX, PLAYER_LY, 16777215
;draw obj 1
                mov ecx, @target_number
                mov esi, @targets_ptr
                assume esi :ptr Targets
                
                xor eax, eax
                .while eax < ecx
                        push eax
                        push ecx
                        push esi

                        mov edx, [esi].base.posy
                        .if [esi].base.alive == 1 && edx>cary
                                invoke  TransparentBlt, 
                                        hDCGame_ptr, 
                                        [esi].base.posx, [esi].base.posy, 
                                        [esi].base.lengthx, [esi].base.lengthy, 
                                        [esi].base.DC, 0, 0, PROP_LX, PROP_LY, 16777215
                        .endif

                        pop esi
                        pop ecx
                        pop eax

                        inc eax
                        add esi, sizeofTargets
                .endw
;draw life

                invoke  TransparentBlt, 
                        hDCGame_ptr, 
                        HP_place_X, HP_place_Y,
                        HP_place_LX, HP_place_LY, 
                        object_DC.hp_p, 0, 0, PROP_LX, PROP_LY, 16777215

                invoke _show_lifes, hDCGame_ptr, player_addr
;draw score
                invoke _show_score, hDCGame_ptr, player_addr
;

                invoke  TransparentBlt, hDCGame_ptr, 0, 0, gameH, gameW, backGround.DC_pu, 0, 0, 1000, 1000, 16777215


                mov esi, player_addr
                assume esi: ptr Subject
                .if [esi].has_hotpot
                        invoke  TransparentBlt, hDCGame_ptr, eathotpot_X, eathotpot_Y, eathotpot_LX, eathotpot_LY, object_DC.eathotpot, 0, 0, PROP_LX, PROP_LY, 16777215
                .endif

                mov esi, player_addr
                assume esi: ptr Subject
                .if [esi].has_mask
                        invoke  TransparentBlt, hDCGame_ptr, mask_X, mask_Y, mask_LX, mask_LY, 
                        object_DC.n95mask, 0, 0, PROP_LX, PROP_LY, 16777215
                .endif


                mov eax, cur_interface
                .if eax == in_2p_pause
                        invoke  TransparentBlt, hDCGame_ptr, pause_window_X, pause_window_Y, pause_window_LX, pause_window_LY, object_DC.pauw, 0, 0, PROP_LX, PROP_LY, 16777215
                                
                        invoke  _draw_button, addr button_save, hWnd, button_pause_rel_LX, button_pause_rel_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_continue, hWnd, button_pause_rel_LX, button_pause_rel_LY, hDCGame_ptr
                        invoke  _draw_button, addr button_changeR, hWnd, button_pause_rel_LX, button_pause_rel_LY, hDCGame_ptr

                .endif
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
_draw_object endp



; start:
;         ; call    _WinMain
;         ; invoke  ExitProcess, NULL
        
;         ; invoke _collision_test
;         ; invoke _two_two_enum_test
;         ret
; end     start
end