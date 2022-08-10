#schedule job
$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:15
Register-ScheduledJob -Trigger $trigger -FilePath C:\sites\netsh.ps1 -Name netsh
