.386
.model flat, stdcall
option casemap: none

include global.inc

public player         
public bullet             
public targets

;zzl own
public button_play      
public button_start      
public button_back      
public button_exit       
public backGround       
public object_DC        

public hInstance       
public hWinMain      
public hDCBack         
public hDCGame         
public hDCObj1        
public dwNowBack     

public flag_jump               
public flag_movleft          
public flag_movright           
public stdtime_jump          
public time_jump              
public stdtime_mov             
public time_mov             
public cur_interface     

public target_number       
public speed

public object1H   
public object1W      
public object_move_v  
public POSCNT

end