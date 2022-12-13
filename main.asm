.386
.model flat, stdcall
option casemap: none

include global_dev.inc
include global_extrn.inc
        
.code

_ProcWinMain    proc    uses ebx edi esi, hWnd, uMsg, wParam, lParam
                local   @stPs: PAINTSTRUCT
                local   @hDC
                local   @stPos: POINT

        ; invoke printf, offset debug_int, hWnd
        ; invoke printf, offset debug_int, hWinMain
        ; invoke printf, offset debug_int, hWinMain2
        mov eax, hWnd
        .if eax == hWinMain  
                mov     eax, uMsg
                .if eax == WM_PAINT
                        invoke  BeginPaint, hWnd, addr @stPs
                        mov     @hDC, eax
                        mov     eax, @stPs.rcPaint.right
                        sub     eax, @stPs.rcPaint.left
                        mov     ecx, @stPs.rcPaint.bottom
                        sub     ecx, @stPs.rcPaint.top


                        invoke  BitBlt, @hDC, @stPs.rcPaint.left, @stPs.rcPaint.top, eax, ecx, hDCGame, @stPs.rcPaint.left, @stPs.rcPaint.top, SRCCOPY
                        invoke  EndPaint, hWnd, addr @stPs
                .elseif eax == WM_CREATE


                .elseif eax == WM_TIMER
                        mov     eax, wParam
                        .if     eax == ID_TIMER
                                mov eax, cur_interface
                                .if eax != in_2p_game && eax != in_2p_pause
                                        invoke  _draw_object, hWnd, hDCGame, addr player, addr targets, target_number
                                        mov eax, cur_interface
                                        .if eax == in_game
                                                invoke _change_all_position
                                                invoke _targets_bullet_out_of_bound
                                                invoke _two_two_enum
                                        .endif
                                .elseif eax == in_2p_game
                                        invoke _change_all_position_symbiotic ;only here
                                        invoke _targets_bullet_out_of_bound_symbiotic ;only here
                                        ; invoke _two_two_enum_symbiotic, addr playerOne, addr targetsOne, addr target_number_one ;copy here
                                        invoke  _draw_object, hWnd, hDCGame, addr playerOne, addr targetsOne, target_number_one
                                        ;write here for 1p
                                .elseif eax == in_2p_pause
                                        invoke  _draw_object, hWnd, hDCGame, addr playerOne, addr targetsOne, target_number_one
                                .endif
                                invoke  InvalidateRect, hWnd, NULL, FALSE
                        .elseif eax == ID_TIMER_gene
                                mov eax, cur_interface
                                .if eax == in_game
                                        invoke  _random_object_gene, addr targets, addr target_number
                                .elseif eax == in_2p_game
                                        invoke  _random_object_gene_2p, addr targetsOne, addr target_number_one
                                .endif
                        .endif

                .elseif eax == WM_LBUTTONUP
                

                .elseif eax == WM_CLOSE
                        invoke  _Quit
                
                .elseif eax == WM_KEYDOWN  
                .else
                        invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
                        ret
                .endif
                xor     eax, eax
        .elseif eax == hWinMain2
                mov     eax, uMsg
                .if eax == WM_PAINT
                        invoke  BeginPaint, hWnd, addr @stPs
                        mov     @hDC, eax
                        mov     eax, @stPs.rcPaint.right
                        sub     eax, @stPs.rcPaint.left
                        mov     ecx, @stPs.rcPaint.bottom
                        sub     ecx, @stPs.rcPaint.top
                        invoke  BitBlt, @hDC, @stPs.rcPaint.left, @stPs.rcPaint.top, eax, ecx, hDCGame2, @stPs.rcPaint.left, @stPs.rcPaint.top, SRCCOPY
                        invoke  EndPaint, hWnd, addr @stPs

                .elseif eax == WM_TIMER
                        mov     eax, wParam
                        .if     eax == ID_TIMER2
                                invoke  _draw_object, hWnd, hDCGame2, addr playerTwo, addr targetsTwo, target_number_two
                                invoke  InvalidateRect, hWnd, NULL, FALSE
                        ; .elseif eax == ID_TIMER_gene2
                        ;         mov eax, cur_interface
                        ;         .if eax == in_2p_game
                        ;                 invoke  _random_object_gene
                        ;         .endif
                        .endif
                .elseif eax == WM_KEYDOWN  
                .elseif eax == WM_LBUTTONUP
                .else
                        invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
                        ret
                .endif
        .endif
