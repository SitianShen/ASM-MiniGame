# Cyberpunk Covid-19

## 游戏界面

> 一些简单的界面展示



## 成员介绍与分工

| 朱子林  | 组长 代码逻辑设计 用户交互接口 游戏资源维护       |
| ---- | ----------------------------- |
| 沈思甜  | 主角移动逻辑 游戏主题设计UI制作 PPT制作       |
| 罗家安  | 物体移动逻辑 主角状态逻辑 GUI界面美化         |
| 林东方  | 碰撞逻辑，游戏音效，开发架构设计，游戏文档维护，PPT制作 |

## 游戏介绍

> 简述这款游戏的特点，设计思路，设计主题



## 游戏玩法

### 单人模式（抗疫模式）

> 简述游戏玩法和规则即可， @smzzl@忆苦

游戏里你将拥有一辆可以发射子弹的救护车，躲避或消灭病毒，造福人类 !

绿色病毒，可用子弹消灭，撞到得分-1

红色病毒，需跳跃躲避，撞到生命值-1

加速药水

减速药水

健康金币 :一个金币+2分

### 双人模式（共生模式）

> 简述游戏玩法和规则即可，@smzzl@忆苦

😷    2022年12月7日起，随着防疫“新十条”的发布，国人将开启与病毒共生的时代。完成一段时间 Gym 模式的练习后，玩家可以进入双人竞赛模式，选择角色展开大战。

&#x20;      在共生时代，人类将学会如何与病毒共、生、与别的同类共存。病毒可能不再是人类的敌人。相反，非致命绿色病毒会增加人类的免疫力(经验值)，也能使人拥有攻击对手(感染对手)的能力。

操作指示：

&#x20;                     左右移/跳跃   确定/发射子弹 &#x20;

&#x20;玩家1            WASD            Space

&#x20;    玩家2            上下左右         Enter

在共生模式里，您处在一个与病毒共生的世界里，初始状态为暴露期

药，仅当感染期时，HP+1，回到免疫期，无敌！

红色病毒，变为感染期！

绿色病毒，变为无症状，exp+1！

口罩，遮挡对方玩家视野3s

测温计，对方玩家左右方向键置反3s

## 单人模式（抗疫模式）

### 游戏设计思路

> 主要写游戏设计，对每一种道具的设计等@smzzl



### 道具效果

| 盾牌（金币）    | 加2分     |
| --------- | ------- |
| 蓝色药水      | 加速      |
| 粉色药水      | 减速      |
| 红色病毒（硬障碍） | HP-1    |
| 绿色病毒（软障碍） | 扣1分     |
| 子弹        | 可消灭绿色病毒 |

| 药    | 非免疫期，状态改为免疫期，仅当感染期时，HP+1                                                        |
| ---- | ------------------------------------------------------------------------------- |
| 红色病毒 | 非感染期，非免疫期，HP-1，状态改为感染期                                                          |
| 绿色病毒 | 非感染期，非免疫期，exp+1，状态改为无症状                                                         |
| 火锅   | 暴露期-无症状，无症状玩家等同于吃一个绿色病毒&#xA;暴露期-感染期，暴露期玩家等同于吃一个红色病毒&#xA;无症状-感染期，无症状玩家等同于吃一个红色病毒 |
| 口罩   | 吃到口罩后，遮挡对方玩家视野3s                                                                |
| 测温计  | 吃到测温计后，对方玩家左右方向键置反3s                                                            |

### UI设计与音效设计

> UI元素，页面之间的UI切换，音效设计@忆苦



### 结构体设计

