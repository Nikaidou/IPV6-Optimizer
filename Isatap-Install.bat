@echo off&setlocal enabledelayedexpansion
MODE con: COLS=50 lines=18
TITLE V120510 Created By ��콴
cls
echo ���Ҽ��Թ���Ա�������
echo �״��������������������ýű�
netsh interface ipv6 isatap set state disable >nul
echo ����ѹر�
echo.
pause
echo ������ڿ���
netsh interface ipv6 isatap set state enable
set var=0
:set
cls
color 07
TITLE IPV6�����װ
@echo [0] ��������������Ͻ�ͨ��ѧ
@echo [1] ������������Ϻ���ͨ��ѧ[1]
@echo [2] ������������Ϻ���ͨ��ѧ[2]
@echo [3] ������������廪��ѧ 
@echo [4] ����������������ʵ��ѧ
@echo [5] �����������ƽ��ɽ��ѧ 
@echo [6] ��������������Ϲ���ѧԺ
@echo [7] ���������������ũҵ��ѧ 
@echo [8] ��������������������Ƽ���ѧ 
@echo [9] ���������������ʦ����ѧ 
@echo [10] ��������������ϴ�ѧ

@echo [11] ������������Ĵ���ѧ
@echo [12] ��������������пƼ���ѧ
@echo [13] ���������������ʦ����ѧ

set /p var=��ѡ���Ӧ���[?] 
 
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
title ��������������Ͻ�ͨ��ѧ
netsh interface ipv6 isatap set router 10.200.0.2
goto test 


:c1 
title ������������Ϻ���ͨ��ѧ[1]
netsh interface ipv6 isatap set router isatap.sjtu.edu.cn
goto test 

:c2
title ������������Ϻ���ͨ��ѧ[2]
netsh interface ipv6 isatap set router 202.120.58.150
goto test 
 
:c3 
title ������������廪��ѧ 
netsh interface ipv6 isatap set router 59.66.4.50
goto test 

:c4
title ����������������ʵ��ѧ
netsh interface ipv6 isatap set router 221.68.71.43
goto test 

:c5
title �����������ƽ��ɽ��ѧ 
netsh interface ipv6 isatap set router 211.69.16.36 
goto test 

:c6
title ��������������Ϲ���ѧԺ
netsh interface ipv6 isatap set router 211.84.0.1
goto test 

:c7
title ���������������ũҵ��ѧ 
netsh interface ipv6 isatap set router isatap.scau.edu.cn
goto test 

:c8
title ��������������������Ƽ���ѧ 
netsh interface ipv6 isatap set router isatap.xauat.edu.cn
goto test 

:c9
title ���������������ʦ����ѧ 
netsh interface ipv6 isatap set router isatap.nwnu.edu.cn
goto test 

:c10
title ��������������ϴ�ѧ
netsh interface ipv6 isatap set router 210.43.96.182
goto test

:c11
title ������������Ĵ���ѧ
netsh interface ipv6 isatap set router 202.115.39.98
goto test

:c12
title ��������������пƼ���ѧ
netsh interface ipv6 isatap set router 218.199.111.9
goto test

:c13
title ���������������ʦ����ѧ
netsh interface ipv6 isatap set router 202.112.95.129
goto test 

:TEST
cls 
echo ��Ҫ���ĵȴ�
timeout -t 5
ipconfig | find /I "2001:da8" >nul
if %ERRORLEVEL% == 0 (goto OK )
ipconfig | find /I "2001:250" >nul
if %ERRORLEVEL% == 0 (goto OK )

cls
color ce
echo û�м�⵽IPV6Э��
echo ����������
pause
set /a var+=1
goto set






:OK
cls
echo IPV6�����װ�ɹ�
color 2e
echo.
for /f "tokens=16*" %%1 in ('ipconfig ^| find /I "2001:da8"') do (echo %%1 )
for /f "tokens=16*" %%1 in ('ipconfig ^| find /I "2001:250"') do (echo %%1 )
echo.
pause
set /a var+=1
goto set

