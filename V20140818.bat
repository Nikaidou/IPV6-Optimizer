@echo off&setlocal enabledelayedexpansion
MODE con: COLS=50 lines=7
TITLE V140518 By ��콴
set schoolipv6=2001:da8:6005
cls
color ce
echo WIN7���Ҽ��Թ���Ա�������
echo.
echo ȷ�����������Ͻ��й���Ա����
echo.
pause

TITLE �ű���װʹ��˵��
cls

rem ��Ȩ˵����ֹ�޸�
echo =========���ڰ�Ȩ=========
echo �ýű������Ͻ�ͨ��ѧ��콴����
echo �κ��˿������κ���ʽ�����޸�
pause

cls
echo =========���ڰ�װ=========
echo ��IPV4��ַ��ͷΪ192.168�������Ƿ�ʹ��·����
echo ʹ��·�������ܵ����޷�����IPV6
echo ·������ʹ��WAN�˿ڼ��ɵ���������ʹ��
pause

cls
echo =========��װע��=========
echo ʹ�ô�IPV6�����벻Ҫ��װ���
echo �������IPV4��·(����)
pause

:begin
CLS
color 07
TITLE IPV6��װж��
@echo [1] IPV6��װ
@echo [9] IPV6ж��


set var=0
set /p var=��ѡ���Ӧ���[?] 
if "%var%" == "9" goto uninstall

:install


cls
echo �밴��ѡ����������IPV6Э��
echo ����IPV4��IPV6Э��������ѡ���Զ���ȡIP��ַ
echo.
control netconnections
pause



title �����Ż�����
echo �����ĵȴ�,������Ҫ���ɷ���
echo �벻�������κδ�����ʾ
echo ��ʱ���޷�Ӧ���������нű�
ipv6 install >nul
cls
echo �����ĵȴ�,������Ҫ���ɷ���
echo �벻�������κδ�����ʾ
ipconfig/flushdns >nul
ipconfig/registerdns >nul
netsh interface ipv6 6to4 set relay disable >nul
netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled >nul
netsh interface ipv6 6to4 set routing routing=disabled sitelocals=disabled >nul
netsh interface ipv6 isatap set router 0.0.0.0 >nul
netsh interface ipv6 isatap set router disable >nul
netsh interface ipv6 isatap set state disable >nul
netsh interface ipv6 set teredo disable >nul
netsh interface ipv6 set privacy disable >nul
sc config iphlpsvc start= auto >nul
net start iphlpsvc >nul
sc config 6to4 start= auto >nul
net start 6to4 >nul
ROUTE DELETE ::/0 >nul

netsh interface ipv6 set interface "��������" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "��������" advertise=disabled >nul
Netsh interface ipv6 add dns "��������" 2001:470:20::2 index=3 >nul
Netsh interface ipv6 add dns "��������" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "��������" 2001:4860:4860::8844 index=2 >nul

netsh interface ipv6 set interface "������������" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "������������" advertise=disabled >nul
Netsh interface ipv6 add dns "������������" 2001:470:20::2 index=3 >nul
Netsh interface ipv6 add dns "������������" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "������������" 2001:4860:4860::8844 index=2 >nul

netsh interface ipv6 set interface "Wi-Fi" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "Wi-Fi" advertise=disabled >nul
Netsh interface ipv6 add dns "Wi-Fi" 2001:470:20::2 index=3 >nul
Netsh interface ipv6 add dns "Wi-Fi" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "Wi-Fi" 2001:4860:4860::8844 index=2 >nul


for /f "skip=3 tokens=3,* delims= " %%i in ('netsh interface show interface') do (
netsh interface ipv6 set interface "%%j" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "%%j" advertise=disabled >nul
Netsh interface ipv6 add dns "%%j" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "%%j" 2001:4860:4860::8844 index=2 >nul
Netsh interface ipv6 add dns "%%j" 2001:470:20::2 index=3 >nul
)



cls
find "2001:da8:9000::232" %windir%\SYSTEM32\drivers\etc\hosts > nul
if %errorlevel%==1 (
@echo. >>%systemroot%\system32\drivers\etc\hosts
@echo [2001:da8:9000::232]   bt.neu6.edu.cn>>%systemroot%\system32\drivers\etc\hosts
@echo. >>%systemroot%\system32\drivers\etc\hosts
)
cls


rem ipconfig /flushdns >nul
rem ipconfig /registerdns >nul
rem ipconfig /release >nul
rem ipconfig /renew >nul
color ce
ipconfig | find /I "%schoolipv6%" >nul
if  %ERRORLEVEL% == 0	color 2e
cls
for /f "tokens=16*" %%1 in ('ipconfig ^| find /I "%schoolipv6%"') do (echo %%1 ) 
echo �Ż��������
echo ��ɫ����IPV6����
echo.
echo.
pause
cls
echo ����鿴,��ѡ��ʾ�����豸
echo ɾ�������������е��������������
echo �ؼ��� ISATAP,6TO4,Teredo,Tun
echo �������������װ
echo.
prompt $p$g
set devmgr_show_nonpresent_devices=1
start devmgmt.msc

pause
exit

:uninstall

title ����ж��ЭIPV6�� 
cls
echo �����ĵȴ�,������Ҫ���ɷ���
::ipv6 uninstall >nul
netsh interface ipv6 6to4 set state default default >nul
netsh interface ipv6 6to4 set routing default default >nul
netsh interface ipv6 6to4 set relay default >nul
netsh interface ipv6 isatap set state default >nul
netsh interface ipv6 isatap set router 0.0.0.0 >nul
netsh interface ipv6 isatap set state default >nul
netsh interface ipv6 isatap set router default >nul
netsh interface ipv6 set privacy state=enabled >nul
netsh interface ipv6 set teredo default >nul
netsh interface ipv6 set interface "��������" advertise=enabled >nul
netsh interface ipv6 reset >nul
cls
color 2e
echo IPV6Э��ж�����,�����������
pause
exit