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


BASE struct
        posx    dd      ?
        posy    dd      ?
        lengthx dd      ?
        lengthy dd      ?
        alive   dd      ?
        DC      dd      ?  ;物体图片句柄
        rel_v   dd      ?  ;相对移动速度（倍率）
BASE ends

Subject struct 
        base    BASE  <> 
Subject ends

MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 ;给自己加速
PROP_DEC_SELF           equ 2001 ;给自己减速
OBST_HARD               equ 3000 ;硬障碍
OBST_SOFT               equ 3001 ;软障碍
Targets struct
        base    BASE  <> 
        typeid  dd      ?
        runwayid dd     ?
Targets ends

.data?
player          Subject <>              ;人物
bullet          Subject <>              ;子弹
targets         Targets  1000 dup(<>)   ;物体
.const 
MAX_TARGET_NUMBER dd 1000
.data
target_number   dd      0               ;物体数量（targets数组长度）

.data
base_speed      dd      2 ;基准速度 单位为像素

;when you store something-> offset targets + (id%MAX_TARGET_NUMBER) 循环队列




; ########################################################## try code
ID_TIMER        equ     1
IDB_BACKG       equ     100
IDB_OBJ1        equ     101
IDB_ICON        equ     200
gameH           equ     498
gameW           equ     650
object1H_init   equ     577
object1W_init   equ     860
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
hCursorMain     dd      ?
hCursorMove     dd      ?
hMenu           dd      ?
hBmpBack        dd      ?
hBmpClock       dd      ?
; 缓存的钟面背景
hDCBack         dd      ?
; 缓存的游戏画面
hDCGame         dd      ?
; 游戏目标1
hDCObj1         dd      ?
; 缓存的叠加上指针的钟面
hDCClock        dd      ?

dwNowBack       dd      ?
dwNowObj1       dd      ?
dwNowCircle     dd      ?

.const
szClassName     db      'ASM小游戏', 0
_dwPara180      dw      180
dwRadius        dw      100/2
szMenuBack1     db      '使用背景1(&A)', 0
szMenuBack2     db      '使用背景2(&B)', 0
szMenuCircle1   db      '使用边框1(&C)', 0
szMenuCircle2   db      '使用边框2(&D)', 0
szMenuExit      db      '退出(&X)', 0
debug_int       db      '%llu', 0ah, 0
; ########################################################## try code



.code
;1 create
_create_ldf_need proc
        local @playerPic

        invoke  GetDC, hWinMain
        mov     @hDC, eax
        invoke  CreateCompatibleDC, @hDC
        mov     player.base.DC, eax
        invoke  LoadBitmap, hInstance, dwPlayerPic
        mov     @playerPic, eax
        invoke SelectObject, player.base.DC, @playerPic 
;2.1 maintain player, 遇到操作时调用
_move_object_player proc
_move_object_player endp

;2.2 maintain bullet 每一帧调用
_move_object_bullet proc
_move_object_bullet endp

;2.3 maintain all object  每一帧调用
_move_object_obj proc
_move_object_obj endp

;3 check collision 每一帧调用
_check_collision proc
;两两枚举所有物体，令那些应该消失的消失：
;同时维护targets数组的数量target_number
_check_collision endp



_createAll proc 
        local   @hDC, @hDCCircle, @hDCMask
        local   @hBmpBack, @hBmpObj1, @hBmpMask
        local   @brush

        mov     dwNowBack, IDB_BACKG
        mov     dwNowObj1, IDB_OBJ1
        invoke  GetDC, hWinMain
        mov     @hDC, eax

        invoke  CreateCompatibleDC, @hDC
        mov     hDCBack, eax
        invoke  CreateCompatibleDC, @hDC
        mov     hDCObj1, eax
        invoke  CreateCompatibleDC, @hDC
        mov     hDCGame, eax
        invoke  CreateCompatibleBitmap, @hDC, gameH, gameW
        mov     hBmpBack, eax
        invoke  SelectObject, hDCGame, hBmpBack ; set draw area to DC

        invoke  LoadBitmap, hInstance, dwNowBack
        mov     @hBmpBack, eax ;load back pic
        invoke  LoadBitmap, hInstance, dwNowObj1
        mov     @hBmpObj1, eax ;load obj pic


        invoke SelectObject, hDCBack, @hBmpBack
        ; invoke  CreatePatternBrush, @hBmpBack
        ; mov     @brush, eax
        ; invoke  SelectObject, hDCBack, @brush
        ; invoke  PatBlt, hDCBack, 0, 0, gameH, gameW, PATCOPY ;draw  background
        invoke  SelectObject, hDCObj1, @hBmpObj1

        invoke  ReleaseDC, hWinMain, @hDC
        ; invoke  DeleteObject, @brush
        invoke  DeleteObject, @hBmpBack
        invoke  DeleteObject, @hBmpObj1

        invoke create_ldf_need
        invoke create_lja_need
        invoke create_sst_need
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

_move_object proc
        invoke  BitBlt, hDCGame, 0, 0, gameH, gameW, hDCBack, 0, 0, SRCCOPY
        mov eax, object1H
        mov ebx, object1W
        inc eax
        inc ebx
        cmp eax, object1H_end
        jl continue
        cmp ebx, object1W_end
        jl continue
        mov eax, object1H_begin
        mov ebx, object1W_begin
continue:
        mov object1H, eax
        mov object1W, ebx
        ; invoke  StretchBlt, hDCGame, 100, 100, eax, ebx, 
        ;                     hDCObj1, 0,  0,  object1H_init, object1W_init, SRCCOPY
        invoke  TransparentBlt, hDCGame, 100, 100, eax, ebx, 
                                hDCObj1, 0,  0,  object1H_init, object1W_init, 16777215
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
                ; 复制缓存的钟面图片到显示DC
                ; 若1秒多次收到WM_PAINT不必重复计算
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
                invoke  _move_object
                ; .elseif eax == ID_TIMER2
                invoke  InvalidateRect, hWnd, NULL, FALSE


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

        ; 模块句柄
        invoke  GetModuleHandle, NULL
        mov     hInstance, eax

        ; 结构体清零
        ; invoke  LoadCursor, hInstance, IDC_MOVE
        ; mov     hCursorMove, eax
        ; invoke  LoadCursor, hInstance, IDC_MAIN
        ; mov     hCursorMain, eax
        invoke  RtlZeroMemory, addr @stWndClass, sizeof @stWndClass
                ; invoke  LoadIcon, hInstance, IDB_ICON
                ; mov     @stWndClass.hIcon, eax ; 设置小图标
                ; mov     @stWndClass.hIconSm, eax
        invoke  LoadCursor, 0, IDC_ARROW
        mov     @stWndClass.hCursor, eax
        mov     eax, hInstance
        mov     @stWndClass.hInstance, eax
        mov     @stWndClass.cbSize, sizeof WNDCLASSEX
        mov     @stWndClass.style, CS_HREDRAW or CS_VREDRAW
        ; 注册窗口类时指定对应的窗口过程
        mov     @stWndClass.lpfnWndProc, offset _ProcWinMain
        mov     @stWndClass.hbrBackground, COLOR_WINDOW + 1
        mov     @stWndClass.lpszClassName, offset szClassName
        ; 注册窗口类
        ; 注意同一窗口类的窗口都具有相同的窗口过程
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