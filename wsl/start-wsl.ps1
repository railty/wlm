wsl -d Ubuntu-18.04 -u sning /bin/bash -lc /etc/start-rails
$wsl_ip = (wsl hostname -I).split(" ")[0]
Write-Output netsh interface portproxy add v4tov4 listenport=80 connectport=3000 connectaddress=$wsl_ip
netsh interface portproxy add v4tov4 listenport=80 connectport=3000 connectaddress=$wsl_ip

