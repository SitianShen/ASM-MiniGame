include global_dev.inc


;========================  data? ? ? ? ? ==========================

.data?

player          Subject <>             
bullet          Subject <>              
targets         Targets  1000 dup(<>)  

;zzl own
button_play       Button <>
button_start      Button <>
button_back       Button <>
button_exit       Button <>
backGround        BackGround <>
object_DC         Object_DC <>

hInstance       dd      ?
hWinMain        dd      ?
hDCBack         dd      ?
hDCGame         dd      ?
hDCObj1         dd      ?
dwNowBack       dd      ?




;========================  data data data data ==========================

.data
flag_jump               dd      0
flag_movleft            dd      0
flag_movright           dd      0
stdtime_jump            dd      100
time_jump               dd      100
stdtime_mov             dd      150
time_mov                dd      50
cur_interface           dd  0

target_number   dd      0         
speed      dd      2

object1H         dd     57
object1W         dd     86
object_move_v    dd     1
POSCNT          dd      0; NEXTPOS的计数器




