require 'tiny_tds'
#client = TinyTds::Client.new(username: 'po', password: 'prispo', host: 'WM11162.local', database: 'Pris', port: 1433, tds_version: 100)
client = TinyTds::Client.new(:username => 'po', :password => 'prispo', :host => 'WM11162.local', :port => '1433', :tds_version => 70)
print client
