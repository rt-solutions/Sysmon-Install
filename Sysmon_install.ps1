# RT Solutions
# v1 4-15-23
### 
$serviceName = 'sysmon64'

$path = "C:\temp\"
try {
    $Current_Version = (Get-Command C:\windows\sysmon64.exe).FileVersionInfo.ProductVersion
} catch {
    $Current_Version = 0
}
If(!(test-path $path))
{
New-Item -ItemType Directory -Force -Path $path
}
cd C:\temp\
### DL Sysmon
rm C:\temp\sysmon*
invoke-webrequest "https://download.sysinternals.com/files/Sysmon.zip" -OutFile C:\temp\Sysmon.zip

### Unzip
Expand-Archive C:\temp\Sysmon.zip -DestinationPath C:\temp\ -force
$DL_Version = (Get-Command C:\temp\sysmon64.exe).FileVersionInfo.ProductVersion

if ($Current_Version -lt $DL_Version) {
#$Current_Version = (Get-Command C:\windows\sysmon64.exe).FileVersionInfo.ProductVersion

write-host "Sysmon Update needed, current version is $Current_Version, updating to $DL_Version." -ForegroundColor Green
### DL Config File
wget "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile C:\windows\sysmonconfig.xml 
### Uninstall Sysmon
C:\windows\sysmon64.exe -u

### Install Sysmon
C:\temp\sysmon64.exe /accepteula -i c:\windows\sysmonconfig.xml
Write-host "Up to date, version" (Get-Command C:\windows\sysmon64.exe).FileVersionInfo.ProductVersion
### Cleanup
rm C:\temp\sysmon*
} else {
    Write-Output "Sysmon up to date"
}
