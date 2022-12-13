BASE struct
        posx    dd      ?
        posy    dd      ?
        lengthx dd      ?
        lengthy dd      ?
        alive   dd      ?
        DC      dd      ?  
        rel_v   dd      ?  
        course_id       dd      ? ;0,1,2
BASE ends

Subject struct 
        base    BASE  <> 
        curid           dd      ?
        score           dd      ?
        status          dd      ?
        has_hotpot      dd      ?
        has_mask        dd      ?
        has_fever       dd      ?
        
        ;移动逻辑
        flag_movleft    dd      ?
        flag_movright    dd      ?
        flag_jump       dd      ?
        time_jump       dd      ?
        time_mov        dd      ?
Subject ends

Targets struct
        base    BASE  <> 
        typeid  dd      ?
Targets ends

Button struct 
        base     BASE <>
        DC       dd      ?  
        DC_      dd      ? ;chosen
        is_click dd      ?
Button ends

BackGround struct
        DC_b    dd      ?
        DC_pu   dd      ?
        DC_pd   dd      ?
        DC_i    dd      ?
        DC_i2    dd      ?
        DC_i3    dd      ?
        DC_e    dd      ?
        DC_2p_c dd      ?
        DC_2p_cc dd     ?
        DC_ov_w  dd ?
        DC_ov_l  dd ?
BackGround ends

Object_DC struct
        env1    dd      ?
        env2    dd      ?
        env3    dd      ?
        sobs    dd      ?
        hobs    dd      ?
        accp    dd      ?
        decp    dd      ?
        coin    dd      ?
        hp_p    dd      ?
        bltL    dd      ?
        bltM    dd      ?
        bltR    dd      ?
        pauw    dd      ?
;new prop
        medicine       dd     ? ;药
        redVirus       dd     ? ;红色病毒
        greenVirus     dd     ? ;绿色病毒

        hotPot         dd     ? ;火锅
        n95mask        dd     ? ;口罩
        temperature    dd     ? ;测温计

        eathotpot      dd     ?
;special effects
        soft_inf       dd     ? ;无症状
        infected       dd     ? ;感染
        cant_inf       dd      ?;免疫
;
        titles          dd ?
Object_DC ends

;-----------------player choose-----------------
PlayerList struct
        DC              dd 4*2 dup(?) ;DC[0],   DC[2]    ,   DC[4]    ,   DC[6]    
        curid           dd ?

        choose_confirm  dd      ?
PlayerList ends

;==================== 共生模式 ===========================



;==================== 共生模式 ===========================


