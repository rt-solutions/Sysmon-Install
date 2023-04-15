# RT Solutions
# v1 4-15-23
### Make temp folder
$path = "C:\temp\"
If(!(test-path $path))
{
New-Item -ItemType Directory -Force -Path $path
}
cd C:\temp\
### Check for service and if not install
$serviceName = 'sysmon64'
If (-not(Get-Service $serviceName)){
### DL Sysmon
invoke-webrequest "https://download.sysinternals.com/files/Sysmon.zip" -OutFile C:\temp\Sysmon.zip
### Unzip
Expand-Archive C:\temp\Sysmon.zip -DestinationPath C:\temp\ -force
### DL Config File
wget "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile C:\windows\sysmonconfig.xml 
# Install Sysmon
C:\temp\Sysmon64.exe /accepteula -i c:\windows\sysmonconfig.xml
### Cleanup
rm C:\temp\sysmon*
 }
 else {write-host "Sysmon Already Installed"}
 
