.386
.model flat, stdcall
option casemap: none

include         windows.inc
include         gdi32.inc
include         user32.inc
include         kernel32.inc
include         Msimg32.inc
includelib      gdi32.lib
includelib      user32.lib
includelib      kernel32.lib
includelib      Msimg32.lib


includelib msvcrt.lib
include msvcrt.inc
scanf proto c:dword,:vararg
printf proto c:dword,:vararg

;=====================================================
; sst functions
_Init_car proto;Ð¡ï¿½ï¿½ï¿½ï¿½Ê¼ï¿½ï¿½
_Jump_maintain proto;Ã¿Ò»Ö¡ï¿½ï¿½ï¿½ï¿½Ò»ï¿½ï¿½
_Action_left proto;
_Action_right proto;
_Action_jump proto;
_sst_test proto

; ldf funcions
_check_collision proto
_collision_test proto

; lja funcions
NextPos proto :ptr BASE         ;Ã¿¸öµÀ¾ßÒÆ¶¯
ChangeAllPos proto      ;±éÀúËùÓÐµÀ¾ß£¬Ê¹Ö®ÒÆ¶¯
;=====================================================

BASE struct
        posx    dd      ?
        posy    dd      ?
        lengthx dd      ?
        lengthy dd      ?
        alive   dd      ?
        DC      dd      ?  ;?????????
        rel_v   dd      ?  ;???????????????
        course_id       dd      ? ;0,1,2
BASE ends

Subject struct 
        base    BASE  <> 
        
        score           dd      ?
Subject ends

MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 ;?????????
PROP_DEC_SELF           equ 2001 ;?????????
OBST_HARD               equ 3000 ;????
OBST_SOFT               equ 3001 ;?????
Targets struct
        base    BASE  <> 
        typeid  dd      ?
Targets ends

.data?
player          Subject <>              ;????
bullet          Subject <>              ;???
env_objecet_1   BASE    <>              ;???????????? 1
env_objecet_2   BASE    <>              ;???????????? 2
env_objecet_3   BASE    <>              ;???????????? 3
targets         Targets  1000 dup(<>)   ;????

;zzl own
game_start              BASE <>
game_intro              BASE <>
game_start_chosen       BASE <>
game_intro_chosen       BASE <>
.data
choose_start            equ 1 
choose_intro            equ 2 
choose_which_char            dd  0

in_begining             equ 0
in_game                 equ 1
cur_interface           dd  0

;sst
carx0                   equ     150;ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ö´ï¿½ï¿½ï¿½
carx1                   equ     300
carx2                   equ     450
cary                    equ     500
cary_jump               equ     450

.data
flag_jump               dd      0
time_jump               dd      5

.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;??????????targets???ï¿½A???

.data
base_speed      dd      2 ;?????? ??ï¿½ï¿½?????

;when you store something-> offset targets + (id%MAX_TARGET_NUMBER) ???????




; ########################################################## try code
ID_TIMER        equ     1
IDB_BACKG       equ     100
IDB_OBJ1        equ     101
IDB_OBJ2        equ     102
IDB_OBJ3        equ     103
IDB_ICON        equ     200
IDB_GAMESTART   equ     301
IDB_GAMEINTRO   equ     302
IDB_GAMESTARTC  equ     303
IDB_GAMEINTROC  equ     304


gameH           equ     548
gameW           equ     650
charH           equ     400
charW           equ     400
object1H_init   equ     400
object1W_init   equ     600
object1H_begin  equ     57
object1W_begin  equ     86
object1H_end    equ     57*3
object1W_end    equ     86*3

.data


object1H         dd     57
object1W         dd     86
object_move_v    dd     2


.data?
hInstance       dd      ?
hWinMain        dd      ?
; hCursorMain     dd      ?
; hCursorMove     dd      ?
; hMenu           dd      ?
; hBmpBack        dd      ?
; hBmpClock       dd      ?
; ????????ï¿½M??
hDCBack         dd      ?
; ????????????
hDCGame         dd      ?
; ??????1
hDCObj1         dd      ?
; ??????????????????
; hDCClock        dd      ?

dwNowBack       dd      ?
; dwNowObj1       dd      ?
; dwNowCircle     dd      ?

.const
szClassName     db      'run away from covid-19', 0
; _dwPara180      dw      180
; dwRadius        dw      100/2
; szMenuBack1     db      '??????1(&A)', 0
; szMenuBack2     db      '??????2(&B)', 0
; szMenuCircle1   db      '?????1(&C)', 0
; szMenuCircle2   db      '?????2(&D)', 0
; szMenuExit      db      '???(&X)', 0
debug_int       db      '%d', 0ah, 0
; ########################################################## try code



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
; ;??????????????ï¿½ï¿½????ï¿½ï¿½?????????????
; ;?????targets?????????target_number
; _check_collision endp


_set_char_pos proc
        mov game_start.posx, 70
        mov game_start.posy, 50
        mov game_start.lengthx, charH
        mov game_start.lengthy, charW
        mov game_start_chosen.posx, 70
        mov game_start_chosen.posy, 50
        mov game_start_chosen.lengthx, charH
        mov game_start_chosen.lengthy, charW

        mov game_intro.posx, 70
        mov game_intro.posy, 180
        mov game_intro.lengthx, charH
        mov game_intro.lengthy, charW
        mov game_intro_chosen.posx, 70
        mov game_intro_chosen.posy, 180
        mov game_intro_chosen.lengthx, charH
        mov game_intro_chosen.lengthy, charW

        ret
