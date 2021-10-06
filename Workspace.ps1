# Workspace: New, Copy, Remove
Start-Process 'https://app.terraform.io/app/pshdemo/workspaces?search=az-faheem'

New-TFWorkspace -Name 'az-faheem-dev' -TerraformVersion '1.0.8' -Repo 'pkelly808/hashiconf' -WorkingDirectory 'az-faheem' -Branch 'dev'

New-TFWorkspaceVariable -Name 'az-faheem-dev' -Key 'environment' -Value 'dev'
New-TFWorkspaceVariable -Name 'az-faheem-dev' -Key 'tags' -Value '["owner:me","cost:you"]' -HCL
New-TFWorkspaceVariable az-faheem-dev func_app 3

Copy-TFWorkspace -Name 'az-faheem-dev' -Destination 'az-faheem-prd' -Confirm:$false
Set-TFWorkspaceVariable -Name 'az-faheem-prd' -Key 'environment' -Value 'prd' -Confirm:$false

Get-TFWorkspace | ? Name -like 'az-faheem*' | Remove-TFWorkspace


# Workspace Variables: Get, New, Set, Remove
cls; Get-Command *-TFWorkspaceVariable

Get-TFWorkspaceVariable aws-fredy-dev
Get-TFWorkspaceVariable aws-fredy-tst

Remove-TFWorkspaceVariable aws-fredy-dev -Key labmbda_retry

Start-Process 'https://app.terraform.io/app/pshdemo/workspaces/aws-fredy-tst/variables'
New-TFWorkspaceVariable aws-fredy-tst -Key lambda_retry -Value 1

Set-TFWorkspaceVariable aws-fredy-tst -Key lambda_retry -Value 2


# Backup and view State
cls; Get-TFState aws-asif-dev

Get-TFState aws-asif-dev | Format-Table

$State = Get-TFState aws-asif-dev -Current

$State
$State.modules
$state.resources | Format-Table

Start-Process $State.'hosted-state-download-url'
Get-Content "$env:HOME/Downloads/$($State.stateid).tfstate"