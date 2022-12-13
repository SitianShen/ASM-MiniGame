;========================= c c c c ============================
scanf proto c:dword,:vararg
printf proto c:dword,:vararg
srand proto c:dword,:vararg
time proto c:dword,:vararg
rand proto c
system proto c:dword

;sound



;========================= zzl zzl zzl zzl ============================
; zzl functions
_Init_bullet proto ;初始化子弹
_initAll proto ;
_random_object_gene proto, :ptr dword, :ptr dword ;随机生成Targets
_set_char_pos proto ;
_load_button proto :ptr Button, :dword, :dword ;
_load_common_pic proto :dword, :dword ;
_createAll proto ;
_deleteAll proto ;
_Quit proto ;结束游戏
_draw_button proto :ptr Button, :dword, :dword, :dword, :dword ;画按钮
_draw_object proto :dword, :dword, :ptr Subject, :ptr Targets, :dword ;画Targets
_show_score proto :dword ;显示分数
_shot_bullet proto ;发射子弹
_init_2p_mode proto ;
_load_game proto :dword, :dword, :dword

;========================= sst sst sst sst ============================
; sst functions
_Init_car proto;小车初始化
_Move_process proto;每帧更新都要调用，实现连续性移动或跳起
_Action_left proto
_Action_right proto
_Action_jump proto
_sst_test proto



;========================= ldf ldf ldf ldf ============================

; ldf functions
_check_collision proto :ptr BASE,:ptr BASE
_collision_test proto

_collision_Player_with_MONEY_1 proto :ptr Targets
_collision_Player_with_MONEY_2 proto :ptr Targets
_collision_Player_with_ACC proto :ptr Targets
_collision_Player_with_DEC proto :ptr Targets
_collision_Player_with_HARD proto :ptr Targets
_collision_Player_with_SOFT proto :ptr Targets
_collision_bullet_with_SOFT proto :ptr Targets
_two_two_enum proto
_two_two_enum_test proto

;sound
_Open_ALL_SOUND proto
_Close_ALL_SOUND proto



;这些是碰撞音效，ldf来管
_collision_Player_with_MONEY_1_SOUND proto
_collision_Player_with_MONEY_2_SOUND proto
_collision_Player_with_ACC_SOUND proto
_collision_Player_with_DEC_SOUND proto
_collision_Player_with_HARD_SOUND proto
_collision_Player_with_SOFT_SOUND proto
_collision_bullet_with_SOFT_SOUND proto

;这些音效要zzl来管
_Jump_SOUND proto ;跳跃时要触发这个音效
_Launch_SOUND proto ;发射子弹时要触发这个音效
_CarMove_SOUND proto ;小车左右移动时要触发这个音效

_BGM_SOUND proto ;Play时要触发这个音效
_END_SOUND proto ;得分界面的时候要播放
_Gameover_SOUND proto ;HP为0，游戏结束时要播放的音效
_BeginBGM_SOUND proto ;开始界面，选择Play和Start要播放这个音效


_Stop_BGM_SOUND proto ;游戏结束的时候StopBGM, 播放END
_Stop_END_SOUND proto ;开始新的一局，StopEnd，播放BGM
_Stop_Gameover_SOUND proto ;
_Stop_BeginBGM_SOUND proto ;按下Play，就要关闭BeginBGM，播放游戏BGM

;C functions
printHelloWorld proto c

;========================= lja lja lja lja ============================
; lja functions
_next_position proto :ptr BASE         ;每个道具移动
_change_all_position proto      ;遍历所有道具，使之移动
_targets_bullet_out_of_bound proto



;=====================================================



;==================== 共生模式 ===========================


;========================= zzl zzl zzl zzl ============================
; zzl functions


;========================= ldf ldf ldf ldf ============================
; ldf functions

_collision_Player_with_medicine proto :ptr Subject, :ptr Targets
_collision_Player_with_redVirus proto :ptr Subject, :ptr Targets
_collision_Player_with_greenVirus proto :ptr Subject, :ptr Targets
_collision_Player_with_hotPot proto :ptr Subject, :ptr Targets
_collision_Player_with_n95mask proto :ptr Subject, :ptr Targets
_collision_Player_with_temperature proto :ptr Subject, :ptr Targets

;invoke _two_two_enum_symbiotic, addr playerOne, addr targetsOne, addr target_number_one
;invoke _two_two_enum_symbiotic, addr playerTwo, addr targetsTwo, addr target_number_two
_two_two_enum_symbiotic proto :ptr Subject, :dword, :dword
_two_two_enum_symbiotic_test proto

;sound
_Play_medicine_SOUND proto
_Stop_medicine_SOUND proto
_Play_hotPot_SOUND proto
_Stop_hotPot_SOUND proto
_Play_n95mask_SOUND proto
_Stop_n95mask_SOUND proto
_Play_temperature_SOUND proto
_Stop_temperature_SOUND proto


;========================= lja lja lja lja ============================
; lja functions

_hotpot_effect proto :ptr Subject, :ptr Subject
_mask_effect proto :ptr Subject, :ptr Subject
_fever_effect proto :ptr Subject, :ptr Subject
_check_player_effect proto :ptr Subject
_check_all_effect proto :ptr Subject, :ptr Subject
_change_status proto :ptr Subject, :ptr Subject
_change_all_position_symbiotic proto

;========================= sst sst sst sst ============================
; sst functions

_Init_car_symbiotic proto :ptr Subject
_Move_process_symbiotic proto :ptr Subject
_Action_left_symbiotic proto :ptr Subject
_Action_right_symbiotic proto :ptr Subject
_Action_jump_symbiotic proto :ptr Subject
_sst_test_symbiotic proto

;==================== 共生模式 ===========================