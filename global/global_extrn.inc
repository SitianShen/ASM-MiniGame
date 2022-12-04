extrn player:Subject         
extrn bullet:Subject             
extrn targets:dword ;不知道会不会有bug，本地调试很正常
extrn digitals_DC:dword


;zzl own
extrn button_play:Button      
extrn button_start:Button      
extrn button_back:Button      
extrn button_exit:Button       
extrn backGround:BackGround       
extrn object_DC:Object_DC        

extrn hInstance:dword       
extrn hWinMain:dword      
extrn hDCBack:dword         
extrn hDCGame:dword         
extrn hDCObj1:dword        
extrn dwNowBack:dword     

extrn flag_jump:dword               
extrn flag_movleft:dword          
extrn flag_movright:dword           
extrn stdtime_jump:dword            
extrn time_jump:dword              
extrn stdtime_mov:dword             
extrn time_mov:dword             
extrn cur_interface:dword     

extrn target_number:dword       
extrn speed:dword
extrn speed_acc_time:dword
extrn speed_dec_time:dword

extrn object1H:dword   
extrn object1W:dword      
extrn object_move_v:dword   
extrn POSCNT:dword          ; NEXTPOS的计数器