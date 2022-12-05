;========================  const const const const ==========================

.const 
szClassName     db      'run away from covid-19', 0
debug_int       db      '%d', 0ah, 0
szInt       db      '%d', 0ah, 0

MAX_TARGET_NUMBER equ 1000
choose_start equ 0
choose_intro equ 1
choose_which_char dd 0

;Game Items
MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 
PROP_DEC_SELF           equ 2001 
OBST_HARD               equ 3000 
OBST_SOFT               equ 3001
OBJ_ENV                 equ 4000

;collision and score
MONEY_1_SCORE           equ 2
MONEY_2_SCORE           equ 3
OBST_SOFT_SCORE         equ -1


in_begining             equ 0
in_game                 equ 1
in_intro                equ 2
in_over                 equ 3
in_pause                equ 4


;sst own
carx0                   equ     100
carx1                   equ     250
carx2                   equ     400
cary                    equ     380
carLX                   equ     100
carLY                   equ     100

;obj init size
obj_init_lx                   equ 36
obj_init_ly                   equ 36
;obj init pos  
remote_y                equ 190
remote_x0               equ 80+50+30+30+35
remote_x5               equ 120+50+30+30+30
remote_x6               equ 160+50+30+35
remote_x7               equ 200+50+50
remote_x4               equ 240+50+40



ID_TIMER        equ     1
ID_TIMER_gene   equ     2
IDB_BACKG_BEGINING       equ     99
IDB_BACKG_INTRO          equ     98
IDB_BACKG_PLAY           equ     97
IDB_BACKG_PLAYU          equ     90
IDB_BACKG_PLAYD          equ     91
IDB_BACKG_END            equ     96
IDB_BACKG       equ     100
IDB_OBJ1        equ     101
IDB_OBJ2        equ     102
IDB_OBJ3        equ     103
IDB_ICON        equ     200
IDB_GAMESTART   equ     301
IDB_GAMEINTRO   equ     302
IDB_GAMESTARTC  equ     303
IDB_GAMEINTROC  equ     304

IDB_BUTTON_BACK_1  equ 305
IDB_BUTTON_BACK_2  equ 306
button_back_LX     equ 320
button_back_LY     equ 140

IDB_BUTTON_EXIT_1  equ 307
IDB_BUTTON_EXIT_2  equ 308
button_exit_LX     equ 200
button_exit_LY     equ 84

IDB_BUTTON_PLAY_1  equ 309
IDB_BUTTON_PLAY_2  equ 310
button_play_LX     equ 200
button_play_LY     equ 85

IDB_BUTTON_START_1 equ 311
IDB_BUTTON_START_2 equ 312
button_start_LX     equ 265
button_start_LY     equ 83

PROP_LX equ 500
PROP_LY equ 500
IDB_PROP_MONEY      equ 313
IDB_PROP_ABSTSOFT   equ 314
IDB_PROP_ABSTHARD   equ 315
IDB_PROP_ACC        equ 316
IDB_PROP_DEC        equ 317
IDB_PROP_BULLETL    equ 318
IDB_PROP_BULLETM    equ 319
IDB_PROP_BULLETR    equ 320

IDB_BUTTON_RETRY_1    equ 321
IDB_BUTTON_RETRY_2    equ 322
button_retry_LX       equ 192 
button_retry_LY       equ 92

IDB_BUTTON_PAUSE_1    equ 323
IDB_BUTTON_PAUSE_2    equ 324
button_pause_LX       equ 110 
button_pause_LY       equ 52

IDB_PLAYER          equ 400 
PLAYER_LX equ 500
PLAYER_LY equ 500         

IDB_DIG0 equ 1000
IDB_DIG1 equ 1001
IDB_DIG2 equ 1002
IDB_DIG3 equ 1003
IDB_DIG4 equ 1004
IDB_DIG5 equ 1005
IDB_DIG6 equ 1006
IDB_DIG7 equ 1007
IDB_DIG8 equ 1008
IDB_DIG9 equ 1009
DIG_LX equ 500
DIG_LY equ 500   
scoreBoard_lst_X   equ 100
scoreBoard_lst_Y   equ 60
scoreBoard_dig_LX  equ 50
scoreBoard_dig_LY  equ 50
scoreBoard_each_LX equ 50
scoreBoard_each_LY equ 50