```6502&#x20;assembly
 BASE struct
        posx    dd      ? ;位置x坐标
        posy    dd      ? ;位置y坐标
        lengthx dd      ? ;图片的width
        lengthy dd      ? ;图片的;heigth
        alive   dd      ? ;血量
        DC      dd      ? ;设备上下文
        rel_v   dd      ? ;相对速度
        course_id       dd      ? ;标记位于哪条跑道
BASE ends

;Player
Subject struct 
        base    BASE  <> 
        score           dd      ? ;得分（score）或经验值（exp）
        status          dd      ? ;状态——免疫期、暴露期、无症状
        has_hotpot      dd      ? ;是否聚餐
        has_mask        dd      ? ;对手是否带口罩
        has_fever       dd      ? ;对手是否发热
        
        ;移动逻辑
        flag_movleft    dd      ? ;正在向左移动的标记
        flag_movright   dd      ? ;正在向右移动的标记
        flag_jump       dd      ? ;跳跃标记
        time_jump       dd      ? ;记录跳跃时间
        time_mov        dd      ? ;记录移动时间
Subject ends

;道具和子弹
Targets struct
        base    BASE  <> 
        typeid  dd      ?
Targets ends

;按钮控件
Button struct 
        base     BASE <>
        DC       dd      ? ;
        DC_      dd      ? ;chosen
        is_click dd      ? ;按钮是否被点击
Button ends

;背景图片
BackGround struct
        DC_b    dd      ? ;
        DC_pu   dd      ? ;
        DC_pd   dd      ? ;
        DC_i    dd      ? ;
        DC_e    dd      ? ;
        DC_2p_c dd      ? ;
        DC_2p_cc dd     ? ;
BackGround ends

;
Object_DC struct
        env1    dd      ? ;
        env2    dd      ? ;
        env3    dd      ? ;
        sobs    dd      ? ;
        hobs    dd      ? ;
        accp    dd      ? ;
        decp    dd      ? ;
        coin    dd      ? ;
        hp_p    dd      ? ;
        bltL    dd      ? ;
        bltM    dd      ? ;
        bltR    dd      ? ;
Object_DC ends

;-----------------player choose-----------------
PlayerList struct
        DC              dd 4*2 dup(?) ;
        curid           dd ?          ;

        choose_confirm  dd ?          ;
PlayerList ends
```

### 代码架构

> 主要写一些函数之间的调用关系@smzzl



### 函数接口

#### 朱子林

```6502&#x20;assembly
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
```

#### 沈思甜

```6502&#x20;assembly
_Init_car proto ;小车初始化
_Move_process proto ;每帧更新都要调用，实现连续性移动或跳起
_Action_left proto ;小车左移
_Action_right proto ;小车右移
_Action_jump proto ;小车跳跃
_sst_test proto ;测试函数
```

#### 罗家安

```6502&#x20;assembly
_next_position proto :ptr BASE ;实现道具和子弹移动到所在轨道的下一个位置
_change_all_position proto ;遍历所有道具和子弹，使之移动
_targets_bullet_out_of_bound proto ;每帧判断所有道具和子弹是否越界
```

#### 林东方

