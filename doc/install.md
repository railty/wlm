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
sudo pip3 install python-tds
sudo pip3 install bitarray

sudo apt-get install libreoffice-base-core libreoffice-calc openjdk-7-jdk

modify /usr/bin/soffice change to
SAL_ENABLE_FILE_LOCKING=0

#rabbitmq
sudo bash -c 'echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list'
curl http://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
apt-get update
sudo apt-get install rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_management
http://localhost:15672/.


RAILS_ENV=test bundle exec rake db:migrate


sudo apt-get install imagemagick -y
