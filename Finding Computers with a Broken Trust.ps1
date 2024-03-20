<#
  https://deployhappiness.com/finding-computers-with-a-broken-trust-relationship/
  If you set it to run once per week, change the value from -1 to -7
  looking for a system NETLOGON event ID 5722 on each DC
#>
Import-Module ActiveDirectory
Import-Module Microsoft.PowerShell.Management

$DateToStartSearch = (Get-Date).AddDays(-1)
$SMTPServer = ''
$From = ''
$To = ''
$Subject = 'Broken Trust - Image or rejoin to the domain'

$DCS = Get-ADDomainController -Filter * | Select HostName | sort Hostname

Clear-Variable NetLogonErrors -ErrorAction SilentlyContinue

foreach ($DC in $DCS){
    $NetLogonErrors += (Get-EventLog -LogName System -Source NETLOGON -ComputerName $DC.HostName -InstanceId 5722 -After $DateToStartSearch | 
                        select -ExpandProperty ReplacementStrings).trimend('$')
    }

$NetLogonErrors = $NetLogonErrors | select -Unique | sort 
$NetLogonErrors = $NetLogonErrors | Where-Object { $_ -ne "%%5" }
$NetLogonErrorsObjects = New-Object -TypeName PSObject -Property @{ComputerName = $NetLogonErrors} 


foreach ($NetLogonErrorsObject in $NetLogonErrorsObjects.ComputerName){

    if (((Get-ADComputer -Identity $NetLogonErrorsObject -Properties * | select -ExpandProperty PasswordLastSet) -gt $DateToStartSearch) -eq $False){
    Send-MailMessage -SmtpServer $SMTPServer -From $From -to $To -Subject $Subject -Body $NetLogonErrorsObject
    }
}
