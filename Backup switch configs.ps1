<#
  https://deployhappiness.com/backup-switch-configurations-powershell/
  generate your switchlist file and to configure your TFTP server
  Ensure that your TFTP server has a subfolder named Configs
#>

$Server   = "192.168.0.10"
$Username = "administrator"
$Password = "password"
$Date = (Get-Date -UFormat "%Y-%m-%d")

Set-Location C:\putty\

$SwitchList = Import-Csv .\switchlist.csv | sort NodeName 

foreach ($Switch in $SwitchList){
$FilePath = "Configs\" + $Switch.NodeName + "\" 
$FileName = $Switch.IPAddress + "_" + $Date +".txt"

if ((Test-Path \\$Server\c$\TFTP-Root\$Filepath) -eq $false){New-Item -ItemType Directory -Name $Switch.NodeName -Path \\$Server\c$\TFTP-Root\Configs\}
 .\kitty.exe $Switch.IPAddress -ssh -v -l $Username -pw $Password -cmd "\s05 \n Copy Startup-Config tftp $Server $Filepath$FileName \n y \n logout \n y \n y \n y"
 sleep -Seconds 2
 }
