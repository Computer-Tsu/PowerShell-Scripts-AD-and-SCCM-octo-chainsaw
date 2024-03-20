<#
  https://deployhappiness.com/prevent-accidental-deletion/
  makes use of the Quest AD cmdlets
#>
Get-QADObject -searchroot 'DC=Test,DC=local' -type 'group' -SizeLimit 0|
Add-QADPermission -Deny -Account ‘EVERYONE’ -Right ‘Delete,DeleteTree’ -ApplyTo ThisObjectOnly