IDB_HPP equ 500
HP_place_X equ 100
HP_place_Y equ 100
HP_place_LX equ 200
HP_place_LY equ 200


gameH           equ     600
gameW           equ     600
charH           equ     400
charW           equ     400
sizeofTargets   equ     sizeof Targets


;ldf lja own
slow_level      equ     3
normal_level    equ     2
fast_level      equ     1
speed_item_time      equ     100 ;加速/减速道具的持续时间

;sound
szOpenDemo byte "open sound/demo.mp3 alias demoMusic",0
szPlayDemo byte "play demoMusic",0
szStopDemo byte "stop demoMusic",0
szCloseDemo byte "close demoMusic",0

;Jump
szOpenJump byte "open sound/Jump.mp3 alias Jump",0
szPlayJump byte "play Jump", 0
szCloseJump byte "close Jump", 0

;MoneyOne
szOpenMoneyOne byte "open sound/MoneyOne.mp3 alias MoneyOne",0
szPlayMoneyOne byte "play MoneyOne from 0",0
szCloseMoneyOne byte "close MoneyOne",0

;MoneyTwo
szOpenMoneyTwo byte "open sound/MoneyTwo.mp3 alias MoneyTwo",0
szPlayMoneyTwo byte "play MoneyTwo from 0",0
szCloseMoneyTwo byte "close MoneyTwo", 0

;ACC
szOpenACC byte "open sound/ACC.mp3 alias ACC",0
szPlayACC byte "play ACC from 0",0
szCloseACC byte "close ACC", 0

;DEC
szOpenDEC byte "open sound/DEC.mp3 alias DEC",0
szPlayDEC byte "play DEC from 0",0
szCloseDEC byte "close DEC", 0

;HARD
szOpenHARD byte "open sound/HARD.mp3 alias HARD",0
szPlayHARD byte "play HARD from 0",0
szCloseHARD byte "close HARD",0

;SOFT
szOpenSOFT byte "open sound/SOFT.mp3 alias SOFT",0
szPlaySOFT byte "play SOFT from 0",0
szCloseSOFT byte "close SOFT", 0

;BulletHitSOFT
szOpenBulletHitSOFT byte "open sound/BulletHitSOFT.mp3 alias BulletHitSOFT",0
szPlayBulletHitSOFT byte "play BulletHitSOFT from 0",0
szCloseBulletHitSOFT byte "close BulletHitSOFT", 0

;Launch
szOpenLaunch byte "open sound/Launch.mp3 alias Launch",0
szPlayLaunch byte "play Launch from 0",0
szCloseLaunch byte "close Launch", 0

;CarMove
szOpenCarMove byte "open sound/CarMove.mp3 alias CarMove",0
szPlayCarMove byte "play CarMove from 0",0
szCloseCarMove byte "close CarMove", 0

;BGM
szOpenBGM byte "open sound/BGM.mp3 alias BGM",0
szPlayBGM byte "play BGM from 0 repeat",0
szCloseBGM byte "close BGM", 0
szStopBGM byte "stop BGM", 0

;End
szOpenEnd byte "open sound/End.mp3 alias End",0
szPlayEnd byte "play End from 0",0
szCloseEnd byte "close End", 0
szStopEnd byte "stop End", 0

;Gameover
szOpenGameover byte "open sound/Gameover.mp3 alias Gameover",0
szPlayGameover byte "play Gameover from 0",0
szCloseGameover byte "close Gameover", 0
szStopGameover byte "stop Gameover", 0

;BeginBGM
szOpenBeginBGM byte "open sound/BeginBGM.mp3 alias BeginBGM",0
szPlayBeginBGM byte "play BeginBGM from 0 repeat",0
szCloseBeginBGM byte "close BeginBGM", 0
szStopBeginBGM byte "stop BeginBGM", 0


