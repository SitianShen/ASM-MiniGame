;========================  const const const const ==========================

.const 
szClassName     db      'run away from covid-19', 0
debug_int       db      '%d', 0ah, 0
szInt       db      '%d', 0ah, 0

MAX_TARGET_NUMBER equ 1000
choose_start equ 0
choose_intro equ 1
choose_which_char dd 0

MONEY_1                 equ 1000
MONEY_2                 equ 1001
PROP_ACC_SELF           equ 2000 
PROP_DEC_SELF           equ 2001 
OBST_HARD               equ 3000 
OBST_SOFT               equ 3001

in_begining             equ 0
in_game                 equ 1
in_intro                equ 2
in_over                 equ 3


;sst own
carx0                   equ     100
carx1                   equ     250
carx2                   equ     400
cary                    equ     380
carLX                   equ     100
carLY                   equ     100


ID_TIMER        equ     1
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

IDB_PLAYER          equ 400 
PLAYER_LX equ 500
PLAYER_LY equ 500         

gameH           equ     600
gameW           equ     600
charH           equ     400
charW           equ     400
sizeofTargets   equ     sizeof Targets