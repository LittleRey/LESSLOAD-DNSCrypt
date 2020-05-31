:: LESSLOAD-DNSCrypt v1.0
@echo off
cd /d "C:\Program Files\dnscrypt-proxy-win64\"
echo x > "%Temp%\dnscrypt-check.txt"

::StopService
dnscrypt-proxy.exe -service stop
for /F "tokens=3,*" %%A in ('netsh interface show interface ^| find "Dedicated"') do (netsh int ipv4 set dns "%%B" dhcp && netsh int ipv6 set dns "%%B" dhcp)
ipconfig /flushdns

:OfflineTest
cls
echo [-Retest Connection-]
powershell -Command "Invoke-WebRequest https://pastebin.com/raw/RH3GW47Q -OutFile '%Temp%\dnscrypt-check.txt' -TimeoutSec 1"
for /F "delims=:" %%I in (%Temp%\dnscrypt-check.txt) do (if /I "czd" == "%%I" (echo x > "%Temp%\dnscrypt-check.txt" && GoTo OnlineRun) else (GoTo OfflineTest))

:OnlineRun
::StartService
::Don't forget edit script to your location
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/public-resolvers.md -OutFile 'C:\Program Files\dnscrypt-proxy-win64\public-resolvers.md'"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/public-resolvers.md.minisig -OutFile 'C:\Program Files\dnscrypt-proxy-win64\public-resolvers.md.minisig'"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/relays.md -OutFile 'C:\Program Files\dnscrypt-proxy-win64\relays.md'"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/relays.md.minisig -OutFile 'C:\Program Files\dnscrypt-proxy-win64\relays.md.minisig'"
dnscrypt-proxy.exe -service start
for /F "tokens=3,*" %%A in ('netsh interface show interface ^| find "Connected"') do (netsh int ipv4 set dns name="%%B" static 127.0.0.1 primary validate=no && netsh int ipv6 set dns name="%%B" static ::1 primary validate=no)
ipconfig /flushdns
::pause