```6502&#x20;assembly
_collision_Player_with_MONEY_1 proto :ptr Targets ;Player与“盾牌（金币）”的碰撞效果
_collision_Player_with_MONEY_2 proto :ptr Targets ;Player与“盾牌（金币）”的碰撞效果
_collision_Player_with_ACC proto :ptr Targets ;Player与“加速药剂”的碰撞效果
_collision_Player_with_DEC proto :ptr Targets ;Player与“减速药剂”的碰撞效果
_collision_Player_with_HARD proto :ptr Targets ;Player与“红色病毒（硬障碍）”的碰撞效果
_collision_Player_with_SOFT proto :ptr Targets ;Player与“绿色病毒（软障碍）”的碰撞效果
_collision_bullet_with_SOFT proto :ptr Targets ;bullet与“绿色病毒（软障碍）”的碰撞效果
_two_two_enum proto ;枚举Player和所有Targets，bullet和“红色病毒（软障碍）”是否碰撞

_Open_ALL_SOUND proto ;打开所有声音文件
_Close_ALL_SOUND proto ;关闭所有声音文件

_collision_Player_with_MONEY_1_SOUND proto ;Player与“盾牌（金币）”的碰撞音效
_collision_Player_with_MONEY_2_SOUND proto ;Player与“药”的碰撞音效
_collision_Player_with_ACC_SOUND proto ;Player与“加速药剂”的碰撞音效
_collision_Player_with_DEC_SOUND proto ;Player与“减速药剂”的碰撞音效
_collision_Player_with_HARD_SOUND proto ;Player与“红色病毒（硬障碍）”的碰撞音效
_collision_Player_with_SOFT_SOUND proto ;Player与“绿色病毒（软障碍）”的碰撞音效
_collision_bullet_with_SOFT_SOUND proto ;bullet与“绿色病毒（软障碍）”的碰撞音效

_Jump_SOUND proto ;跳跃时要触发这个音效
_Launch_SOUND proto ;发射子弹时要触发这个音效
_CarMove_SOUND proto ;小车左右移动时要触发这个音效

_BGM_SOUND proto ;Play时要触发这个音效
_END_SOUND proto ;得分界面的时候要播放
_Gameover_SOUND proto ;HP为0，游戏结束时要播放的音效
_BeginBGM_SOUND proto ;开始界面，选择Play和Start要播放这个音效

_Stop_BGM_SOUND proto ;游戏结束的时候StopBGM, 播放END
_Stop_END_SOUND proto ;开始新的一局，StopEnd，播放BGM
_Stop_Gameover_SOUND proto 
_Stop_BeginBGM_SOUND proto ;按下Play，就要关闭BeginBGM，播放游戏BGM_collision_Player_with_MONEY_1 proto :ptr Targets ;Player与“盾牌（金币）”的碰撞效果
_collision_Player_with_MONEY_2 proto :ptr Targets ;Player与“盾牌（金币）”的碰撞效果
_collision_Player_with_ACC proto :ptr Targets ;Player与“加速药剂”的碰撞效果
_collision_Player_with_DEC proto :ptr Targets ;Player与“减速药剂”的碰撞效果
_collision_Player_with_HARD proto :ptr Targets ;Player与“红色病毒（硬障碍）”的碰撞效果
_collision_Player_with_SOFT proto :ptr Targets ;Player与“绿色病毒（软障碍）”的碰撞效果
_collision_bullet_with_SOFT proto :ptr Targets ;bullet与“绿色病毒（软障碍）”的碰撞效果
_two_two_enum proto ;枚举Player和所有Targets，bullet和“绿色病毒（软障碍）”，检测碰撞

_Open_ALL_SOUND proto ;打开所有声音文件
_Close_ALL_SOUND proto ;关闭所有声音文件

_collision_Player_with_MONEY_1_SOUND proto ;Player与“盾牌（金币）”的碰撞音效
_collision_Player_with_MONEY_2_SOUND proto ;Player与“药”的碰撞音效
_collision_Player_with_ACC_SOUND proto ;Player与“加速药剂”的碰撞音效
_collision_Player_with_DEC_SOUND proto ;Player与“减速药剂”的碰撞音效
_collision_Player_with_HARD_SOUND proto ;Player与“红色病毒（硬障碍）”的碰撞音效
_collision_Player_with_SOFT_SOUND proto ;Player与“绿色病毒（软障碍）”的碰撞音效
_collision_bullet_with_SOFT_SOUND proto ;bullet与“绿色病毒（软障碍）”的碰撞音效

_Jump_SOUND proto ;跳跃时要触发这个音效
_Launch_SOUND proto ;发射子弹时要触发这个音效
_CarMove_SOUND proto ;小车左右移动时要触发这个音效

_BGM_SOUND proto ;Play时要触发这个音效
_END_SOUND proto ;得分界面的时候要播放
_Gameover_SOUND proto ;HP为0，游戏结束时要播放的音效
_BeginBGM_SOUND proto ;开始界面，选择Play和Start要播放这个音效

_Stop_BGM_SOUND proto ;游戏结束的时候StopBGM, 播放END
_Stop_END_SOUND proto ;开始新的一局，StopEnd，播放BGM
_Stop_Gameover_SOUND proto 
_Stop_BeginBGM_SOUND proto ;按下Play，就要关闭BeginBGM，播放游戏BGM
```



