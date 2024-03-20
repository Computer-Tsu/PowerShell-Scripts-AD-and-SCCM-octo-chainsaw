<#
  https://deployhappiness.com/please-enable-the-active-directory-recycle-bin/
#>

Get-ADOptionalFeature -Filter *

Enable-ADOptionalFeature –Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=TEST,DC=local' –Scope  ForestOrConfigurationSet –Target 'TEST.local'
