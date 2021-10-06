#Workspaces: Get, Count, Filter, Group, Backup, Export
Get-TFWorkspace
Get-TFWorkspace | Measure
Get-TFWorkspace | Out-GridView

Get-TFWorkspace | where Name -like *tony*
Get-TFWorkspace | ? name -like *prd
gtfw | ? name -like *prd | measure

Get-TFWorkspace | group terraform-version -NoElement
Get-TFWorkspace | group branch -NoElement

Get-TFWorkspace | Export-Clixml z:\backup.xml
$Backup = Import-Clixml z:\backup.xml
$Backup | select -first 5
$Backup[0] | Format-List *

Get-TFWorkspace | Export-Csv z:\export.csv -NoTypeInformation
. z:\export.csv


# Version Upgrade at Scale
Get-TFWorkspace | group terraform-version

Get-TFWorkspace | ? terraform-version -like 0.13.*
Get-TFWorkspace az-joann-dev | Set-TFWorkspace -TerraformVersion 1.0.8
Start-TFRun az-joann-dev

Get-TFWorkspace | ? terraform-version -like 0.13.*
Get-TFWorkspace | ? terraform-version -like 0.13.* | Set-TFWorkspace -TerraformVersion 1.0.8 -Confirm:$false

Get-TFWorkspace | ? terraform-version -like 0.13.*
$Backup | ? terraform-version -like 0.13.*


# Change Branch at scale
Get-TFWorkspace | ? name -like *john*
Get-TFWorkspace | ? name -like *john* | Set-TFWorkspace -Branch main
Get-TFWorkspace | ? name -like *john*