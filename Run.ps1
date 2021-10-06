# Get all current Run Status.  Group and Filter.  Discard all stale plans
$run = Get-TFWorkspace | foreach {Get-TFRun $_.Name -Current}
$run

$run | group status -NoElement
$run | ? Status -ne 'applied'
$run | ? Status -eq 'planned'
$run | ? Status -eq 'planned' | ? created-at -lt (Get-Date).AddDays(-3)

Start-Process 'https://app.terraform.io/app/pshdemo/workspaces?filter=cost_estimated%2Cplanned%2Cpolicy_checked%2Cpolicy_override'

help Set-TFRun
$run | ? Status -eq 'planned' | Set-TFRun -Action discard


# Discard Run > Lock Workspace > Start Run > Unlock Workspace > Apply Plan
Get-TFRun aws-asif-stg
Get-TFRun aws-asif-stg -Current

Start-Process 'https://app.terraform.io/app/pshdemo/workspaces?search=aws-asif-stg'

Lock-TFWorkspace aws-asif-stg

Start-TFRun aws-asif-stg -Message 'running plan while locked'

Get-TFRun aws-asif-stg -Current

Unlock-TFWorkspace aws-asif-stg -Confirm:$false
Get-TFRun aws-asif-stg -Current | Set-TFRun -Action apply

Start-Process 'https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#Instances:instanceState=running'


# Lock/Unlock all production workspaces
Get-TFWorkspace | select -First 5
Get-TFWorkspace | select -First 1 | Format-List *
Get-TFWorkspace | ? Locked -eq $true

Start-Process 'https://app.terraform.io/app/pshdemo/workspaces?search=-prd'

Get-TFWorkspace | ? Name -like '*prd' | Lock-TFWorkspace
Get-TFWorkspace | ? Locked -eq $true

Unlock-TFWorkspace gcp-oscar-prd
Get-TFWorkspace | ? Locked -eq $true | Unlock-TFWorkspace -Confirm:$false