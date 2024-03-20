<#
  https://deployhappiness.com/finding-and-deleting-unlinked-gpos-with-powershell/
  Before deleting anything, we use the backup-gpo cmdlet to save a copy of our GPO to C:\Users\Public\GPOBackups.
  For our records, we also use the Out-File cmdlet to generate a text file of any GPO that is unlinked. Finally, we use the remove-gpo cmdlet to delete the GPO.
#>
Get-GPO -All | Sort-Object displayname | Where-Object { If ( $_ | Get-GPOReport -ReportType XML | Select-String -NotMatch "<LinksTo>" )
{
Backup-GPO -name $_.DisplayName -path C:\Users\Public\GPOBackups
$_.DisplayName | Out-File .\UnLinkedGPOS.txt -Append
$_.Displayname | remove-gpo -Confirm
}}
