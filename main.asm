.386
.model flat, stdcall
option casemap: none

include global.inc
        
.code
;1 create
; _create_ldf_need proc
;         local @playerPic  
  
;         invoke  GetDC, hWinMain
;         mov     @hDC, eax
;         invoke  CreateCompatibleDC, @hDC
;         mov     player.base.DC, eax
;         invoke  LoadBitmap, hInstance, dwPlayerPic
;         mov     @playerPic, eax
;         invoke SelectObject, player.base.DC, @playerPic 
; ;2.1 maintain player, ?????????????
; _move_object_player proc
; _move_object_player endp

; ;2.2 maintain bullet ???????
; _move_object_bullet proc
; _move_object_bullet endp

; ;2.3 maintain all object  ???????
; _move_object_obj proc
; _move_object_obj endp

; ;3 check collision ???????
; _check_collision proc
; ;???????????????????????????????????
; ;?????targets?????????target_number
; _check_collision endp

_set_char_pos proc
        mov button_play.base.posx, 70
        mov button_play.base.posy, 50
        mov button_play.base.lengthx, button_play_LX
        mov button_play.base.lengthy, button_play_LY

        mov button_start.base.posx, 70
        mov button_start.base.posy, 180
        mov button_start.base.lengthx, button_start_LX
        mov button_start.base.lengthy, button_start_LY

        mov button_back.base.posx, 70
        mov button_back.base.posy, 180
        mov button_back.base.lengthx, button_back_LX/2
        mov button_back.base.lengthy, button_back_LY/2
        ret
_set_char_pos endp

_load_button proc button, p1, p2
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

_load_background proc DC, p1
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
_load_background endp

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

        invoke  _load_background, addr backGround.DC_b, IDB_BACKG_BEGINING
        invoke  _load_background, addr backGround.DC_i, IDB_BACKG_INTRO
        invoke  _load_background, addr backGround.DC_p, IDB_BACKG_PLAY
        invoke  _load_background, addr backGround.DC_e, IDB_BACKG_END
;环境物体
        invoke  CreateCompatibleDC, @hDC
        mov     env_objecet_1.DC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     env_objecet_2.DC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     env_objecet_3.DC, eax
        invoke  LoadBitmap, hInstance, IDB_OBJ1
        mov     @hBmpObj1, eax ;load obj
        invoke  LoadBitmap, hInstance, IDB_OBJ2
        mov     @hBmpObj2, eax ;load obj
        invoke  LoadBitmap, hInstance, IDB_OBJ3
        mov     @hBmpObj3, eax ;load obj
        invoke  SelectObject, env_objecet_1.DC, @hBmpObj1
        invoke  SelectObject, env_objecet_2.DC, @hBmpObj2
        invoke  SelectObject, env_objecet_3.DC, @hBmpObj3
        invoke  DeleteObject, @hBmpObj1
        invoke  DeleteObject, @hBmpObj2
        invoke  DeleteObject, @hBmpObj3
;开始结束控件
        invoke _load_button, addr button_play,  IDB_BUTTON_PLAY_1,  IDB_BUTTON_PLAY_2
        invoke _load_button, addr button_start, IDB_BUTTON_START_1, IDB_BUTTON_START_2
        invoke _load_button, addr button_exit,  IDB_BUTTON_EXIT_1,  IDB_BUTTON_EXIT_2
        invoke _load_button, addr button_back,  IDB_BUTTON_BACK_1,  IDB_BUTTON_BACK_2

        invoke _set_char_pos

;
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

_draw_button proc button, hWnd, LX, LY
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



        mov eax, cur_interface
        .if eax == in_begining 
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_b, 0, 0, 1000, 1000, SRCCOPY
                invoke _draw_button, addr button_play, hWnd, button_play_LX, button_play_LY
                invoke _draw_button, addr button_start, hWnd, button_start_LX, button_start_LY
        .elseif eax == in_game
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_p, 0, 0, 1000, 1000, SRCCOPY
        
        .elseif eax == in_intro
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_i, 0, 0, 1000, 1000, SRCCOPY
                invoke _draw_button, addr button_back, hWnd, button_back_LX, button_back_LY
        .elseif eax == in_over
                invoke  TransparentBlt, hDCGame, 0, 0, gameH, gameW, backGround.DC_e, 0, 0, 1000, 1000, SRCCOPY

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
_ProcWinMain    proc    uses ebx edi esi, hWnd, uMsg, wParam, lParam
                local   @stPs: PAINTSTRUCT
                local   @hDC
                local   @stPos: POINT

        mov     eax, uMsg

        .if eax == WM_PAINT
                invoke  BeginPaint, hWnd, addr @stPs
                mov     @hDC, eax
                mov     eax, @stPs.rcPaint.right
                sub     eax, @stPs.rcPaint.left
                mov     ecx, @stPs.rcPaint.bottom
                sub     ecx, @stPs.rcPaint.top
                ; ???????????????????DC
                ; ??1???????WM_PAINT???????????
                invoke  BitBlt, @hDC, @stPs.rcPaint.left, @stPs.rcPaint.top, eax, ecx, hDCGame, @stPs.rcPaint.left, @stPs.rcPaint.top, SRCCOPY
                invoke  EndPaint, hWnd, addr @stPs
        .elseif eax == WM_CREATE
                mov     eax, hWnd
                mov     hWinMain, eax
                invoke  _createAll
                invoke  SetTimer, hWinMain, ID_TIMER, 15, NULL

        .elseif eax == WM_TIMER
                mov     eax, wParam
                ; .if     eax == ID_TIMER1
                invoke  _move_object, hWnd
                ; .elseif eax == ID_TIMER2
                invoke  InvalidateRect, hWnd, NULL, FALSE

        .elseif eax == WM_LBUTTONUP
                mov eax, cur_interface
                .if eax == in_begining 
                        mov eax, 1
                        .if eax == button_play.is_click
                                mov cur_interface, in_game
                        .endif
                        .if eax == button_start.is_click
                                mov cur_interface, in_intro
                        .endif
                .elseif eax == in_intro
                        mov eax, 1
                        .if eax == button_back.is_click
                                mov cur_interface, in_begining
                        .endif
                .endif


        .elseif eax == WM_CLOSE
                invoke  _Quit
        .else
                invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
                ret
        .endif
        xor     eax, eax
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
                0, 0, gameH+13, gameW+33, \
                NULL, NULL, hInstance, NULL
        mov     hWinMain, eax
        invoke  ShowWindow, hWinMain, SW_SHOWNORMAL
        invoke  UpdateWindow, hWinMain
        .while  TRUE
                invoke  GetMessage, addr @stMsg, NULL, 0, 0
                .break  .if     eax == 0
                invoke  TranslateMessage, addr @stMsg
                invoke  DispatchMessage, addr @stMsg
        .endw
        ret
_WinMain        endp

start:
        call    _WinMain
        invoke  ExitProcess, NULL
        ; invoke _collision_test
        ; invoke _sst_test
        ret
end     start