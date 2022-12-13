<template><div><h1 id="cyberpunk-covid-19" tabindex="-1"><a class="header-anchor" href="#cyberpunk-covid-19" aria-hidden="true">#</a> Cyberpunk Covid-19</h1>
<h2 id="游戏界面" tabindex="-1"><a class="header-anchor" href="#游戏界面" aria-hidden="true">#</a> 游戏界面</h2>
<blockquote>
<p>一些简单的界面展示</p>
</blockquote>
<h2 id="成员介绍与分工" tabindex="-1"><a class="header-anchor" href="#成员介绍与分工" aria-hidden="true">#</a> 成员介绍与分工</h2>
<table>
<thead>
<tr>
<th>朱子林</th>
<th>组长 代码逻辑设计 用户交互接口 游戏资源维护</th>
</tr>
</thead>
<tbody>
<tr>
<td>沈思甜</td>
<td>主角移动逻辑 游戏主题设计UI制作 PPT制作</td>
</tr>
<tr>
<td>罗家安</td>
<td>物体移动逻辑 主角状态逻辑 GUI界面美化</td>
</tr>
<tr>
<td>林东方</td>
<td>碰撞逻辑，游戏音效，开发架构设计，游戏文档维护，PPT制作</td>
</tr>
</tbody>
</table>
<h2 id="游戏介绍" tabindex="-1"><a class="header-anchor" href="#游戏介绍" aria-hidden="true">#</a> 游戏介绍</h2>
<blockquote>
<p>简述这款游戏的特点，设计思路，设计主题</p>
</blockquote>
<h2 id="游戏玩法" tabindex="-1"><a class="header-anchor" href="#游戏玩法" aria-hidden="true">#</a> 游戏玩法</h2>
<h3 id="单人模式-抗疫模式" tabindex="-1"><a class="header-anchor" href="#单人模式-抗疫模式" aria-hidden="true">#</a> 单人模式（抗疫模式）</h3>
<blockquote>
<p>简述游戏玩法和规则即可， @smzzl@忆苦</p>
</blockquote>
<p>游戏里你将拥有一辆可以发射子弹的救护车，躲避或消灭病毒，造福人类 !</p>
<p>绿色病毒，可用子弹消灭，撞到得分-1</p>
<p>红色病毒，需跳跃躲避，撞到生命值-1</p>
<p>加速药水</p>
<p>减速药水</p>
<p>健康金币 :一个金币+2分</p>
<h3 id="双人模式-共生模式" tabindex="-1"><a class="header-anchor" href="#双人模式-共生模式" aria-hidden="true">#</a> 双人模式（共生模式）</h3>
<blockquote>
<p>简述游戏玩法和规则即可，@smzzl@忆苦</p>
</blockquote>
<p>😷    2022年12月7日起，随着防疫“新十条”的发布，国人将开启与病毒共生的时代。完成一段时间 Gym 模式的练习后，玩家可以进入双人竞赛模式，选择角色展开大战。</p>
<p>       在共生时代，人类将学会如何与病毒共、生、与别的同类共存。病毒可能不再是人类的敌人。相反，非致命绿色病毒会增加人类的免疫力(经验值)，也能使人拥有攻击对手(感染对手)的能力。</p>
<p>操作指示：</p>
<p>                      左右移/跳跃   确定/发射子弹  </p>
<p> 玩家1            WASD            Space</p>
<p>     玩家2            上下左右         Enter</p>
<p>在共生模式里，您处在一个与病毒共生的世界里，初始状态为暴露期</p>
<p>药，仅当感染期时，HP+1，回到免疫期，无敌！</p>
<p>红色病毒，变为感染期！</p>
<p>绿色病毒，变为无症状，exp+1！</p>
<p>口罩，遮挡对方玩家视野3s</p>
<p>测温计，对方玩家左右方向键置反3s</p>
<h2 id="单人模式-抗疫模式-1" tabindex="-1"><a class="header-anchor" href="#单人模式-抗疫模式-1" aria-hidden="true">#</a> 单人模式（抗疫模式）</h2>
<h3 id="游戏设计思路" tabindex="-1"><a class="header-anchor" href="#游戏设计思路" aria-hidden="true">#</a> 游戏设计思路</h3>
<blockquote>
<p>主要写游戏设计，对每一种道具的设计等@smzzl</p>
</blockquote>
<h3 id="道具效果" tabindex="-1"><a class="header-anchor" href="#道具效果" aria-hidden="true">#</a> 道具效果</h3>
<table>
<thead>
<tr>
<th>盾牌（金币）</th>
<th>加2分</th>
</tr>
</thead>
<tbody>
<tr>
<td>蓝色药水</td>
<td>加速</td>
</tr>
<tr>
<td>粉色药水</td>
<td>减速</td>
</tr>
<tr>
<td>红色病毒（硬障碍）</td>
<td>HP-1</td>
</tr>
<tr>
<td>绿色病毒（软障碍）</td>
<td>扣1分</td>
</tr>
<tr>
<td>子弹</td>
<td>可消灭绿色病毒</td>
</tr>
</tbody>
</table>
<table>
<thead>
<tr>
<th>药</th>
<th>非免疫期，状态改为免疫期，仅当感染期时，HP+1</th>
</tr>
</thead>
<tbody>
<tr>
<td>红色病毒</td>
<td>非感染期，非免疫期，HP-1，状态改为感染期</td>
</tr>
<tr>
<td>绿色病毒</td>
<td>非感染期，非免疫期，exp+1，状态改为无症状</td>
</tr>
<tr>
<td>火锅</td>
<td>暴露期-无症状，无症状玩家等同于吃一个绿色病毒
暴露期-感染期，暴露期玩家等同于吃一个红色病毒
无症状-感染期，无症状玩家等同于吃一个红色病毒</td>
</tr>
<tr>
<td>口罩</td>
<td>吃到口罩后，遮挡对方玩家视野3s</td>
</tr>
<tr>
<td>测温计</td>
<td>吃到测温计后，对方玩家左右方向键置反3s</td>
</tr>
</tbody>
</table>
<h3 id="ui设计与音效设计" tabindex="-1"><a class="header-anchor" href="#ui设计与音效设计" aria-hidden="true">#</a> UI设计与音效设计</h3>
<blockquote>
<p>UI元素，页面之间的UI切换，音效设计@忆苦</p>
</blockquote>
<h3 id="结构体设计" tabindex="-1"><a class="header-anchor" href="#结构体设计" aria-hidden="true">#</a> 结构体设计</h3>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code> BASE struct
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
        base    BASE  &lt;&gt; 
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
        base    BASE  &lt;&gt; 
        typeid  dd      ?
