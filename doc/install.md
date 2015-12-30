#
gem uninstall tiny_tds
sudo apt-get install freetds-dev freetds-bin tdsodbc
or
brew install freetds
gem install tiny_tds

# windows port forwarding
##display
netsh interface portproxy show v4tov4
##add port forwarding
netsh interface portproxy add v4tov4 listenport=21050 listenaddress=192.168.168.210 connectport=1433 connectaddress=192.168.168.105
netsh interface portproxy add v4tov4 listenport=21051 listenaddress=192.168.168.210 connectport=21051 connectaddress=192.168.168.105
##delete port forwarding
rem netsh interface portproxy delete v4tov4 listenport=21050 listenaddress=192.168.168.210
rem netsh interface portproxy delete v4tov4 listenport=21051 listenaddress=192.168.168.210

you still need to open the firewall

#git branch
git branch jobs
git checkout jobs

git checkout master
git merge jobs

git branch -d jobs

git pull origin jobs
git push origin jobs

sudo apt-get install python3-pip
sudo pip3 install pyoo

sudo apt-get install libreoffice-base-core libreoffice-calc openjdk-7-jdk
