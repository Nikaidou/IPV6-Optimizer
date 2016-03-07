@echo off&setlocal enabledelayedexpansion
MODE con: COLS=50 lines=18
TITLE V120510 Created By 真红酱
cls
echo 请右键以管理员身份运行
echo 首次运行请先运行网络设置脚本
netsh interface ipv6 isatap set state disable >nul
echo 隧道已关闭
echo.
pause
echo 隧道正在开启
netsh interface ipv6 isatap set state enable
set var=0
:set
cls
color 07
TITLE IPV6隧道安装
@echo [0] 更换隧道至：西南交通大学
@echo [1] 更换隧道至：上海交通大学[1]
@echo [2] 更换隧道至：上海交通大学[2]
@echo [3] 更换隧道至：清华大学 
@echo [4] 更换隧道至：北京邮电大学
@echo [5] 更换隧道至：平顶山大学 
@echo [6] 更换隧道至：河南工程学院
@echo [7] 更换隧道至：华南农业大学 
@echo [8] 更换隧道至：西安建筑科技大学 
@echo [9] 更换隧道至：西北师范大学 
@echo [10] 更换隧道至：湖南大学

@echo [11] 更换隧道至：四川大学
@echo [12] 更换隧道至：华中科技大学
@echo [13] 更换隧道至：北京师范大学

set /p var=请选择对应序号[?] 
 
if "%var%" == "1" GOTO c1 
if "%var%" == "2" goto c2 
if "%var%" == "3" goto c3 
if "%var%" == "4" goto c4 
if "%var%" == "5" GOTO c5
if "%var%" == "6" goto c6 
if "%var%" == "7" goto c7 
if "%var%" == "8" goto c8 
if "%var%" == "9" goto c9 
if "%var%" == "10" goto c10
if "%var%" == "11" goto c11
if "%var%" == "12" goto c12
if "%var%" == "13" goto c13
if "%var%" == "0" goto c0
goto set

:c0 
title 更换隧道至：西南交通大学
netsh interface ipv6 isatap set router 10.200.0.2
goto test 


:c1 
title 更换隧道至：上海交通大学[1]
netsh interface ipv6 isatap set router isatap.sjtu.edu.cn
goto test 

:c2
title 更换隧道至：上海交通大学[2]
netsh interface ipv6 isatap set router 202.120.58.150
goto test 
 
:c3 
title 更换隧道至：清华大学 
netsh interface ipv6 isatap set router 59.66.4.50
goto test 

:c4
title 更换隧道至：北京邮电大学
netsh interface ipv6 isatap set router 221.68.71.43
goto test 

:c5
title 更换隧道至：平顶山大学 
netsh interface ipv6 isatap set router 211.69.16.36 
goto test 

:c6
title 更换隧道至：河南工程学院
netsh interface ipv6 isatap set router 211.84.0.1
goto test 

:c7
title 更换隧道至：华南农业大学 
netsh interface ipv6 isatap set router isatap.scau.edu.cn
goto test 

:c8
title 更换隧道至：西安建筑科技大学 
netsh interface ipv6 isatap set router isatap.xauat.edu.cn
goto test 

:c9
title 更换隧道至：西北师范大学 
netsh interface ipv6 isatap set router isatap.nwnu.edu.cn
goto test 

:c10
title 更换隧道至：湖南大学
netsh interface ipv6 isatap set router 210.43.96.182
goto test

:c11
title 更换隧道至：四川大学
netsh interface ipv6 isatap set router 202.115.39.98
goto test

:c12
title 更换隧道至：华中科技大学
netsh interface ipv6 isatap set router 218.199.111.9
goto test

:c13
title 更换隧道至：北京师范大学
netsh interface ipv6 isatap set router 202.112.95.129
goto test 

:TEST
cls 
echo 请要耐心等待
timeout -t 5
ipconfig | find /I "2001:da8" >nul
if %ERRORLEVEL% == 0 (goto OK )
ipconfig | find /I "2001:250" >nul
if %ERRORLEVEL% == 0 (goto OK )

cls
color ce
echo 没有检测到IPV6协议
echo 请重新设置
pause
set /a var+=1
goto set






:OK
cls
echo IPV6隧道安装成功
color 2e
echo.
for /f "tokens=16*" %%1 in ('ipconfig ^| find /I "2001:da8"') do (echo %%1 )
for /f "tokens=16*" %%1 in ('ipconfig ^| find /I "2001:250"') do (echo %%1 )
echo.
pause
set /a var+=1
goto set