; keydown
        mov     eax, uMsg
        .if eax == WM_KEYDOWN  
                mov eax, cur_interface
                .if eax == in_game 
                        mov eax, wParam
                        .if eax == 87 
                                invoke _Action_jump
                                invoke _Jump_SOUND
                        .elseif eax == 65
                                invoke _CarMove_SOUND
                                invoke _Action_left
                        .elseif eax == 68
                                invoke _CarMove_SOUND
                                invoke _Action_right
                        .elseif eax == 13
                                invoke _shot_bullet
                        .endif
                .elseif eax == in_2p_choose
                        mov eax, wParam
                        .if eax == 65
                                mov eax, playerList.choose_confirm
                                .if eax == 0 
                                        dec playerList.curid
                                        mov eax, playerList.curid
                                        .if eax == -1
                                                add eax, player_pic_number
                                        .endif
                                        mov playerList.curid, eax
                                .endif
                        .elseif eax == 68
                                mov eax, playerList.choose_confirm
                                .if eax == 0 
                                        inc playerList.curid
                                        mov eax, playerList.curid
                                        .if eax == 4  
                                                sub eax, player_pic_number
                                        .endif
                                        mov playerList.curid, eax
                                .endif
                        .elseif eax == 32
                                mov playerList.choose_confirm, 1

                        .elseif eax == 37
                                mov eax, playerList2.choose_confirm
                                .if eax == 0 
                                        dec playerList2.curid
                                        mov eax, playerList2.curid
                                        .if eax == -1
                                                add eax, player_pic_number
                                        .endif
                                        mov playerList2.curid, eax
                                .endif
                        .elseif eax == 39
                                mov eax, playerList2.choose_confirm
                                .if eax == 0 
                                        inc playerList2.curid
                                        mov eax, playerList2.curid
                                        .if eax == 4 
                                                sub eax, player_pic_number
                                        .endif
                                        mov playerList2.curid, eax
                                .endif
                        .elseif eax == 13
                                mov playerList2.choose_confirm, 1
                        .endif
                .elseif eax == in_2p_game
                        mov eax, wParam
                        .if eax == 87 
                                invoke _Jump_SOUND
                                invoke _Action_jump_symbiotic, addr playerOne
                        .elseif eax == 65
                                invoke _CarMove_SOUND
                                invoke _Action_left_symbiotic, addr playerOne
                        .elseif eax == 68
                                invoke _CarMove_SOUND
                                invoke _Action_right_symbiotic, addr playerOne
                        .elseif eax == 38 
                                invoke _Jump_SOUND
                                invoke _Action_jump_symbiotic, addr playerTwo
                        .elseif eax == 37
                                invoke _CarMove_SOUND
                                invoke _Action_left_symbiotic, addr playerTwo
                        .elseif eax == 39
                                invoke _CarMove_SOUND
                                invoke _Action_right_symbiotic, addr playerTwo
                        ; .elseif eax == 13
                                ; invoke _shot_bullet
                        .endif
                .endif
                ret
        .elseif eax == WM_LBUTTONUP
                invoke printf, offset debug_int, wParam
                mov eax, cur_interface
                .if eax == in_begining 
                        mov eax, 1
                        .if eax == button_play.is_click
                                invoke _Stop_BeginBGM_SOUND
                                invoke _BGM_SOUND
                                mov cur_interface, in_game
                                mov button_play.is_click, 0
                                ;播放开始游戏的BGM
                        .elseif eax == button_start.is_click
                                mov cur_interface, in_intro
                                mov button_start.is_click, 0
                        .elseif eax == button_2p_play.is_click
                                invoke _Stop_BeginBGM_SOUND
                                invoke  ShowWindow, hWinMain2, SW_SHOWNORMAL
                                invoke _init_2p_mode
                                mov cur_interface, in_2p_choose
                                mov button_2p_play.is_click, 0
                        .elseif eax == button_load.is_click
                                invoke _init_2p_mode
                                invoke _load_game, addr playerOne, addr targetsOne, addr target_number_one, addr saveFileName1
                                .if eax == 0 
                                        invoke _load_game, addr playerTwo, addr targetsTwo, addr target_number_two, addr saveFileName2
                                        .if eax == 0
                                                invoke _Stop_BeginBGM_SOUND
                                                invoke  ShowWindow, hWinMain2, SW_SHOWNORMAL
                                                mov cur_interface, in_2p_game
                                                mov button_2p_play.is_click, 0
                                        .endif
                                .endif

                        .endif
                .elseif eax == in_intro
                        mov eax, 1
                        .if eax == button_back.is_click
                                mov cur_interface, in_begining
                                mov button_back.is_click, 0
                        .endif
                .elseif eax == in_over
                        mov eax, 1
                        .if eax == button_exit.is_click
                                invoke _Stop_END_SOUND
                                invoke _Quit
                                mov button_exit.is_click, 0
                        .elseif eax == button_retry.is_click
                                invoke _initAll
                                invoke _Stop_END_SOUND
                                invoke _BeginBGM_SOUND
                                mov cur_interface, in_begining
                                mov button_retry.is_click, 0
                        .endif
                .elseif eax == in_game
                        mov eax, 0
                        .if eax != button_pause.is_click
                                mov cur_interface, in_pause
                        .endif
                .elseif eax == in_pause
                        mov eax, 1
                        .if eax == button_pause.is_click
                                mov cur_interface, in_game
                                mov button_pause.is_click, 0
                        .endif
                .elseif eax == in_2p_game
                        invoke _check_button, addr button_pause, hWnd
                        .if eax == 1
                                mov cur_interface, in_2p_pause
                        .endif
                .elseif eax == in_2p_pause
                        invoke _check_button, addr button_save, hWnd
                        .if eax == 1
                                invoke _save_game, addr playerOne, addr targetsOne, addr target_number_one, addr saveFileName1
                                invoke _save_game, addr playerTwo, addr targetsTwo, addr target_number_two, addr saveFileName2
                                mov cur_interface, in_begining
                                mov button_save.is_click, 0
                        .endif
                        invoke _check_button, addr button_continue, hWnd
                        .if eax == 1
                                mov cur_interface, in_2p_game
                                mov button_save.is_click, 0
                        .endif
                        invoke _check_button, addr button_changeR, hWnd
                        .if eax == 1
                                mov cur_interface, in_2p_choose
                                mov button_save.is_click, 0
                        .endif
                .endif
        .endif