Targets ends

;按钮控件
Button struct 
        base     BASE &lt;&gt;
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
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h3 id="代码架构" tabindex="-1"><a class="header-anchor" href="#代码架构" aria-hidden="true">#</a> 代码架构</h3>
<blockquote>
<p>主要写一些函数之间的调用关系@smzzl</p>
</blockquote>
<h3 id="函数接口" tabindex="-1"><a class="header-anchor" href="#函数接口" aria-hidden="true">#</a> 函数接口</h3>
<h4 id="朱子林" tabindex="-1"><a class="header-anchor" href="#朱子林" aria-hidden="true">#</a> 朱子林</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_Init_bullet proto ;初始化子弹
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
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h4 id="沈思甜" tabindex="-1"><a class="header-anchor" href="#沈思甜" aria-hidden="true">#</a> 沈思甜</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_Init_car proto ;小车初始化
_Move_process proto ;每帧更新都要调用，实现连续性移动或跳起
_Action_left proto ;小车左移
_Action_right proto ;小车右移
_Action_jump proto ;小车跳跃
_sst_test proto ;测试函数
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h4 id="罗家安" tabindex="-1"><a class="header-anchor" href="#罗家安" aria-hidden="true">#</a> 罗家安</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_next_position proto :ptr BASE ;实现道具和子弹移动到所在轨道的下一个位置
_change_all_position proto ;遍历所有道具和子弹，使之移动
_targets_bullet_out_of_bound proto ;每帧判断所有道具和子弹是否越界
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h4 id="林东方" tabindex="-1"><a class="header-anchor" href="#林东方" aria-hidden="true">#</a> 林东方</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_collision_Player_with_MONEY_1 proto :ptr Targets ;Player与“盾牌（金币）”的碰撞效果
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
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h2 id="双人模式-共生模式-1" tabindex="-1"><a class="header-anchor" href="#双人模式-共生模式-1" aria-hidden="true">#</a> 双人模式（共生模式）</h2>
<h3 id="游戏设计思路-1" tabindex="-1"><a class="header-anchor" href="#游戏设计思路-1" aria-hidden="true">#</a> 游戏设计思路</h3>
<blockquote>
<p>主要写游戏设计，对每一种道具的设计等</p>
</blockquote>
<h3 id="道具效果-1" tabindex="-1"><a class="header-anchor" href="#道具效果-1" aria-hidden="true">#</a> 道具效果</h3>
<table>
<thead>
<tr>
<th>药</th>
<th>非免疫期，状态改为免疫期，仅当感染期时，HP+1</th>
</tr>
</thead>
<tbody>
<tr>
<td>红色病毒</td>
<td>非感染期，非免疫期，HP-1，状态改为感染期</td>
</tr>
<tr>
<td>绿色病毒</td>
<td>非感染期，非免疫期，exp+1，状态改为无症状</td>
</tr>
<tr>
<td>火锅</td>
<td>暴露期-无症状，无症状玩家等同于吃一个绿色病毒
暴露期-感染期，暴露期玩家等同于吃一个红色病毒
无症状-感染期，无症状玩家等同于吃一个红色病毒</td>
</tr>
<tr>
<td>口罩</td>
<td>吃到口罩后，遮挡对方玩家视野3s</td>
</tr>
<tr>
<td>测温计</td>
<td>吃到测温计后，对方玩家左右方向键置反3s</td>
</tr>
</tbody>
</table>
<h3 id="ui设计与音效设计-1" tabindex="-1"><a class="header-anchor" href="#ui设计与音效设计-1" aria-hidden="true">#</a> UI设计与音效设计</h3>
<blockquote>
<p>UI元素以及页面之间的UI切换，游戏音效@忆苦</p>
</blockquote>
<h3 id="代码架构-1" tabindex="-1"><a class="header-anchor" href="#代码架构-1" aria-hidden="true">#</a> 代码架构</h3>
<blockquote>
<p>主要写一些函数之间的调用关系</p>
</blockquote>
<h3 id="函数接口-1" tabindex="-1"><a class="header-anchor" href="#函数接口-1" aria-hidden="true">#</a> 函数接口</h3>
<h4 id="朱子林-1" tabindex="-1"><a class="header-anchor" href="#朱子林-1" aria-hidden="true">#</a> 朱子林</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div></div></div><h4 id="沈思甜-1" tabindex="-1"><a class="header-anchor" href="#沈思甜-1" aria-hidden="true">#</a> 沈思甜</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>;接受一个Subject对象（Player）
_Init_car_symbiotic proto :ptr Subject ;Player初始化
_Move_process_symbiotic proto :ptr Subject ;Player每帧更新都要调用，实现连续性移动或跳起
_Action_left_symbiotic proto :ptr Subject ;Player左移
_Action_right_symbiotic proto :ptr Subject ;Player右移
_Action_jump_symbiotic proto :ptr Subject ;Player跳跃
_sst_test_symbiotic proto ;测试函数
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h4 id="罗家安-1" tabindex="-1"><a class="header-anchor" href="#罗家安-1" aria-hidden="true">#</a> 罗家安</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_hotpot_effect proto :ptr Subject, :ptr Subject ;Player与“火锅”的碰撞效果
_mask_effect proto :ptr Subject, :ptr Subject ;Player与“n95口罩”的碰撞效果
_fever_effect proto :ptr Subject, :ptr Subject ;Player与“测温计”的碰撞效果
_check_player_effect proto :ptr Subject ;更新玩家“火锅”、“n95口罩”和“测温计“的碰撞效果
_check_all_effect proto :ptr Subject, :ptr Subject ;更新所有玩家的碰撞效果
_change_status proto :ptr Subject, :ptr Subject ;一定时间之后改变玩家为暴露状态
_change_all_position_symbiotic proto ;共存模式下枚举所有道具，改变其位置
_targets_bullet_out_of_bound_symbiotic proto ;共存模式下每帧判断所有道具和子弹是否越界

