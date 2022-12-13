asm-game:.
+---dev
|       ldf_dev.asm
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