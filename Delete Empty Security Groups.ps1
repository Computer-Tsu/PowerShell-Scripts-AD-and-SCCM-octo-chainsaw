<#
  https://deployhappiness.com/delete-empty-security-groups/
#>
Get-qadgroup -SearchRoot "DC=Test,DC=local" -SearchScope Subtree -empty $true | Remove-QADObject -whatif