</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h4 id="林东方-1" tabindex="-1"><a class="header-anchor" href="#林东方-1" aria-hidden="true">#</a> 林东方</h4>
<div class="language-6502 line-numbers-mode" data-ext="6502"><pre v-pre class="language-6502"><code>_collision_Player_with_medicine proto :ptr Subject, :ptr Targets ;Player与“药”的碰撞效果
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
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h2 id="游戏创新点" tabindex="-1"><a class="header-anchor" href="#游戏创新点" aria-hidden="true">#</a> 游戏创新点</h2>
<h3 id="技术创新" tabindex="-1"><a class="header-anchor" href="#技术创新" aria-hidden="true">#</a> 技术创新</h3>
<h3 id="架构创新——并发解耦" tabindex="-1"><a class="header-anchor" href="#架构创新——并发解耦" aria-hidden="true">#</a> 架构创新——并发解耦</h3>
<blockquote>
<p>整个项目架构@Phoenix</p>
</blockquote>
<p><img src="https://tvax2.sinaimg.cn/large/008vKTP8ly1h92svau77tj31t117tqal.jpg" alt="fileDependency_n8xGSiRCvF"></p>
<table>
<thead>
<tr>
<th>data.asm</th>
<th>全局变量文件</th>
</tr>
</thead>
<tbody>
<tr>
<td>main.rc</td>
<td>全局资源文件</td>
</tr>
<tr>
<td>zzl.asm</td>
<td>朱子林写的函数</td>
</tr>
<tr>
<td>sst.asm</td>
<td>沈思甜写的函数</td>
</tr>
<tr>
<td>lja.asm</td>
<td>罗家安写的函数</td>
</tr>
<tr>
<td>ldf.asm</td>
<td>林东方写的函数</td>
</tr>
<tr>
<td>main.asm</td>
<td>主文件</td>
</tr>
</tbody>
</table>
<div class="language-makefile line-numbers-mode" data-ext="makefile"><pre v-pre class="language-makefile"><code>ml /c /coff main.asm release/zzl.asm release/ldf.asm release/lja.asm release/sst.asm data.asm
Link main.obj zzl.obj ldf.obj lja.obj sst.obj main.res 
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div></div></div><table>
<thead>
<tr>
<th>zzl_dev.asm</th>
<th>朱子林的开发测试文件</th>
</tr>
</thead>
<tbody>
<tr>
<td>sst_dev.asm</td>
<td>沈思甜的开发测试文件</td>
</tr>
<tr>
<td>lja_dev.asm</td>
<td>罗家安的开发测试文件</td>
</tr>
<tr>
<td>ldf_dev.asm</td>
<td>林东方的开发测试文件</td>
</tr>
</tbody>
</table>
<div class="language-makefile line-numbers-mode" data-ext="makefile"><pre v-pre class="language-makefile"><code><span class="token comment"># 生成zzl_dev.exe</span>
<span class="token target symbol">zzl_dev</span><span class="token punctuation">:</span>
  del *.exe
  rc main.rc
  ml <span class="token variable">$</span><span class="token punctuation">(</span>ML_FLAGS<span class="token punctuation">)</span> dev/zzl_dev.asm data.asm 
  link <span class="token variable">$</span><span class="token punctuation">(</span>LINK_FLAGS<span class="token punctuation">)</span> zzl_dev.obj data.obj main.res
  nmake clean
