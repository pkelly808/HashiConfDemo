# Commands
Import-Module Terraform

Get-Command -Module Terraform
Get-Alias | ? Source -eq Terraform

Get-Command *-TFWorkspace
Get-Command *-TFRun

Connect-Terraform -Server 'app.terraform.io' -Org 'pshdemo' -Terracreds