## 双人模式（共生模式）

### 游戏设计思路

> 主要写游戏设计，对每一种道具的设计等



### 道具效果

| 药    | 非免疫期，状态改为免疫期，仅当感染期时，HP+1                                                        |
| ---- | ------------------------------------------------------------------------------- |
| 红色病毒 | 非感染期，非免疫期，HP-1，状态改为感染期                                                          |
| 绿色病毒 | 非感染期，非免疫期，exp+1，状态改为无症状                                                         |
| 火锅   | 暴露期-无症状，无症状玩家等同于吃一个绿色病毒&#xA;暴露期-感染期，暴露期玩家等同于吃一个红色病毒&#xA;无症状-感染期，无症状玩家等同于吃一个红色病毒 |
| 口罩   | 吃到口罩后，遮挡对方玩家视野3s                                                                |
| 测温计  | 吃到测温计后，对方玩家左右方向键置反3s                                                            |

### UI设计与音效设计

> UI元素以及页面之间的UI切换，游戏音效@忆苦



### 代码架构

> 主要写一些函数之间的调用关系



### 函数接口

#### 朱子林

```6502&#x20;assembly

```

#### 沈思甜

```6502&#x20;assembly
;接受一个Subject对象（Player）
_Init_car_symbiotic proto :ptr Subject ;Player初始化
_Move_process_symbiotic proto :ptr Subject ;Player每帧更新都要调用，实现连续性移动或跳起
_Action_left_symbiotic proto :ptr Subject ;Player左移
_Action_right_symbiotic proto :ptr Subject ;Player右移
_Action_jump_symbiotic proto :ptr Subject ;Player跳跃
_sst_test_symbiotic proto ;测试函数
```

#### 罗家安

```6502&#x20;assembly
_hotpot_effect proto :ptr Subject, :ptr Subject ;Player与“火锅”的碰撞效果
_mask_effect proto :ptr Subject, :ptr Subject ;Player与“n95口罩”的碰撞效果
_fever_effect proto :ptr Subject, :ptr Subject ;Player与“测温计”的碰撞效果
_check_player_effect proto :ptr Subject ;更新玩家“火锅”、“n95口罩”和“测温计“的碰撞效果
_check_all_effect proto :ptr Subject, :ptr Subject ;更新所有玩家的碰撞效果
_change_status proto :ptr Subject, :ptr Subject ;一定时间之后改变玩家为暴露状态
_change_all_position_symbiotic proto ;共存模式下枚举所有道具，改变其位置
_targets_bullet_out_of_bound_symbiotic proto ;共存模式下每帧判断所有道具和子弹是否越界

```

#### 林东方

```6502&#x20;assembly
_collision_Player_with_medicine proto :ptr Subject, :ptr Targets ;Player与“药”的碰撞效果
_collision_Player_with_redVirus proto :ptr Subject, :ptr Targets ;Player与“红色病毒”的碰撞效果
_collision_Player_with_greenVirus proto :ptr Subject, :ptr Targets ;Player与“绿色病毒”的碰撞效果
_collision_Player_with_hotPot proto :ptr Subject, :ptr Targets ;Player与“火锅”的碰撞效果
_collision_Player_with_n95mask proto :ptr Subject, :ptr Targets ;Player与“n95口罩”的碰撞效果
_collision_Player_with_temperature proto :ptr Subject, :ptr Targets ;Player与“测温计”的碰撞效果
_two_two_enum_symbiotic proto :ptr Subject, :dword, :dword ;枚举Player和所有Targets，检测碰撞

_Play_medicine_SOUND proto ;玩家与“药”的碰撞音效
_Stop_medicine_SOUND proto 
_Play_hotPot_SOUND proto ;玩家与“火锅”的碰撞音效
_Stop_hotPot_SOUND proto
_Play_n95mask_SOUND proto ;玩家与“n95口罩”的碰撞音效
_Stop_n95mask_SOUND proto
_Play_temperature_SOUND proto ;玩家与“测温计”的碰撞音效
_Stop_temperature_SOUND proto
```

