#Workflow definition
workflow WorkflowDef
{
    Set-Content -Path C:\TEMP\Test.txt "It didn't work"
    Restart-Computer
    Start-Sleep -Seconds 60
    Set-Content -Path C:\TEMP\Test.txt "It worked!"
}

#Job scheduler options
$AtStartup = New-JobTrigger -AtStartup
$options = New-ScheduledJobOption -RunElevated -ContinueIfGoingOnBattery -StartIfOnBattery
$block = {[System.Management.Automation.Remoting.PSSessionConfigurationData]::IsServerManager = $true; Import-Module PSWorkflow; Resume-Job -Name WorkflowJob | Wait-Job}

Register-ScheduledJob -Name ScheduledJob -Trigger $AtStartup -ScriptBlock $block -ScheduledJobOption $options

WorkflowDef -AsJob -JobName WorkflowJob