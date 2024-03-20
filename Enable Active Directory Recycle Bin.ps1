<#
  https://deployhappiness.com/please-enable-the-active-directory-recycle-bin/
  To restore the object, you can use the Get-ADObject cmdlet with the -includeDeletedObjects parameter and pass that information to the Restore-ADObject cmdlet. The easier way is to just launch the Active Directory Administrative Center on a 2012R2/Windows 8.1+ machine. Navigate to the Deleted Objects container under your domain.
#>

Get-ADOptionalFeature -Filter *

Enable-ADOptionalFeature –Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=TEST,DC=local' –Scope  ForestOrConfigurationSet –Target 'TEST.local'
