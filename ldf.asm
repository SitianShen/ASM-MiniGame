.386
.model flat, stdcall
option casemap: none

include global.inc

.code

;3 check collision 每一帧调用
;两两枚举所有物体，令那些应该消失的消失：
;同时维护targets数组的数量target_number
;返回值为1代表碰撞
;返回值为0代表没有碰撞 
_check_collision proc uses ebx, @objectOne:ptr BASE, @objectTwo:ptr BASE
        local @objectOnePosX, @objectOnePosY
        local @objectOneLengthX, @objectOneLengthY
        
        local @objectTwoPosX, @objectTwoPosY
        local @objectTwoLengthX, @objectTwoLengthY

        local @objectOneCenterX, @objectTwoCenterY
        local @objectOneCenterY, @objectTwoCenterX

        local @distanceX, @distanceY
        
        local @criticalX, @criticalY

        mov esi, @objectOne
        assume esi: ptr BASE
        mov eax, [esi].course_id
        
        mov esi, @objectTwo
        assume esi: ptr BASE

        .if [esi].course_id != eax
                mov eax, 0
                ; invoke printf, offset szInt, @objectOne.course_id
                ; invoke printf, offset szInt, @objectTwo.course_id
                ret
        .endif

        ;objectOne
        mov eax, [esi].posx
        mov @objectOnePosX, eax

        mov eax, [esi].posy
        mov @objectOnePosY, eax
        
        mov eax, [esi].lengthx
        mov @objectOneLengthX, eax

        mov eax, [esi].lengthy
        mov @objectOneLengthY, eax

        ;objectTwo
        mov eax, [esi].posx
        mov @objectTwoPosX, eax

        mov eax, [esi].posy
        mov @objectTwoPosY, eax
        
        mov eax, [esi].lengthx
        mov @objectTwoLengthX, eax

        mov eax, [esi].lengthy
        mov @objectTwoLengthY, eax

        ;获取objectOne.中心X坐标
        mov eax, @objectOneLengthX
        shr eax, 1
        add eax, @objectOnePosX
        mov @objectOneCenterX, eax
        
        ;获取objectOne.中心Y坐标
        mov eax, @objectOneLengthY
        shr eax, 1
        add eax, @objectOnePosY
        mov @objectOneCenterY, eax

        ;获取objectTwo.中心X坐标
        mov eax, @objectTwoLengthX
        shr eax, 1
        add eax, @objectTwoPosX
        mov @objectTwoCenterX, eax
        
        ;获取objectTwo.中心Y坐标
        mov eax, @objectTwoLengthY
        shr eax, 1
        add eax, @objectTwoPosY
        mov @objectTwoCenterY, eax
        
        ;计算X轴距离之差
        mov eax, @objectOneCenterX
        .if @objectTwoCenterX > eax
                mov ebx, @objectTwoCenterX
                sub ebx, eax
                mov @distanceX, ebx
        .elseif
                sub eax, @objectTwoCenterX
                mov @distanceX, eax
        .endif

        ;计算Y轴距离之差
        mov eax, @objectOneCenterY
        .if @objectTwoCenterY > eax
                mov ebx, @objectTwoCenterY
                sub ebx, eax
                mov @distanceY, ebx
        .elseif
                sub eax, @objectTwoCenterY
                mov @distanceY, eax
        .endif

        ;对两个矩形进行碰撞判断
        ;计算临界X, Y
        mov eax, @objectOneLengthX
        add eax, @objectTwoLengthX
        shr eax, 2
        mov @criticalX, eax

        mov eax, @objectOneLengthY
        add eax, @objectTwoLengthY
        shr eax, 2
        mov @criticalY, eax

        ;两中心点构成的三角形处于临界三角形之内
        mov eax, @distanceX
        mov ebx, @distanceY
        .if @criticalX >= eax && @criticalY >= ebx
                mov eax, 1
                ret
        .endif

        mov eax, 0
        ret
_check_collision endp


        
_collision_test proc
        local @objectOne:BASE, @objectTwo:BASE

        mov @objectOne.posx, 1
        mov @objectOne.posy, 1
        mov @objectOne.lengthx, 1
        mov @objectOne.lengthy, 1
        mov @objectOne.alive, 1
        mov @objectOne.DC, 1
        mov @objectOne.rel_v, 1
        mov @objectOne.course_id, 1

        mov @objectTwo.posx, 1
        mov @objectTwo.posy, 1
        mov @objectTwo.lengthx, 1
        mov @objectTwo.lengthy, 1
        mov @objectTwo.alive, 1
        mov @objectTwo.DC, 1
        mov @objectTwo.rel_v, 1
        mov @objectTwo.course_id, 0

        invoke _check_collision,addr @objectOne, addr @objectTwo
        invoke printf, offset debug_int, eax
        ret
_collision_test endp


_two_two_enum proc 
        mov eax, target_number

_two_two_enum endp


_two_two_enum_test proc
        

_two_two_enum_test endp

start:
        ; call    _WinMain
        ; invoke  ExitProcess, NULL
        
        invoke _collision_test
        ret
end     start
; end