_set_char_pos endp
_createAll proc 
        local   @hDC, @hDCCircle, @hDCMask
        local   @hBmpBack, @hBmpObj1, @hBmpObj2, @hBmpObj3
        local   @hBmpGS, @hBmpGI
        local   @brush

        mov     dwNowBack, IDB_BACKG
        invoke  GetDC, hWinMain
        mov     @hDC, eax

        invoke  CreateCompatibleDC, @hDC
        mov     hDCBack, eax

        invoke  CreateCompatibleDC, @hDC
        mov     hDCGame, eax
        invoke  CreateCompatibleBitmap, @hDC, gameH, gameW
        mov     @hBmpBack, eax
        invoke  SelectObject, hDCGame, @hBmpBack ; set draw area to DC


        invoke  LoadBitmap, hInstance, dwNowBack
        mov     @hBmpBack, eax ;load back

        invoke  SelectObject, hDCBack, @hBmpBack
        ; invoke  DeleteObject, @brush
        invoke  DeleteObject, @hBmpBack
;???????????
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
;???????
        invoke  CreateCompatibleDC, @hDC
        mov     game_start.DC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     game_intro.DC, eax
        invoke  LoadBitmap, hInstance, IDB_GAMESTART
        mov     @hBmpGS, eax ;load obj
        invoke  LoadBitmap, hInstance, IDB_GAMEINTRO
        mov     @hBmpGI, eax ;load obj
        invoke  SelectObject, game_start.DC, @hBmpGS
        invoke  SelectObject, game_intro.DC, @hBmpGI
        invoke  DeleteObject, @hBmpGS
        invoke  DeleteObject, @hBmpGI

        invoke  CreateCompatibleDC, @hDC
        mov     game_start_chosen.DC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     game_intro_chosen.DC, eax
        invoke  LoadBitmap, hInstance, IDB_GAMESTARTC
        mov     @hBmpGS, eax ;load obj
        invoke  LoadBitmap, hInstance, IDB_GAMEINTROC
        mov     @hBmpGI, eax ;load obj
        invoke  SelectObject, game_start_chosen.DC, @hBmpGS
        invoke  SelectObject, game_intro_chosen.DC, @hBmpGI
        invoke  DeleteObject, @hBmpGS
        invoke  DeleteObject, @hBmpGI

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

_move_object proc hWnd
        local @mouse:POINT
        local @window:RECT



        invoke  BitBlt, hDCGame, 0, 0, gameH, gameW, hDCBack, 0, 0, SRCCOPY
        mov eax, cur_interface
        .if eax == in_begining 
                mov choose_which_char, 0

                invoke	GetCursorPos,addr @mouse
                invoke  GetWindowRect, hWnd, addr @window
                invoke printf, offset debug_int, @mouse.x
                mov eax, @window.left
                mov ebx, @window.top
                ; sub @mouse.x, windows
                add eax, game_start.posx
                ; invoke printf, offset debug_int, eax
                add ebx, game_start.posy
                .if (eax <= @mouse.x) && (ebx <= @mouse.y)
                        add eax, game_start.lengthx
                        add ebx, game_start.lengthy
                        .if (eax >= @mouse.x) && (ebx >= @mouse.y)
                                mov choose_which_char, choose_start
                        .endif
                .endif

                mov eax, @window.left
                mov ebx, @window.top
                add eax, game_intro.posx
                add ebx, game_intro.posy
                .if (eax <= @mouse.x) && (ebx <= @mouse.y)
                        add eax, game_intro.lengthx
                        add ebx, game_intro.lengthy
                        .if (eax >= @mouse.x) && (ebx >= @mouse.y)
                                mov choose_which_char, choose_intro
                        .endif
                .endif
                invoke printf, offset debug_int, choose_which_char

                mov eax, choose_which_char
                .if eax == choose_start
                        invoke  TransparentBlt, 
                                hDCGame, 
                                game_start_chosen.posx, game_start_chosen.posy, charH, charW, 
                                game_start_chosen.DC, 
                                0, 0, game_start_chosen.lengthx, game_start_chosen.lengthy, 
                                16777215               
                .else
                        invoke  TransparentBlt, 
                                hDCGame, 
                                game_start.posx, game_start.posy, charH, charW, 
                                game_start.DC, 
                                0, 0, game_start.lengthx, game_start.lengthy, 
                                16777215  
                .endif

                mov eax, choose_which_char
                .if eax == choose_intro
                        invoke  TransparentBlt, 
                                hDCGame, 
                                game_intro_chosen.posx, game_intro_chosen.posy, charH, charW, 
                                game_intro_chosen.DC, 
                                0, 0, game_intro_chosen.lengthx, game_intro_chosen.lengthy, 
                                16777215     
                .else
                        invoke  TransparentBlt, 
                                hDCGame, 
                                game_intro.posx, game_intro.posy, charH, charW, 
                                game_intro.DC, 
                                0, 0, game_intro.lengthx, game_intro.lengthy, 
                                16777215  
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
                invoke  SetTimer, hWinMain, ID_TIMER, 55, NULL

        .elseif eax == WM_TIMER
                mov     eax, wParam
                ; .if     eax == ID_TIMER1
                invoke  _move_object, hWnd
                ; .elseif eax == ID_TIMER2
                invoke  InvalidateRect, hWnd, NULL, FALSE

        .elseif eax == WM_LBUTTONUP
                mov eax, cur_interface
                .if eax == in_begining 
                        mov eax, choose_which_char
                        .if eax == choose_start
                                mov cur_interface, in_game
                        .endif
                        .if eax == choose_intro
                                
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
        mov     @stWndClass.hIcon, eax ; ????ï¿½ï¿½???
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
                10, 10, gameH, gameW, \
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
        end     start