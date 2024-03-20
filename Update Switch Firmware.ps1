<#
  https://deployhappiness.com/update-switch-firmware-with-powershell/
  http://www.9bis.net/kitty/?page=Download
#>
$Time     = "23:00"
$Server   = "192.168.0.10"
$Username = "admin"
$Password = "password"

Set-Location C:\putty\

$SwitchList = Import-Csv .\switchlist.csv

foreach ($Switch in $SwitchList){

     if ($Switch.model -like "ProCurve Switch 2610*"){
    .\kitty.exe $Switch.IPAddress -ssh -v -l $Username -pw $Password -cmd "\s02 \n Copy tftp flash $Server 2610-R_11_112.swi \n y \n \s02 \n wri mem \n reload at $Time \n y \n logout \n y" -send-to-tray
    }

    if ($Switch.model -like "Procurve Switch 2620*"){
    .\kitty.exe $Switch.IPAddress -ssh -v -l $Username -pw $Password -cmd "\s02 \n Copy tftp flash $Server 2620_15_18_0007.swi \n y \n \s02 \n wri mem \n reload at $Time \n y \n logout \n y" -send-to-tray
    }
   sleep 3
}
