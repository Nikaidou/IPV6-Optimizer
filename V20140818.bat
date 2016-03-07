@echo off&setlocal enabledelayedexpansion
MODE con: COLS=50 lines=7
TITLE V140518 By 真红酱
set schoolipv6=2001:da8:6005
cls
color ce
echo WIN7请右键以管理员身份运行
echo.
echo 确保标题栏左上角有管理员字样
echo.
pause

TITLE 脚本安装使用说明
cls

rem 版权说明禁止修改
echo =========关于版权=========
echo 该脚本归西南交通大学真红酱所有
echo 任何人可以以任何形式传播修改
pause

cls
echo =========关于安装=========
echo 若IPV4地址开头为192.168，请检查是否使用路由器
echo 使用路由器可能导致无法连接IPV6
echo 路由器不使用WAN端口即可当做集线器使用
pause

cls
echo =========安装注意=========
echo 使用纯IPV6环境请不要安装隧道
echo 隧道会走IPV4线路(流量)
pause

:begin
CLS
color 07
TITLE IPV6安装卸载
@echo [1] IPV6安装
@echo [9] IPV6卸载


set var=0
set /p var=请选择对应序号[?] 
if "%var%" == "9" goto uninstall

:install


cls
echo 请按勾选本地连接中IPV6协议
echo 并且IPV4与IPV6协议属性请选择自动获取IP地址
echo.
control netconnections
pause



title 正在优化网络
echo 请耐心等待,可能修要若干分钟
echo 请不用在意任何错误提示
echo 长时间无反应请重新运行脚本
ipv6 install >nul
cls
echo 请耐心等待,可能修要若干分钟
echo 请不用在意任何错误提示
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

netsh interface ipv6 set interface "本地连接" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "本地连接" advertise=disabled >nul
Netsh interface ipv6 add dns "本地连接" 2001:470:20::2 index=3 >nul
Netsh interface ipv6 add dns "本地连接" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "本地连接" 2001:4860:4860::8844 index=2 >nul

netsh interface ipv6 set interface "无线网络连接" routerdiscovery=enabled >nul
netsh interface ipv6 set interface "无线网络连接" advertise=disabled >nul
Netsh interface ipv6 add dns "无线网络连接" 2001:470:20::2 index=3 >nul
Netsh interface ipv6 add dns "无线网络连接" 2001:4860:4860::8888 index=1 >nul
Netsh interface ipv6 add dns "无线网络连接" 2001:4860:4860::8844 index=2 >nul

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
echo 优化网络完毕
echo 绿色代表IPV6可用
echo.
echo.
pause
cls
echo 点击查看,勾选显示隐藏设备
echo 删除网络适配器中的所有隧道适配器
echo 关键词 ISATAP,6TO4,Teredo,Tun
echo 按任意键结束安装
echo.
prompt $p$g
set devmgr_show_nonpresent_devices=1
start devmgmt.msc

pause
exit

:uninstall

title 正在卸载协IPV6议 
cls
echo 请耐心等待,可能修要若干分钟
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
netsh interface ipv6 set interface "本地连接" advertise=enabled >nul
netsh interface ipv6 reset >nul
cls
color 2e
echo IPV6协议卸载完毕,请重启计算机
pause
exit