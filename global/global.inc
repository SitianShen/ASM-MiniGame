include global_dev.inc

;========================  data? ? ? ? ? ==========================
;哪些变量需要维护两份——zzl
;翻转，屏幕带个口罩，扣血，从天而降的子弹



.data?

player          Subject <>             ;两份
bullet          Subject <>              
targets         Targets  1000 dup(<>) 


digitals_DC     dd 10 dup(?) 

;zzl own
button_play       Button <>
button_start      Button <>
button_back       Button <>
button_exit       Button <>
button_retry      Button <>
button_pause      Button <>
backGround        BackGround <>
object_DC         Object_DC <>


hInstance       dd      ?
hWinMain        dd      ?
hWinMain2        dd      ?
hDCBack         dd      ?
hDCGame         dd      ?
hDCGame2         dd      ?
hDCObj1         dd      ?
dwNowBack       dd      ?


;========================  data data data data ==========================


.data
flag_jump               dd      0
flag_movleft            dd      0
flag_movright           dd      0
stdtime_jump            dd      50
time_jump               dd      50
stdtime_mov             dd      10
time_mov                dd      10
cur_interface           dd  0

target_number   dd      0         
speed      dd      2
base_speed  dd      1
speed_acc_time dd 0
speed_dec_time dd 0

object1H         dd     57
object1W         dd     86
object_move_v    dd     1
POSCNT          dd      0; NEXTPOS的计数器



;==================== 共生模式 ===========================

gameTime    dd     ?
board       dd     boardHorizontal*boardVertical dup(?)

;==================== 共生模式 ===========================




