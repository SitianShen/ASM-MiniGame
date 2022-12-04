;========================= c c c c ============================
scanf proto c:dword,:vararg
printf proto c:dword,:vararg
srand proto c:dword,:vararg
time proto c:dword,:vararg
rand proto c

;========================= zzl zzl zzl zzl ============================
; zzl functions
_initAll proto
_random_object_gene proto
_set_char_pos proto
_load_button proto :ptr Button, :dword, :dword
_load_common_pic proto :dword, :dword
_createAll proto
_deleteAll proto
_Quit proto
_draw_button proto :ptr Button, :dword, :dword, :dword
_move_object proto :dword

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
_collision_bullet_with_HARD proto :ptr Targets
_two_two_enum proto
_two_two_enum_test proto

;========================= lja lja lja lja ============================
; lja functions
_next_position proto :ptr BASE         ;每个道具移动
_change_all_position proto      ;遍历所有道具，使之移动
_targets_bullet_out_of_bound proto


;=====================================================