;check confirmed
        mov eax, playerList.choose_confirm
        mov ebx, playerList2.choose_confirm
        .if eax == 1 && ebx == 1
                mov cur_interface, in_2p_game
                mov ebx, playerList.curid
                mov eax, [playerList.DC+8*ebx]
                mov playerOne.base.DC, eax
                mov ebx, playerList2.curid
                mov eax, [playerList2.DC+8*ebx]  
                mov playerTwo.base.DC, eax 
                mov playerList.choose_confirm, 0
                mov playerList2.choose_confirm, 0
        .endif

        invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
        ret
_ProcWinMain    endp

_WinMain        proc
                local   @stWndClass: WNDCLASSEX
                local   @stMsg: MSG

        ; ?????
        invoke  GetModuleHandle, NULL
        mov     hInstance, eax

        ; ????????
        ; invoke  LoadCursor, hInstance, IDC_MOVE
        ; mov     hCursorMove, eax
        ; invoke  LoadCursor, hInstance, IDC_MAIN
        ; mov     hCursorMain, eax
        invoke  RtlZeroMemory, addr @stWndClass, sizeof @stWndClass
        invoke  LoadIcon, hInstance, IDB_ICON
        mov     @stWndClass.hIcon, eax ; ?????????????
        mov     @stWndClass.hIconSm, eax
        invoke  LoadCursor, 0, IDC_ARROW
        mov     @stWndClass.hCursor, eax
        mov     eax, hInstance
        mov     @stWndClass.hInstance, eax
        mov     @stWndClass.cbSize, sizeof WNDCLASSEX
        mov     @stWndClass.style, CS_HREDRAW or CS_VREDRAW
        ; ??????????????????????
        mov     @stWndClass.lpfnWndProc, offset _ProcWinMain
        mov     @stWndClass.hbrBackground, COLOR_WINDOW + 1
        mov     @stWndClass.lpszClassName, offset szClassName
        ; ???????
        ; ???????????????????????????????
        invoke  RegisterClassEx, addr @stWndClass
        invoke  CreateWindowEx, NULL, \
                offset szClassName, offset szClassName, \
                WS_OVERLAPPEDWINDOW, \
                0, 0, gameH, gameW, \
                NULL, NULL, hInstance, NULL
        mov     hWinMain, eax
        invoke  ShowWindow, hWinMain, SW_SHOWNORMAL
        invoke  UpdateWindow, hWinMain

        invoke printf, offset debug_int, hWinMain
        invoke  CreateWindowEx, NULL, \
                offset szClassName, offset szClassName, \
                WS_OVERLAPPEDWINDOW, \
                gameH, 0, gameH, gameW, \
                NULL, NULL, hInstance, NULL
        mov     hWinMain2, eax

        invoke  _createAll
        invoke  _initAll
        invoke  SetTimer, hWinMain, ID_TIMER, 15, NULL ;flush
        invoke  SetTimer, hWinMain, ID_TIMER_gene, 600, NULL ;generate

        invoke  SetTimer, hWinMain2, ID_TIMER2, 15, NULL ;flush
        invoke  SetTimer, hWinMain2, ID_TIMER_gene2, 600, NULL ;generate

        .while  TRUE
                invoke  GetMessage, addr @stMsg, NULL, 0, 0
                .break  .if     eax == 0
                invoke  TranslateMessage, addr @stMsg
                invoke  DispatchMessage, addr @stMsg
        .endw
        ret
_WinMain        endp

start:
        invoke time, 0
        invoke srand, eax
        invoke rand

        invoke _Open_ALL_SOUND
        invoke _BeginBGM_SOUND
        call    _WinMain
        invoke _Close_ALL_SOUND
        invoke  ExitProcess, NULL   
        ; invoke printf, offset debug_int, eax   
        ; invoke _collision_test
        ; invoke _two_two_enum_test
        ; invoke _sst_test
        ret
end     start