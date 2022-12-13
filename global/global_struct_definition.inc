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
        DC_e    dd      ?
        DC_2p_c dd      ?
        DC_2p_cc dd     ?
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
Object_DC ends

;-----------------player choose-----------------
PlayerList struct
        DC              dd 4*2 dup(?) 
        curid           dd ?

        choose_confirm  dd      ?
PlayerList ends

;==================== 共生模式 ===========================



;==================== 共生模式 ===========================