## 游戏创新点

### 技术创新



### 架构创新——并发解耦

> 整个项目架构@Phoenix

![fileDependency_n8xGSiRCvF](https://tvax2.sinaimg.cn/large/008vKTP8ly1h92svau77tj31t117tqal.jpg)

| data.asm | 全局变量文件  |
| -------- | ------- |
| main.rc  | 全局资源文件  |
| zzl.asm  | 朱子林写的函数 |
| sst.asm  | 沈思甜写的函数 |
| lja.asm  | 罗家安写的函数 |
| ldf.asm  | 林东方写的函数 |
| main.asm | 主文件     |

```makefile
ml /c /coff main.asm release/zzl.asm release/ldf.asm release/lja.asm release/sst.asm data.asm
Link main.obj zzl.obj ldf.obj lja.obj sst.obj main.res 
```

| zzl\_dev.asm | 朱子林的开发测试文件 |
| ------------ | ---------- |
| sst\_dev.asm | 沈思甜的开发测试文件 |
| lja\_dev.asm | 罗家安的开发测试文件 |
| ldf\_dev.asm | 林东方的开发测试文件 |

```makefile
# 生成zzl_dev.exe
zzl_dev:
  del *.exe
  rc main.rc
  ml $(ML_FLAGS) dev/zzl_dev.asm data.asm 
  link $(LINK_FLAGS) zzl_dev.obj data.obj main.res
  nmake clean
# zzl_dev.exe

# 生成ldf_dev.exe
ldf_dev:
  del *.exe
  rc main.rc
  ml $(ML_FLAGS) dev/ldf_dev.asm release/lja.asm data.asm
  link $(LINK_FLAGS) ldf_dev.obj lja.obj data.obj main.res
  nmake clean
# ldf_dev.exe

# 生成lja_dev.exe
lja_dev:
  del *.exe
  rc main.rc
  ml $(ML_FLAGS) dev/lja_dev.asm data.asm
  link $(LINK_FLAGS) lja_dev.obj data.obj main.res
  nmake clean
# lja_dev.exe

# 生成sst_dev.exe
sst_dev:
  del *.exe
  rc main.rc
  ml $(ML_FLAGS) dev/sst_dev.asm data.asm 
  link $(LINK_FLAGS) sst_dev.obj data.obj main.res
  nmake clean
```

| dev                            | 开发版      |
| ------------------------------ | -------- |
| game-web                       | 游戏文档网页   |
| global                         | 全局依赖     |
| release                        | 发布版      |
| resource                       | 图片资源     |
| sound                          | 音效资源     |
|                                |          |
| global.inc                     | 全局依赖文件   |
| global\_const.inc              | 全局常量定义文件 |
| global\_dev.inc                | 开发依赖     |
| global\_extrn.inc              | 外部变量声明   |
| global\_fun\_declare.inc       | 函数声明     |
| global\_head.inc               | 头文件依赖    |
| global\_public.inc             | 公有变量声明   |
| global\_struct\_definition.inc | 结构体定义    |

```text
asm-game:.
+---dev
|       ldf_dev.asm
|       ldf_gif.cpp
|       lja_dev.asm
|       sst_dev.asm
|       zzl_dev.asm
|       
+---game-web ;游戏文档网页
|    
+---global
|       global.inc ;全局依赖
|       global_const.inc ;全局常量定义
|       global_dev.inc ;开发依赖
|       global_extrn.inc ;外部变量声明
|       global_fun_declare.inc ;函数声明
|       global_head.inc ;依赖头文件
|       global_public.inc ;公有变量声明
|       global_struct_definition.inc ;结构体定义
|       
+---release
|       ldf.asm
|       lja.asm
|       sst.asm
|       zzl.asm
|       
+---resource
|
\---sound
```

### 题材创新



### UI创新


