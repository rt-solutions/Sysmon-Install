### Make temp folder
$path = "C:\temp\"
If(!(test-path $path))
{
New-Item -ItemType Directory -Force -Path $path
}
### Check for service and if not install
$serviceName = 'sysmon64'
If (-not(Get-Service $serviceName)){
### DL Sysmon
invoke-webrequest "https://ewr1.vultrobjects.com/hosted/Sysmon64.exe" -OutFile C:\temp\Sysmon64.exe
wget "https://ewr1.vultrobjects.com/hosted/sysmonconfig.xml" -OutFile C:\windows\sysmonconfig.xml 
# Install Sysmon
C:\temp\Sysmon64.exe /accepteula -i c:\windows\sysmonconfig.xml
 }