#schedule job
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:15
Register-ScheduledJob -Trigger $trigger -FilePath C:\sites\start-wsl.ps1 -Name start-wsl

Get-SchedledJob

#Unregister-ScheduledJob -Name start-wsl
