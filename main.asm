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
        
.code


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
                invoke  _initAll
                invoke  SetTimer, hWinMain, ID_TIMER, 15, NULL
                invoke  SetTimer, hWinMain, ID_TIMER_gene, 1200, NULL


        .elseif eax == WM_TIMER
                mov     eax, wParam
                .if     eax == ID_TIMER
                        invoke  _move_object, hWnd
                        invoke _change_all_position
                        invoke _targets_bullet_out_of_bound
                        invoke  InvalidateRect, hWnd, NULL, FALSE
                .elseif eax == ID_TIMER_gene
                        mov eax, cur_interface
                        .if eax == in_game
                                invoke  _random_object_gene
                        .endif
                .endif

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

        .elseif eax == WM_KEYDOWN
                mov eax, wParam
                .if eax == 87 
                        invoke _Action_jump
                .elseif eax == 65
                        invoke _Action_left
                .elseif eax == 68
                        invoke _Action_right
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
        invoke time, 0
        invoke srand, eax
        invoke rand
        call    _WinMain
        invoke  ExitProcess, NULL   
        ; invoke printf, offset debug_int, eax   
        ; invoke _collision_test
        ; invoke _two_two_enum_test
        ; invoke _sst_test
        ret
end     start