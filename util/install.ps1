$uri="https://download.zerotier.com/dist/ZeroTierOne.msi"
$out="ZeroTierOne.msi"
Invoke-WebRequest -uri $uri -OutFile $out

$file = "ZeroTierOne.msi" 
$log = "install.log" 
$procMain = Start-Process "msiexec" "/i `"$file`" /qn /l*! `"$log`"" -NoNewWindow -PassThru
# $procLog = Start-Process "powershell" "Get-Content -Path `"$log`" -Wait" -NoNewWindow -PassThru 
$procMain.WaitForExit()
# $procLog.Kill()
