New-NetFirewallRule -DisplayName 'wlm' -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('80', '1433')

