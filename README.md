# DNSCrypt installer & reloader

cmd script automatic detect internet and start. one click base to re-run dnscrypt-proxy.

1. download `dnscrypt-proxy-win64-x.x.x.zip` ( [source](https://github.com/DNSCrypt/dnscrypt-proxy/releases/) ) and place `win64` folder same directory as `lessload-installer.bat`<br/> (Modify needed in Windows 32bit)

2. run `lessload-installer.bat` _[run as admin]_ to install <br/>(it will install loopback to all interface & block all internet by default)

3. config your `dnscrypt-proxy.toml` and other.

4. one click `re-dnscrypt.bat` _[run as admin]_ to check internet and start dnscrypt, script will automatic detect internet or wait for you to login through Web Portal and run dnscrypt-proxy.

( recommend you to run script before connect wifi , Web Captive Portal will not show _in some case_ if you run script after connect wifi )<br/>
( no need to stop service just restart to get internet connection back )

** Windows 10 v2004 or above **
- you need to enable NCSI Active Probing, detail in [Other problem](https://github.com/lessload/LESSLOAD-DNSCrypt#other-problem)
- modify NCSI server got NCSI problem in some case.
## Pro
- support Web Captive Portal, Normally `dnscrypt-proxy` may break web portal in many case.
- easy to re-run dnscrypt-proxy by run `re-dnscrypt.bat` _[run as admin]_
- just script, no need more resource usage.
- less DNS traffic leak ( `just 5s` `nearly 0 if you use static sdns://` )
- clean.

## Con
- you need to config *.toml manual. ( [From this manual](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Configuration) )
- Request PowerShell or Curl, work on Windows 8 or above.

## Other problem
- some anti-virus may block PowerShell to connect the internet. make it allow.
- disable DNS Client service `(dnscache)` in windows will break internet connection of UWP apps, not recommend to do that.
- Public wifi got NCSI problem on Windows 10 v2004 or above. [for now. fix by run this in cmd `reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "1" /f` , need better way to fix this issue]

## v2 note
- change script to download resolver before start `dnscrypt-proxy` to prevent `dnscrypt-proxy` stop it self when resolver was outdated.
- change `powershell` to `curl` to download resolver. this improve speed and reduce cpu impact<br/>
  ( on Intel Atom `Invoke-WebRequest` make cpu ran at 100% speed, for `curl` run only 70% )<br/>
  ( in old Windows OS, you may need to install curl itself [official link here](https://curl.haxx.se/windows/) )
  
## _DNS restrict + NCSI problem_
_In case of public wifi that restrict DNS_<br/>
If you do not use your device too long, and `*.md` was outdate and 127.0.0.1 is still DNS of windows.
`dnscrypt-proxy` will fail to update and stop themself. That why i make this script.
This script will help you to fastly connect to your DNSCrypt as possible and set loopback, to prevent some DNS traffic leak.

  ( _temporary fix_ it by custom timout between script, as in `re-dnscrypt.bat` )<br/>
  ( to _fix it without_ custom timeout, your need to static `sdns://` in `dnscrypt-proxy.toml` )<br/>
  ( use `lessload-installer.bat` to reduce NCSI poll period before run `re-dnscrypt.bat` )<br/>
  _dnscrypt-proxy update method use or trust in [Microsoft NCSI](https://answers.microsoft.com/en-us/windows/forum/windows_10-networking/network-connection-status-indicator-ncsi-showing/02664ddf-4eac-449a-8318-bdae1a5bad3d) make it got problem_<br/>

_Why NCSI is so importance. Because if your pc got NCSI alert it will break many function in windows <br/>example -UWP-internet -Hotspot_

## _Cool NCSI solution_
- https://github.com/dantmnf/NCSIOverride <br/>( not test it yet, one day Microsoft will prevent this thing to work because of security or telemetry reason. maybe )

## My network test condition
- restrict dns by router for make it seem like some public wifi ( `dnscrypt-proxy` pain point.! )
- block all Microsoft server (host & IP) for make it seem like company network, and test how NCSI really works.

-----------------------------------------
***Please advice me to make code more stable.***  - LESSLOAD