<span class="token comment"># zzl_dev.exe</span>

<span class="token comment"># 生成ldf_dev.exe</span>
<span class="token target symbol">ldf_dev</span><span class="token punctuation">:</span>
  del *.exe
  rc main.rc
  ml <span class="token variable">$</span><span class="token punctuation">(</span>ML_FLAGS<span class="token punctuation">)</span> dev/ldf_dev.asm release/lja.asm data.asm
  link <span class="token variable">$</span><span class="token punctuation">(</span>LINK_FLAGS<span class="token punctuation">)</span> ldf_dev.obj lja.obj data.obj main.res
  nmake clean
<span class="token comment"># ldf_dev.exe</span>

<span class="token comment"># 生成lja_dev.exe</span>
<span class="token target symbol">lja_dev</span><span class="token punctuation">:</span>
  del *.exe
  rc main.rc
  ml <span class="token variable">$</span><span class="token punctuation">(</span>ML_FLAGS<span class="token punctuation">)</span> dev/lja_dev.asm data.asm
  link <span class="token variable">$</span><span class="token punctuation">(</span>LINK_FLAGS<span class="token punctuation">)</span> lja_dev.obj data.obj main.res
  nmake clean
<span class="token comment"># lja_dev.exe</span>

<span class="token comment"># 生成sst_dev.exe</span>
<span class="token target symbol">sst_dev</span><span class="token punctuation">:</span>
  del *.exe
  rc main.rc
  ml <span class="token variable">$</span><span class="token punctuation">(</span>ML_FLAGS<span class="token punctuation">)</span> dev/sst_dev.asm data.asm 
  link <span class="token variable">$</span><span class="token punctuation">(</span>LINK_FLAGS<span class="token punctuation">)</span> sst_dev.obj data.obj main.res
  nmake clean
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><table>
<thead>
<tr>
<th>dev</th>
<th>开发版</th>
</tr>
</thead>
<tbody>
<tr>
<td>game-web</td>
<td>游戏文档网页</td>
</tr>
<tr>
<td>global</td>
<td>全局依赖</td>
</tr>
<tr>
<td>release</td>
<td>发布版</td>
</tr>
<tr>
<td>resource</td>
<td>图片资源</td>
</tr>
<tr>
<td>sound</td>
<td>音效资源</td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
<tr>
<td>global.inc</td>
<td>全局依赖文件</td>
</tr>
<tr>
<td>global_const.inc</td>
<td>全局常量定义文件</td>
</tr>
<tr>
<td>global_dev.inc</td>
<td>开发依赖</td>
</tr>
<tr>
<td>global_extrn.inc</td>
<td>外部变量声明</td>
</tr>
<tr>
<td>global_fun_declare.inc</td>
<td>函数声明</td>
</tr>
<tr>
<td>global_head.inc</td>
<td>头文件依赖</td>
</tr>
<tr>
<td>global_public.inc</td>
<td>公有变量声明</td>
</tr>
<tr>
<td>global_struct_definition.inc</td>
<td>结构体定义</td>
</tr>
</tbody>
</table>
<div class="language-text line-numbers-mode" data-ext="text"><pre v-pre class="language-text"><code>asm-game:.
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
</code></pre><div class="line-numbers" aria-hidden="true"><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div><div class="line-number"></div></div></div><h3 id="题材创新" tabindex="-1"><a class="header-anchor" href="#题材创新" aria-hidden="true">#</a> 题材创新</h3>
<h3 id="ui创新" tabindex="-1"><a class="header-anchor" href="#ui创新" aria-hidden="true">#</a> UI创新</h3>
</div></template>


